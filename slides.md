## Own kernel: how to start
Note:
prosty przykład i troche teorii
/---/
### Types
| Type          | Examples           |
| ------------- | ------------------ |
| monolithic    | Linux, BSD         |
| microkernel   | Minix, Mach        |
| hybrid        | Windows?           |
/---/
### What you need (for x86)
- bootloader
- cross-toolchain
- some build system tool (eg. CMake + Ninja)
/---/
### Simple example
- everybody loves assembly ;)
```
.global start
start:
    hlt
```
```
ENTRY(start)
SECTIONS {
    . = 1M;
    .text : {
        KEEP(*(.text))
    }
}
```
/---/
### Multitasking
Ability to run concurent processes
- cooperative
- preemptive
/---/
### Multitasking
##### On 1 core:
- time-sharing
- interrupt driven scheduler
- context switching
/---/
### Context switching
Saving and restoring state of the CPU
```bash
PUSH_REGISTERS
STORE_STACK_POINTER

# Run scheduler to choose process to load

LOAD_NEW_STACK_POINTER
POP_REGISTERS

IRET
```
/---/
### How can process perform operations in the kernel if access is forbidden?
/---/
### Answer: system calls
On x86 Linux:
```
# write syscall
mov $1, %eax
mov $1, %ebx
mov $string, %ecx
mov $12, %edx
int $0x80

string:
.asciz "Hello World!"
```
/---/
### What happens?
![](/syscalls.png)
/---/
### Next steps
- filesystems
- IPC
- drivers
/---/
### Thanks for your attention! :)
