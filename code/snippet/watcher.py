"""
This script will wait for executing the <command> until the <file> is created.
Usage: python watch.py <file> "<command>"
"""
import argparse
import os
import subprocess
import signal
import time


def main(args):
    print("Waiting to run: \n# {}".format(args.command))
    print("Checking {} every {} seconds...".format(args.file, args.check))
    while True:
        if os.path.isfile(args.file):
            execute(args.command)
            break
        time.sleep(args.check)


def execute(command):
    print(command)
    print()
    p = subprocess.Popen(command, shell=True)
    try:
        p.wait()
    except KeyboardInterrupt:
        try:
            os.kill(p.pid, signal.SIGINT)
        except OSError:
            pass
        p.wait()


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("file")
    parser.add_argument("command")
    parser.add_argument("--check", default=300, type=int)

    args = parser.parse_args()
    main(args)
