#pragma once

#include "Handoff.h"
#include <Uefi.h>

EFI_STATUS GetMemoryMap(struct KernelHandoff* o, UINTN* OUT memMapKey);
