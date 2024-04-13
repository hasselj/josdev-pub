#pragma once

#include "Handoff.h"
#include <Uefi.h>
#include <Library/UefiBootServicesTableLib.h>
#include <Library/UefiLib.h>

EFI_STATUS GetGopInfo(struct KernelHandoff* o);
