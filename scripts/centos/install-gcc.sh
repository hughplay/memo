# https://gcc.gnu.org/mirrors.html https://mirrors.ustc.edu.cn/gnu/gcc/
# https://gcc.gnu.org/wiki/InstallingGCC

wget https://mirrors.ustc.edu.cn/gnu/gcc/gcc-6.5.0/ -O /tmp/gcc-6.5.0
tar xzf gcc-4.6.2.tar.gz
cd gcc-4.6.2
./contrib/download_prerequisites
# cd ..
# mkdir objdir
# cd objdir
# $PWD/../gcc-4.6.2/configure --prefix=$HOME/GCC-4.6.2 --enable-languages=c,c++,fortran,go --disable-multilib
mkdir build
cd build
./configure --disable-multilib
make
make install
