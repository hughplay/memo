import argparse
import sys
import traceback
from itertools import chain
from pathlib import Path

import jsonlines
import ray

from ray_tools import split_list, ProgressBar


N_GPU_PER_THREAD = 0
N_CPU_PER_THREAD = 2


def read_jobs(args):
    jobs = []
    # read jobs
    return jobs


def is_completed(job, args):
    # pass
    return False


@ray.remote(num_cpus=N_CPU_PER_THREAD, num_gpus=N_GPU_PER_THREAD)
def process_jobs(i, jobs, args, actor):
    print(f"Jobs on thread #{i}: {len(jobs)}")

    results = []
    for job in jobs:
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
        pass
    return {}


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        formatter_class=argparse.ArgumentDefaultsHelpFormatter
    )

    parser.add_argument("-i", type=str, required=True, dest="input_dir")
    parser.add_argument("-o", type=str, required=True, dest="output_dir")

    parser.add_argument("--split", type=int, default=1, help="number of splits")
    parser.add_argument(
        "--cpu", type=int, default=1, help="number of cpu per split"
    )
    parser.add_argument(
        "--gpu", type=float, default=0, help="number of gpu per split"
    )

    args = parser.parse_args()
    Path(args.output_dir).mkdir(parents=True, exist_ok=True)

    jobs = read_jobs(args)
    if len(jobs) > 0:
        print(f"-----------------")
        print(f"Total jobs: {len(jobs)}")

        N_CPU_PER_THREAD = args.cpu
        N_GPU_PER_THREAD = args.gpu
        n_split = min(len(jobs), args.split)
        total_cpus = N_CPU_PER_THREAD * n_split
        total_gpus = N_GPU_PER_THREAD * n_split
        ray.init(num_cpus=total_cpus, num_gpus=total_gpus)
        print(f"Number of splits: {n_split}.")
        print(f"CPUs per split: {N_CPU_PER_THREAD}.")
        print(f"Total CPUs: {total_cpus}.")
        if N_GPU_PER_THREAD > 0:
            print(f"GPUs per split: {N_GPU_PER_THREAD}.")
            print(f"Total GPUs: {total_gpus}.")
        print(f"-----------------")

        jobs_chunks = split_list(jobs, n_split)

        pb = ProgressBar(len(jobs))
        actor = pb.actor
        job_list = []
        for i in range(n_split):
            job_list.append(
                process_jobs.remote(i, jobs_chunks[i], args, actor)
            )

        pb.print_until_done()
        job_results = list(chain(*ray.get(job_list)))
        ray.get(actor.get_counter.remote())

        result_path = Path(args.output_dir) / "result.jsonl"
        with jsonlines.open(result_path, "w") as writer:
            writer.write_all(job_results)
    else:
        print(f"No job to run.")

