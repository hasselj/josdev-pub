#pragma once

#include <Uefi.h>

#define PRINT_ERROR(msg) \
    Print(L"[!] %a:%d in %a() -  %s \n", __FILE__, __LINE__, __func__, msg)

#define PRINT_ERROR_CODE(msg, code) \
    PRINT_ERROR(msg); Print(L"%r\n", code)
