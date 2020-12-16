# Processing a series of files, eg: compress videos
from subprocess import run
from glob imoprt glob
import os
root = '.'
videos = glob(os.path.join(root, '*.avi'))
for video in videos:
    output = video.replace('.avi', '.compress.avi')
    run('ffmpeg -i %s -c:v libx264 -crf 24 -b:v 1M -c:a aac -strict -2 %s' % (video, output))

# Dispose Exceptions
# `Exception` won't catch KeyboardInterrupt 
# `BaseException` catches any exception
try:
    do_something()
except Exception as e:
    logger.error('Failed to do something: ' + str(e))

# Understanding nested list comprehension syntax in Python
# https://spapas.github.io/2016/04/27/python-nested-list-comprehensions/
non_flat = [ [1,2,3], [4,5,6], [7,8] ]
[ y for x in non_flat if len(x) > 2 for y in x ]
# [1, 2, 3, 4, 5, 6]

# scope of list comprehension in class
# https://stackoverflow.com/questions/13905741/accessing-class-variables-from-a-list-comprehension-in-the-class-definition
class A:
    x = 4
    y = [x+i for i in range(1)]
# NameError: name 'x' is not defined
class A:
    x = 4
    y = (lambda x=x: [x+i for i in range(1)])()

# https://docs.python.org/3/reference/datamodel.html#emulating-numeric-types
