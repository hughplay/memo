#!/usr/bin/env bash
set -e

VERSION=${version:-6.5.0}
PREFIX=${prefix:-/usr/local/}
JOB=${job:-`nproc`}

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

echo "Downloading gcc-${VERSION}...""
cd /tmp
wget https://mirrors.ustc.edu.cn/gnu/gcc/gcc-${VERSION}/gcc-${VERSION}.tar.gz -O gcc-${VERSION}.tar.gz
echo 'Decompressing into gcc-${VERSION}...'
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
echo '$PREFIX/bin/gcc is installed.'
