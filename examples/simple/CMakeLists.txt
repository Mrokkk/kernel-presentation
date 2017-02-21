project(kernel C CXX)
cmake_minimum_required(VERSION 3.0)

set(CMAKE_C_FLAGS "-m32 -fdiagnostics-color=always")

set(CMAKE_EXE_LINKER_FLAGS "-Wl,-T${CMAKE_SOURCE_DIR}/kernel.lds -Wl,-Map=kernel.map -Wl,--oformat -Wl,elf32-i386 -Wl,-m -Wl,elf_i386 -nostartfiles -nostdlib")
set_property(SOURCE kernel.S PROPERTY LANGUAGE C)
add_executable(${PROJECT_NAME} kernel.S)

configure_file(${CMAKE_SOURCE_DIR}/runqemu.in ${CMAKE_BINARY_DIR}/runqemu @ONLY)

add_custom_target(
    iso
    COMMAND ${CMAKE_SOURCE_DIR}/isomaker.sh -o ${PROJECT_NAME} --multiboot2
    DEPENDS ${PROJECT_NAME}
    COMMENT "Building bootable ISO"
)

add_custom_target(
    runqemu
    COMMAND chmod +x ${CMAKE_BINARY_DIR}/runqemu
    COMMAND ${CMAKE_BINARY_DIR}/runqemu
    DEPENDS iso
    COMMENT "Booting kernel"
)

