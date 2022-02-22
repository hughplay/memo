#!/usr/bin/env bash
set -e

VERSION=2.8
PREFIX=/usr/local/

START=`pwd`

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -v|--version) VERSION="$2"; shift ;;
        -p|--prefix) PREFIX="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# install dependencies
sudo apt-get install \
  automake \
  autotools-dev \
  libevent-dev \
  libncurses-dev \
  pkg-config

# prepare directories
mkdir -p ${PREFIX} /tmp/tmux
cd /tmp/tmux

echo "Downloading..."
wget -O tmux-${VERSION}.tar.gz https://github.com/tmux/tmux/releases/download/${VERSION}/tmux-${VERSION}.tar.gz

echo "Processing tmux..."
tar xvzf tmux-${VERSION}.tar.gz
cd tmux-${VERSION}
./configure --prefix=${PREFIX}
make -j
make install
cd ..

# cleanup
rm -rf /tmp/tmux
cd $START

echo "tmux is installed at ${PREFIX}/bin/tmux"
