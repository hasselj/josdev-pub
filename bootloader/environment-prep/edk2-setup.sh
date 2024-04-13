#!/usr/bin/env bash

set -e

# for non x86-64 systems, install necessary tools
if [[ ! $(uname -m | grep 'x86_64') ]]; then
    sudo apt-get install -y \
        gcc-x86-64-linux-gnu \
        binutils-x86-64-linux-gnu
fi

git clone --depth=1 --branch $EDK2_REPO_TAG $EDK2_REPO_URL $EDK2_REPO_PATH
git config --global --add safe.directory $EDK2_REPO_PATH

cd $EDK2_REPO_PATH
git submodule update --init
make -C BaseTools

# cache one complete build of EDK2

# if we are cross building
if [[ ! $(uname -m | grep 'x86_64') ]]; then
    sudo ln -s /usr/bin/x86_64-linux-gnu-gcc /usr/local/bin/gcc && \
    sudo ln -s /usr/bin/x86_64-linux-gnu-gcc-ar /usr/local/bin/ar && \
    sudo ln -s /usr/bin/x86_64-linux-gnu-gcc-nm /usr/local/bin/nm && \
    sudo ln -s /usr/bin/x86_64-linux-gnu-objcopy /usr/local/bin/objcopy && \
    sudo ln -s /usr/bin/x86_64-linux-gnu-ranlib /usr/local/bin/ranlib
fi

. edksetup.sh
build \
--platform=MdeModulePkg/MdeModulePkg.dsc \
--arch=X64 \
--buildtarget=DEBUG \
--tagname=GCC

# remove symlinks
if [[ ! $(uname -m | grep 'x86_64') ]]; then
    sudo rm /usr/local/bin/gcc && \
    sudo rm /usr/local/bin/ar && \
    sudo rm /usr/local/bin/nm && \
    sudo rm /usr/local/bin/objcopy && \
    sudo rm /usr/local/bin/ranlib
fi
