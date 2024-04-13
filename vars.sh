#############################################
# SET ON BUILD MACHINE BEFORE SOURCING FILE
export ABS_PATH_TO_REPO_ROOT=/bindmount
#############################################

# Do not change order of variable sections
export NONROOT_PROJ_DATA_DIR_BASE=/usr/local/josdev

# REPOS
export EDK2_REPO_PATH=$NONROOT_PROJ_DATA_DIR_BASE/thirdparty/edk2
export EDK2_REPO_URL=https://github.com/tianocore/edk2.git
export EDK2_REPO_TAG=edk2-stable202402

export BINUTILS_REPO_URL=git://sourceware.org/git/binutils-gdb.git
export BINUTILS_REPO_TAG=gdb-14.2-release
export BINUTILS_REPO_PATH=$NONROOT_PROJ_DATA_DIR_BASE/thirdparty/binutils

export GCC_REPO_URL=git://gcc.gnu.org/git/gcc.git
export GCC_REPO_TAG=releases/gcc-13.2.0
export GCC_REPO_PATH=$NONROOT_PROJ_DATA_DIR_BASE/thirdparty/gcc

# MISC
export BOOTLOADER_EDK2_EXE_PATH=$EDK2_REPO_PATH/Build/MdeModule/DEBUG_GCC/X64/Bootloader.efi
export KERNEL_TOOLCHAIN_PREFIX=$NONROOT_PROJ_DATA_DIR_BASE/tools/cross

# DOCKER
export NONROOT_USERNAME=dockerbuildr
export DOCKER_IMAGE_NAME=edk2builder
export DOCKER_IMAGE_TAG=1

# 'PROJ' DIRS
export BOOTLOADER_DIR=$ABS_PATH_TO_REPO_ROOT/bootloader
export KERNEL_DIR=$ABS_PATH_TO_REPO_ROOT/kernel

# BOOTLOADER
export BOOTLOADER_SRC_DIR=$BOOTLOADER_DIR/src
export BOOTLOADER_ARTIFACTS_DIR=$BOOTLOADER_DIR/ARTIFACTS
export BOOTLOADER_EXE_PATH=$BOOTLOADER_ARTIFACTS_DIR/bootx64.efi

# KERNEL
export KERNEL_ARTIFACTS_DIR=$KERNEL_DIR/ARTIFACTS
export KERNEL_FILE_NAME=jkern.elf64
export KERNEL_EXE_PATH=$KERNEL_ARTIFACTS_DIR/$KERNEL_FILE_NAME

# ISO
export ISO_FILE_NAME=josdev.iso
export ISO_FILE_PATH=$ABS_PATH_TO_REPO_ROOT/$ISO_FILE_NAME
export MFORMAT=/usr/bin/mformat
export MMD=/usr/bin/mmd
export MCOPY=/usr/bin/mcopy
export GENISOIMAGE=/usr/bin/genisoimage
