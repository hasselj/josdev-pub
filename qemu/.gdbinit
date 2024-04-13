set disassembly-flavor intel
target remote localhost:1234
symbol-file -readnow kernel/ARTIFACTS/jkern.elf64 -o 0x5BD7018
break *kernel_entry
c
