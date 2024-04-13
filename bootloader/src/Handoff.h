#pragma once

#include <Uefi.h>

// when we come alive, what loaded us and from where
struct KernelHandoff {
    // kernel image info
    VOID* kernelBaseAddress;
    UINTN kernelSize;

    // memory map
    EFI_MEMORY_DESCRIPTOR* memMapBaseAddress;
    UINTN memMapSize;

    // configuration table
    EFI_CONFIGURATION_TABLE* configurationTable;
    UINTN numTableEntries;

    // graphics info
    EFI_PHYSICAL_ADDRESS frameBufferBaseAddr;
    UINTN frameBufferSize;
};

void StartKernel(struct KernelHandoff* o);