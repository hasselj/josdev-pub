#!/usr/bin/env bash

set -eu

# prebuild
echo -e "#pragma once\n#define KERNEL_FILE_NAME L\"$KERNEL_FILE_NAME\"" > $BOOTLOADER_SRC_DIR/Autogenerated-KernelFileName.h
cp $BOOTLOADER_DIR/environment-prep/MdeModulePkg.dsc.modified $EDK2_REPO_PATH/MdeModulePkg/MdeModulePkg.dsc
mkdir -p $BOOTLOADER_ARTIFACTS_DIR
cp -R $BOOTLOADER_SRC_DIR $EDK2_REPO_PATH/BootloaderPkg/  # copy dir containing source files into edk2 build tree
# end prebuild

cd $EDK2_REPO_PATH
set +u
. edksetup.sh

# if we are cross building
if [[ ! $(uname -m | grep 'x86_64') ]]; then
    sudo ln -s /usr/bin/x86_64-linux-gnu-gcc /usr/local/bin/gcc && \
    sudo ln -s /usr/bin/x86_64-linux-gnu-gcc-ar /usr/local/bin/ar && \
    sudo ln -s /usr/bin/x86_64-linux-gnu-gcc-nm /usr/local/bin/nm && \
    sudo ln -s /usr/bin/x86_64-linux-gnu-objcopy /usr/local/bin/objcopy && \
    sudo ln -s /usr/bin/x86_64-linux-gnu-ranlib /usr/local/bin/ranlib
fi

build \
    --platform=MdeModulePkg/MdeModulePkg.dsc \
    --arch=X64 \
    --buildtarget=DEBUG \
    --tagname=GCC
set -u

# remove symlinks
if [[ ! $(uname -m | grep 'x86_64') ]]; then
    sudo rm /usr/local/bin/gcc && \
    sudo rm /usr/local/bin/ar && \
    sudo rm /usr/local/bin/nm && \
    sudo rm /usr/local/bin/objcopy && \
    sudo rm /usr/local/bin/ranlib
fi

# copy artifacts produced by the EDK2 build system into our local tree
cp $BOOTLOADER_EDK2_EXE_PATH $BOOTLOADER_EXE_PATH