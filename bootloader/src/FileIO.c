#include "FileIO.h"
#include "Utils.h"
#include "Handoff.h"
#include <Uefi.h>
#include <Library/UefiBootServicesTableLib.h>
#include <Library/UefiLib.h>
#include <Protocol/LoadedImage.h>
#include <Protocol/SimpleFileSystem.h>
#include <Guid/FileInfo.h>

EFI_STATUS LoadFileIntoRam(struct KernelHandoff* OUT o, CHAR16* fileName)
{
    EFI_LOADED_IMAGE_PROTOCOL* loadedImageProtoIface;
    EFI_SIMPLE_FILE_SYSTEM_PROTOCOL* simpleFsProtoIface;
    EFI_FILE_PROTOCOL* fileProtoIface; // handle to file system
    EFI_FILE_PROTOCOL* kernelFileHandle; // handle to the kernel
    UINTN bufferSize = 0;
    VOID* buffer = NULL;
    EFI_GUID guid;
    EFI_STATUS status;

    guid = (EFI_GUID)EFI_LOADED_IMAGE_PROTOCOL_GUID;
    status = gBS->OpenProtocol(
        gImageHandle,
        &guid,
        (VOID**)&loadedImageProtoIface,
        gImageHandle,
        NULL,
        EFI_OPEN_PROTOCOL_BY_HANDLE_PROTOCOL);

    if (EFI_ERROR(status)) {
        PRINT_ERROR_CODE(L"OpenProtocol", status);
        goto cleanup;
    }

    // obtain handle to the Efi System Partition that we live on
    guid = (EFI_GUID)EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID;
    status = gBS->OpenProtocol(
        loadedImageProtoIface->DeviceHandle,
        &guid,
        (VOID**)&simpleFsProtoIface,
        gImageHandle,
        NULL,
        EFI_OPEN_PROTOCOL_BY_HANDLE_PROTOCOL);

    if (EFI_ERROR(status)) {
        PRINT_ERROR_CODE(L"OpenProtocol", status);
        goto cleanup;
    }

    status = simpleFsProtoIface->OpenVolume(
        simpleFsProtoIface,
        &fileProtoIface);

    if (EFI_ERROR(status)) {
        PRINT_ERROR_CODE(L"OpenVolume", status);
        goto cleanup;
    }

    // open a file handle to a file residing on the ESP (FAT32 file system)
    status = fileProtoIface->Open(
        fileProtoIface,
        &kernelFileHandle,
        fileName,
        EFI_FILE_MODE_READ,
        0);

    if (EFI_ERROR(status)) {
        PRINT_ERROR_CODE(L"Open", status);
        goto cleanup;
    }

    bufferSize = 8 * SIZE_1MB; // WARNING: hard coding max size of file
    status = gBS->AllocatePool(
        EfiLoaderData,
        bufferSize,
        &buffer);

    if (EFI_ERROR(status)) {
        PRINT_ERROR_CODE(L"AllocatePool", status);
        goto cleanup;
    }

    // TODO: might need while bytesRead != totalFileSize loop here...
    status = kernelFileHandle->Read(
        kernelFileHandle,
        &bufferSize,
        buffer);

    if (EFI_ERROR(status)) {
        PRINT_ERROR_CODE(L"Read", status);
        goto cleanup;
    }

    o->kernelBaseAddress = buffer;
    o->kernelSize = bufferSize;

cleanup:
    return status;
}