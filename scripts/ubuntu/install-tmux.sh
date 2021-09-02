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

# prepare directories
mkdir -p ${PREFIX} /tmp/tmux
cd /tmp/tmux

# download source files for tmux, libevent, and ncurses
echo "Downloading..."
wget -O tmux-${VERSION}.tar.gz https://github.com/tmux/tmux/releases/download/${VERSION}/tmux-${VERSION}.tar.gz
wget -O libevent-2.0.19-stable.tar.gz https://github.com/downloads/libevent/libevent/libevent-2.0.19-stable.tar.gz
wget -O ncurses-5.9.tar.gz https://mirrors.tuna.tsinghua.edu.cn/gnu/ncurses/ncurses-5.9.tar.gz --no-check-certificate

# extract files, configure, and compile

############
# libevent #
############
echo "Processing libevent..."
tar xvzf libevent-2.0.19-stable.tar.gz
cd libevent-2.0.19-stable
./configure --prefix=${PREFIX} --disable-shared
make -j
make install
cd ..

############
# ncurses  #
############
echo "Processing ncurses..."
tar xvzf ncurses-5.9.tar.gz
cd ncurses-5.9
./configure --prefix=${PREFIX}
make -j
make install
cd ..

############
# tmux     #
############
echo "Processing tmux..."
tar xvzf tmux-${VERSION}.tar.gz
cd tmux-${VERSION}
./autogen.sh
./configure --prefix=${PREFIX} CFLAGS="-I${PREFIX}/include -I${PREFIX}/include/ncurses" LDFLAGS="-L${PREFIX}/lib -L${PREFIX}/include/ncurses -L${PREFIX}/include"
CPPFLAGS="-I${PREFIX}/include -I${PREFIX}/include/ncurses" LDFLAGS="-static -L${PREFIX}/include -L${PREFIX}/include/ncurses -L${PREFIX}/lib"
make -j
make install
cd ..

# cleanup
rm -rf /tmp/tmux
cd $START

echo "tmux is installed at ${PREFIX}/bin/tmux"
