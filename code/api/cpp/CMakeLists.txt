cmake_minimum_required(VERSION 2.8)
project( operation )
add_executable( operation operation.cpp )
set(CMAKE_CXX_FLAGS "-O3 -std=c++11 -Wall -ffast-math -msse2")
