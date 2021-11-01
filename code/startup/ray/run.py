import argparse
import sys
import time
import traceback
from itertools import chain
from pathlib import Path

import jsonlines
import ray
from ray.util.queue import Queue

sys.path.append(".")
from utils.ray_tools import ProgressBar


N_GPU_PER_THREAD = 0
N_CPU_PER_THREAD = 2


def read_jobs(args):
    jobs = list(range(10))
    return jobs


def is_completed(job, args):
    # pass
    return False


@ray.remote(num_cpus=N_CPU_PER_THREAD, num_gpus=N_GPU_PER_THREAD)
def process_jobs(jobs_queue, args, actor):
    results = []
    while not jobs_queue.empty():
        job = jobs_queue.get()
        try:
            result = execute_one_job(job, args, actor)
            if result is not None:
                results.append(result)
        except:
            print(f"failed: {job}")
            traceback.print_exception(*sys.exc_info())
        actor.update.remote(1)
    return results


def execute_one_job(job, args, actor):
    if is_completed(job, args):
        pass
    else:
        res = job ** 2
        time.sleep(1)
    return {"job": job, "result": res}


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        formatter_class=argparse.ArgumentDefaultsHelpFormatter
    )

    parser.add_argument("-i", type=str, required=True, dest="input_dir")
    parser.add_argument("-o", type=str, required=True, dest="output_dir")

    parser.add_argument("--thread", type=int, default=1, help="number of threads")
    parser.add_argument(
        "--cpu", type=int, default=1, help="number of cpu per thread"
    )
    parser.add_argument(
        "--gpu", type=float, default=0, help="number of gpu per thread"
    )

    args = parser.parse_args()
    Path(args.output_dir).mkdir(parents=True, exist_ok=True)

    jobs = read_jobs(args)
    if len(jobs) > 0:
        print(f"-----------------")
        print(f"Total jobs: {len(jobs)}")

        N_CPU_PER_THREAD = args.cpu
        N_GPU_PER_THREAD = args.gpu
        n_thread = min(len(jobs), args.thread)
        total_cpus = N_CPU_PER_THREAD * n_thread
        total_gpus = N_GPU_PER_THREAD * n_thread
        ray.init(num_cpus=total_cpus, num_gpus=total_gpus)
        print(f"Number of threads: {n_thread}.")
        print(f"CPUs per thread: {N_CPU_PER_THREAD}.")
        print(f"Total CPUs: {total_cpus}.")
        if N_GPU_PER_THREAD > 0:
            print(f"GPUs per thread: {N_GPU_PER_THREAD}.")
            print(f"Total GPUs: {total_gpus}.")
        print(f"-----------------")

        jobs_queue = Queue()
        for job in jobs:
            jobs_queue.put(job)
        pb = ProgressBar(len(jobs_queue))
        actor = pb.actor
        job_list = []
        for _ in range(n_thread):
            job_list.append(process_jobs.remote(jobs_queue, args, actor))

        pb.print_until_done()
        job_results = list(chain(*ray.get(job_list)))
        ray.get(actor.get_counter.remote())

        result_path = Path(args.output_dir) / "result.jsonl"
        with jsonlines.open(result_path, "w") as writer:
            writer.write_all(job_results)
    else:
        print(f"No job to run.")
