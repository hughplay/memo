cmake_minimum_required( VERSION 3.0 )

project( viewer )

include_directories( ./include ./src )

add_executable( viewer src/main.cpp src/viewer.cpp )

find_package( OpenCV REQUIRED )
find_package( Boost COMPONENTS program_options REQUIRED )

target_link_libraries( viewer ${OpenCV_LIBS} ${Boost_LIBRARIES} )

set(CMAKE_CXX_FLAGS "-O3 -std=c++11 -Wall -ffast-math -msse2")
