#!/usr/bin/env bash

set -eu

export PREFIX=$KERNEL_TOOLCHAIN_PREFIX
export TARGET=x86_64-elf
export PATH="$PREFIX/bin:$PATH"

# binutils
cd $BINUTILS_REPO_PATH
mkdir -p build-binutils
cd build-binutils
../configure \
    --target=$TARGET \
    --prefix=$PREFIX/binutils \
    --with-sysroot \
    --disable-nls \
    --disable-werror
make -j $(nproc)
make install

# gcc
cd $GCC_REPO_PATH
mkdir -p gcc-build
cd gcc-build
../configure \
    --target=$TARGET \
    --prefix=$PREFIX/gcc \
    --disable-nls \
    --enable-languages=c,c++ \
    --without-headers \
    --with-as=$PREFIX/binutils/bin/x86_64-elf-as
make -j $(nproc) all-gcc
make install-gcc
