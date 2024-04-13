#include "Handoff.h"
#include "Elf64.h"

void (*JumpToKernel)(struct KernelHandoff*);

void StartKernel(struct KernelHandoff* kh)
{
    Elf64_Ehdr* hdr;

    hdr = (Elf64_Ehdr*)kh->kernelBaseAddress;
    JumpToKernel = (void (*)(struct KernelHandoff*))(hdr->e_entry + kh->kernelBaseAddress);

    // for testing
    JumpToKernel(kh);
}