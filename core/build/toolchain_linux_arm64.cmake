#
# Copyright 2017-2023 Valve Corporation.
#

# Cross-compiles for Linux aarch64 (glibc).
#
# By default this uses the GNU cross toolchain found on the PATH (e.g. the Debian/Ubuntu
# packages gcc-aarch64-linux-gnu / g++-aarch64-linux-gnu) and its own C library.
#
# Optional environment variables:
#   STEAMAUDIO_LINUX_ARM64_CC       C compiler   (default: aarch64-linux-gnu-gcc)
#   STEAMAUDIO_LINUX_ARM64_CXX      C++ compiler (default: aarch64-linux-gnu-g++)
#   STEAMAUDIO_LINUX_ARM64_SYSROOT  sysroot to compile and link against. Use this to target
#                                   an older glibc than the build host's cross toolchain
#                                   provides (see make_linux_arm64_sysroot.py).
#
# If the compiler is clang, the target triple is set to aarch64-linux-gnu and lld is used
# as the linker, so that clang picks up the C/C++ runtime from the sysroot.

set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR aarch64)

if (DEFINED ENV{STEAMAUDIO_LINUX_ARM64_CC})
    set(CMAKE_C_COMPILER $ENV{STEAMAUDIO_LINUX_ARM64_CC})
else()
    set(CMAKE_C_COMPILER aarch64-linux-gnu-gcc)
endif()

if (DEFINED ENV{STEAMAUDIO_LINUX_ARM64_CXX})
    set(CMAKE_CXX_COMPILER $ENV{STEAMAUDIO_LINUX_ARM64_CXX})
else()
    set(CMAKE_CXX_COMPILER aarch64-linux-gnu-g++)
endif()

if (CMAKE_C_COMPILER MATCHES "clang")
    set(CMAKE_C_COMPILER_TARGET aarch64-linux-gnu)
    set(CMAKE_CXX_COMPILER_TARGET aarch64-linux-gnu)
    set(CMAKE_EXE_LINKER_FLAGS_INIT "-fuse-ld=lld")
    set(CMAKE_SHARED_LINKER_FLAGS_INIT "-fuse-ld=lld")
    set(CMAKE_MODULE_LINKER_FLAGS_INIT "-fuse-ld=lld")
endif()

if (DEFINED ENV{STEAMAUDIO_LINUX_ARM64_SYSROOT})
    set(CMAKE_SYSROOT $ENV{STEAMAUDIO_LINUX_ARM64_SYSROOT})
    set(CMAKE_FIND_ROOT_PATH $ENV{STEAMAUDIO_LINUX_ARM64_SYSROOT})
elseif (EXISTS /usr/aarch64-linux-gnu)
    set(CMAKE_FIND_ROOT_PATH /usr/aarch64-linux-gnu)
endif()

# Dependencies are located via explicit paths under deps/, which is outside the root
# path, so search both. Never run or pick up target programs.
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY BOTH)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE BOTH)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE BOTH)
