header_start:
.long 0xE85250D6
.long 0
.long header_end - header_start
.long -(0xE85250D6 + header_end - header_start)
.word 0
.word 0
.long 8
header_end:

.global start
start:
    hlt
