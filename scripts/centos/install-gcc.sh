#!/usr/bin/env bash
set -e

VERSION=6.5.0
PREFIX=/usr/local/
JOB=`nproc`
MIRROR=https://mirrors.tuna.tsinghua.edu.cn/gnu/gcc

START=`pwd`

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -v|--version) VERSION="$2"; shift ;;
        -p|--prefix) PREFIX="$2"; shift ;;
        -j|--job) JOB="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

echo "Downloading gcc-${VERSION}..."
cd /tmp
wget ${MIRROR}/gcc-${VERSION}/gcc-${VERSION}.tar.gz -O gcc-${VERSION}.tar.gz
echo "Decompressing into gcc-${VERSION}..."
tar xzf gcc-${VERSION}.tar.gz
cd gcc-${VERSION}

echo "Downloading dependencies..."
./contrib/download_prerequisites

echo "Building..."
mkdir build
cd build
../configure --disable-multilib --prefix $PREFIX
make -j $JOB
make install

cd $START
echo "$PREFIX/bin/gcc is installed."
