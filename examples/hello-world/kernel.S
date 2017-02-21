header_start:
.long 0xE85250D6
.long 0
.long header_end - header_start
.long -(0xE85250D6 + header_end - header_start)
.word 0
.word 0
.long 8
header_end:

cls:
    mov $0, %eax
    mov $80*25, %ecx
    mov $0xb8000, %edi
    rep stosw
    ret

print_char:
    movb $0x07, %ah
    movw %ax, (%ebx)
    add $2, %ebx
    ret

print_string:
1:  lodsb
    or %al, %al
    jz 2f
    call print_char
    jmp 1b
2:  ret

.global start
start:
    mov $stack, %esp
    call cls
    mov $string, %esi
    mov $0xb8000, %ebx
    call print_string
    hlt

string:
.asciz "Hello World!"

.skip 1024
stack:

