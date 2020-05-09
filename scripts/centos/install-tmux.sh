#!/bin/bash

# Script for installing tmux on systems where you don't have root access.
# tmux will be installed in $HOME/.local/bin.
# It's assumed that wget and a C/C++ compiler are installed.

# exit on error
set -e

TMUX_VERSION=2.8

# create our directories
mkdir -p $HOME/.local /tmp/tmux
cd /tmp/tmux

# download source files for tmux, libevent, and ncurses
echo "Downloading..."
wget -O tmux-${TMUX_VERSION}.tar.gz https://github.com/tmux/tmux/archive/${TMUX_VERSION}.tar.gz
wget -O libevent-2.0.19-stable.tar.gz https://github.com/downloads/libevent/libevent/libevent-2.0.19-stable.tar.gz
wget -O ncurses-5.9.tar.gz https://mirrors.tuna.tsinghua.edu.cn/gnu/ncurses/ncurses-5.9.tar.gz

# extract files, configure, and compile

############
# libevent #
############
echo "Processing libevent..."
tar xvzf libevent-2.0.19-stable.tar.gz
cd libevent-2.0.19-stable
./configure --prefix=$HOME/.local --disable-shared
make -j
make install
cd ..

############
# ncurses  #
############
echo "Processing ncurses..."
tar xvzf ncurses-5.9.tar.gz
cd ncurses-5.9
./configure --prefix=$HOME/.local
make -j
make install
cd ..

############
# tmux     #
############
echo "Processing tmux..."
tar xvzf tmux-${TMUX_VERSION}.tar.gz
cd tmux-${TMUX_VERSION}
./autogen.sh
./configure CFLAGS="-I$HOME/.local/include -I$HOME/.local/include/ncurses" LDFLAGS="-L$HOME/.local/lib -L$HOME/.local/include/ncurses -L$HOME/.local/include"
CPPFLAGS="-I$HOME/.local/include -I$HOME/.local/include/ncurses" LDFLAGS="-static -L$HOME/.local/include -L$HOME/.local/include/ncurses -L$HOME/.local/lib" make
cp tmux $HOME/.local/bin
cd ..

# cleanup
rm -rf /tmp/tmux

echo "$HOME/.local/bin/tmux is now available. You can optionally add $HOME/.local/bin to your PATH."
