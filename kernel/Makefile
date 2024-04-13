# Disable built-in rules and variables
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --no-builtin-variables
.SUFFIXES:

SRC_DIR := src
OBJ_DIR := $(KERNEL_ARTIFACTS_DIR)/obj

SRC_FILES := $(shell find $(SRC_DIR) -type f -name "*.c")
HEADER_FILES := $(shell find $(INCLUDE_DIR) -type f -name "*.h")
OBJ_FILES := $(subst $(SRC_DIR),$(OBJ_DIR),$(patsubst %.c,%.o,$(SRC_FILES)))

COMPILER := $(KERNEL_TOOLCHAIN_PREFIX)/gcc/bin/x86_64-elf-gcc
LINKER := $(KERNEL_TOOLCHAIN_PREFIX)/binutils/bin/x86_64-elf-ld
READELF := $(KERNEL_TOOLCHAIN_PREFIX)/binutils/bin/x86_64-elf-readelf
OBJDUMP := $(KERNEL_TOOLCHAIN_PREFIX)/binutils/bin/x86_64-elf-objdump
OBJCOPY := $(KERNEL_TOOLCHAIN_PREFIX)/binutils/bin/x86_64-elf-objcopy

CFLAGS := \
	-I$(BOOTLOADER_DIR)/include/X64 \
	-I$(BOOTLOADER_DIR)/include \
	-c \
	-Wall \
	-Wextra \
	-O0 \
	-ggdb \
	-ffreestanding \
	-fno-builtin \
	-fno-stack-protector \
	-mno-red-zone \
	-fshort-wchar

LDFLAGS := \
	-nostdlib \
	-no-pie \
	--emit-relocs \
	-T kernel.ld \
	-Map=$(KERNEL_ARTIFACTS_DIR)/$(KERNEL_FILE_NAME).map

.PHONY: all clean dirs dump analysis

# RULES
# $@ = target, $< = first pre-req, $^ = all prereqs
###############################################################################
all: jkern analysis

jkern: dirs $(OBJ_FILES)
	$(LINKER) $(LDFLAGS) $(OBJ_FILES) -o $(KERNEL_EXE_PATH)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(COMPILER) $(CFLAGS) $< -o $@

analysis:
	$(READELF) --all $(KERNEL_EXE_PATH) > $(KERNEL_ARTIFACTS_DIR)/$(KERNEL_FILE_NAME).readelf
	$(OBJDUMP) --disassemble --source $(KERNEL_EXE_PATH) --disassembler-options=intel > $(KERNEL_ARTIFACTS_DIR)/$(KERNEL_FILE_NAME).disasm-with-sources

dirs:
	@mkdir -p $(KERNEL_ARTIFACTS_DIR)
	@mkdir -p $(OBJ_DIR)

dump:
	$(foreach v, \
		$(filter-out $(VARS_OLD) VARS_OLD,$(.VARIABLES)), \
		$(info $(v) = $($(v))))
###############################################################################