#
# Copyright 2017-2023 Valve Corporation.
#

# Apple visionOS (Vision Pro), arm64. Requires CMake 3.28 or later.
# Pass -DCMAKE_OSX_SYSROOT=xrsimulator to target the visionOS simulator instead of a device
# (build.py and get_dependencies.py do that for '-p visionos_simulator').

set(CMAKE_SYSTEM_NAME visionOS)
set(CMAKE_OSX_ARCHITECTURES arm64)
if (NOT DEFINED CMAKE_OSX_SYSROOT)
    set(CMAKE_OSX_SYSROOT xros)
endif()
if (NOT DEFINED CMAKE_OSX_DEPLOYMENT_TARGET)
    set(CMAKE_OSX_DEPLOYMENT_TARGET 2.0)
endif()
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE BOTH)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY BOTH)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM BOTH)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE BOTH)
