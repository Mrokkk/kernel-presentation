ENTRY(start)
SECTIONS {
    . = 1M;
    .text : {
        KEEP(*(.text))
    }
}
