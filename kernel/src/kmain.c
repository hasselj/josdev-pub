#include "../../bootloader/src/Handoff.h"

void draw_scary_lines(struct KernelHandoff* kh)
{
    char* baseAddr = kh->frameBufferBaseAddr;

    for (int i = 0; i < kh->frameBufferSize; i++) {
        for (int t=0; t < MAX_INT16; t++) {}
        baseAddr[i] = i++;
    }
}

void kernel_entry(struct KernelHandoff* kh)
{
    draw_scary_lines(kh);

    /*
        TODO:

        - Primitive console IO
        - Segments
        - Interrupts
        - Paging
        - Hardware
        - PCI
        - Network Stack
        - Keyboard/Mouse
        - USB
    */
}
