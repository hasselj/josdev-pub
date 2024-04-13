#pragma once

#include <Uefi.h>
#include "Handoff.h"

EFI_STATUS LoadFileIntoRam(struct KernelHandoff* OUT o, CHAR16* fileName);