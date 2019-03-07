# You should modify the variable below if need
# https://docs.opencv.org/3.4/d7/d9f/tutorial_linux_install.html
VERSION='3.4.5'

sudo apt-get install -y \
    build-essential \
    cmake \
    git \
    libgtk2.0-dev \
    pkg-config \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    aria2

mkdir -p ~/tmp/opencv && cd ~/tmp/opencv && \
aria2c https://github.com/opencv/opencv/archive/${VERSION}.tar.gz && \
tar -zxvf opencv-${VERSION}.tar.gz && \
cd opencv-${VERSION}

mkdir build && cd build

# ~/.local can be used directly by `conda`
mkdir -p ~/.local/bin ~/.local/include ~/.local/lib ~/.local/share && \
cmake \
    -D CMAKE_BUILD_TYPE=Release \
    -D CMAKE_INSTALL_PREFIX=~/.local \
    -D PYTHON2_EXECUTABLE=$(which python2) \
    -D PYTHON3_EXECUTABLE=$(which python3) .. && \
make -j $(nproc) && \
make install
