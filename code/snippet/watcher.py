"""
This script will wait for executing the <command> until the condition is achieved.

Usage: python watch.py <type>:<target> "<command> [--gap <seconds>] [--reverse]"

For example:

1. Waiting until the target file exists:
# python watch.py f:test "ls -l" --gap 1

2. Waiting until the process with pid 1 disappears:
# python watch.py p:1 "ls -l" --gap 1 --reverse

"""
import argparse
import os
import subprocess
import signal
import time


def main(args):
    print("Waiting to run: \n# {}".format(args.command))
    print("Checking {} every {} seconds...".format(args.target, args.gap))

    try:
        _type, value = args.target.split(":")
    except:
        raise NotImplementedError("The format of target is <type>:<value>")

    while True:
        if _type in ["f", "file"]:
            result = os.path.isfile(value)
        elif _type in ["p", "pid"]:
            try:
                os.kill(int(value), 0)
            except OSError:
                result = False
            else:
                result = True
        else:
            raise NotImplementedError("Unknown type: {}.".format(_type))

        if result ^ args.reverse:
            execute(args.command)
            break

        time.sleep(args.gap)


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
    parser.add_argument("target")
    parser.add_argument("command")
    parser.add_argument("--gap", default=300, type=int)
    parser.add_argument("--reverse", action="store_true")

    args = parser.parse_args()
    main(args)
