#include "Memory.h"
#include "Utils.h"
#include <Uefi.h>
#include <Library/UefiBootServicesTableLib.h>
#include <Library/UefiLib.h>

EFI_STATUS GetMemoryMap(struct KernelHandoff* o, UINTN* OUT memMapKey)
{
    EFI_MEMORY_DESCRIPTOR* buffer = NULL;
    UINTN bufferSize = 0;
    UINTN mapKey;
    UINTN descriptorSize;
    UINT32 descriptorVers;
    EFI_STATUS status;

    status = gBS->GetMemoryMap(
        &bufferSize,
        buffer,
        &mapKey,
        &descriptorSize,
        &descriptorVers);

    if (EFI_ERROR(status) && status != EFI_BUFFER_TOO_SMALL) {
        PRINT_ERROR_CODE(L"GetMemoryMap", status);
        goto cleanup;
    }

    bufferSize += (EFI_PAGE_SIZE * 4);
    status = gBS->AllocatePool(
        EfiLoaderData,
        bufferSize,
        (VOID**)&buffer);

    if (EFI_ERROR(status)) {
        PRINT_ERROR_CODE(L"AllocatePool", status);
        goto cleanup;
    }

    status = gBS->GetMemoryMap(
        &bufferSize,
        buffer,
        &mapKey,
        &descriptorSize,
        &descriptorVers);

    if (EFI_ERROR(status)) {
        PRINT_ERROR_CODE(L"GetMemoryMap", status);
        goto cleanup;
    }

    o->memMapBaseAddress = buffer;
    o->memMapSize = bufferSize;
    *memMapKey = mapKey;

cleanup:
    return status;
}
