#!/usr/bin/env bash
set -e

VERSION=3.2a
LIBEVENT_VERSION=2.1.12
NCURSES_VERSION=6.2
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
wget -O libevent-stable.tar.gz https://github.com/libevent/libevent/releases/download/release-${LIBEVENT_VERSION}-stable/libevent-${LIBEVENT_VERSION}-stable.tar.gz
wget -O ncurses-${NCURSES_VERSION}.tar.gz https://mirrors.tuna.tsinghua.edu.cn/gnu/ncurses/ncurses-${NCURSES_VERSION}.tar.gz --no-check-certificate

# extract files, configure, and compile

############
# libevent #
############
echo "Processing libevent..."
tar xvzf libevent-stable.tar.gz
cd libevent-${LIBEVENT_VERSION}-stable
./configure --prefix=${PREFIX} --disable-shared
make -j
make install
cd ..

############
# ncurses  #
############
echo "Processing ncurses..."
tar xvzf ncurses-${NCURSES_VERSION}.tar.gz
cd ncurses-${NCURSES_VERSION}
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
./configure --prefix=${PREFIX} CFLAGS="-I${PREFIX}/include -I${PREFIX}/include/ncurses" LDFLAGS="-L${PREFIX}/lib -L${PREFIX}/include/ncurses -L${PREFIX}/include"
CPPFLAGS="-I${PREFIX}/include -I${PREFIX}/include/ncurses" LDFLAGS="-static -L${PREFIX}/include -L${PREFIX}/include/ncurses -L${PREFIX}/lib"
make -j
make install
cd ..

# cleanup
rm -rf /tmp/tmux
cd $START

echo "tmux is installed at ${PREFIX}/bin/tmux"
