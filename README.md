# josdev
Project containing my own hobby x64 kernel and uefi bootloader.

# Screenshots
![ScreenShot](https://github.com/hasselj/hasselj.github.io/blob/55cb6b4fe6719d9ba45dee8b3a3d6e84372a556b/qemu-osloader.png)

# Overview
This is my attempt at utilizing the Efi Development Kit (EDK2) build system
to design and build an UEFI operating system loader (bootloader). While plenty
of open source bootloaders exist, such as grub, I wanted the experience of
designing my own and welcomed the challenge.

It also serves as a way to load my own work-in-progress x86 kernel.

# What does it do
This application is designed to load an operating system kernel into memory and pass
control to it. Before it does this, it obtains important ysystem information from the
firmware such as a memory map and graphics information.

# Build system
- Tested on MacOS with arm64 cpu
- Tested on Ubuntu 22 with x64 cpu
- Docker required

# Target system - the machine (real or emulated) the ISO will run on
The x86_64 CPU only.

# Build Instructions
1.) Create the docker build image
`./scripts/create-docker-image.sh`

2.) Perform a build (builds bootloader, kernel, and creates iso).
`./scripts/build-all.sh`

josdev.iso created in repo root.

# Run Instructions
Create a VM with josdev.iso and boot via VirtualBox or VMware on any x64 system should work.

# Does this even work?
At this time, the kernel seems to be loaded into memory given execution. This seems to be
evidenced by the fact of the output provided during the bootloader stage as well as the
random green lines drawn on the screen at kernel entry.

# Misc
Special thanks to the great tutorials and documentation on osdev.org.
