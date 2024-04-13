#include "Utils.h"
#include "Graphics.h"
#include <Uefi.h>
#include <Library/UefiLib.h>
#include <Library/UefiBootServicesTableLib.h>
#include <Protocol/GraphicsOutput.h>

EFI_STATUS GetGopInfo(struct KernelHandoff* o)
{
    EFI_GUID guid;
    EFI_STATUS status;
    EFI_GRAPHICS_OUTPUT_PROTOCOL* gopProto = NULL;
    EFI_GRAPHICS_OUTPUT_MODE_INFORMATION* gfxOutputModeInfo = NULL;

    guid = (EFI_GUID)EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID;

    status = gBS->LocateProtocol(
        &guid,
        NULL,
        (VOID**)&gopProto);

    if (EFI_ERROR(status)) {
        PRINT_ERROR_CODE(L"LocateProtocol", status);
        goto cleanup;
    }

    o->frameBufferBaseAddr = gopProto->Mode->FrameBufferBase;
    o->frameBufferSize = gopProto->Mode->FrameBufferSize;

cleanup:
    if (!gfxOutputModeInfo) {
        gBS->FreePool(gfxOutputModeInfo);
    }

    return status;
}