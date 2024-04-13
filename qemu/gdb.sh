#!/usr/bin/env bash

set -eu

_GDB=gdb
#_KERNEL_EXE_PATH=kernel/ARTIFACTS/jkern.elf64

# connect to QEMU gdb stub
$_GDB -quiet --command=qemu/.gdbinit