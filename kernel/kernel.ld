ENTRY(kernel_entry)

SECTIONS
{
	. = SIZEOF_HEADERS;

	.text : ALIGN(2)
	{
		*(.text)
	}

	.data : ALIGN(2)
	{
		*(.data*)
		*(.rodata*)
		*(COMMON)
		*(.rela.data*)
		*(.rela.debug*)
		*(.bss)
	}

	. = ALIGN(2);

	.debug          0 : { *(.debug) }
	.line           0 : { *(.line) }
	.debug_srcinfo  0 : { *(.debug_srcinfo) }
	.debug_sfnames  0 : { *(.debug_sfnames) }
	.debug_aranges  0 : { *(.debug_aranges) }
	.debug_pubnames 0 : { *(.debug_pubnames) }
	.debug_info     0 : { *(.debug_info .gnu.linkonce.wi.*) }
	.debug_abbrev   0 : { *(.debug_abbrev) }
	.debug_line     0 : { *(.debug_line .debug_line.* .debug_line_end ) }
	.debug_frame    0 : { *(.debug_frame) }
	.debug_str      0 : { *(.debug_str) }
	.debug_loc      0 : { *(.debug_loc) }
	.debug_macinfo  0 : { *(.debug_macinfo) }
	.debug_weaknames 0 : { *(.debug_weaknames) }
	.debug_funcnames 0 : { *(.debug_funcnames) }
	.debug_typenames 0 : { *(.debug_typenames) }
	.debug_varnames  0 : { *(.debug_varnames) }
	.debug_pubtypes 0 : { *(.debug_pubtypes) }
	.debug_ranges   0 : { *(.debug_ranges) }
	.debug_macro    0 : { *(.debug_macro) }
	.debug_line_str 0 : { *(.debug_line_str) }
	.gnu.attributes 0 : { KEEP (*(.gnu.attributes)) }

	/DISCARD/ : {*(*)}
}