#---------------------------------------------------------------------- 
# CMake toolchain file for cross-compiling for NI Linux Real-Time 
#---------------------------------------------------------------------- 
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR x86_64)
set(_GRPC_DEVICE_NILRT_LEGACY_TOOLCHAIN TRUE)

#---------------------------------------------------------------------- 
# Path variables for toolchains 
#---------------------------------------------------------------------- 
find_program(COMPILER_PATH x86_64-nilrt-linux-gcc-10)
if (NOT COMPILER_PATH)
    message(FATAL_ERROR "x86_64-nilrt-linux-gcc-10 not found. Ensure the toolchain is correctly installed.")
endif()
get_filename_component(toolchain_path ${COMPILER_PATH}/../../../../.. REALPATH DIRECTORY)

TOOLCHAIN := $(shell which x86_64-nilrt-linux-gcc)

# Check if the toolchain is available
ifeq ($(TOOLCHAIN),)
$(error "Error: x86_64-nilrt-linux-gcc not found. Please ensure the toolchain is installed and in the PATH.")
endif

all:
	@echo "Using toolchain: $(TOOLCHAIN)"
	# Your build commands go here

ls core2-64-nilrt-linux/usr/include/c++
set(include_path core2-64-nilrt-linux/usr/include/c++/10)

#---------------------------------------------------------------------- 
# Compilers 
#---------------------------------------------------------------------- 
set(CMAKE_C_COMPILER x86_64-nilrt-linux-gcc-10)
set(CMAKE_CXX_COMPILER x86_64-nilrt-linux-g++-10)

#---------------------------------------------------------------------- 
# Default compiler flags 
#---------------------------------------------------------------------- 
set(CMAKE_SYSROOT ${toolchain_path}/core2-64-nilrt-linux)
set(CMAKE_C_STANDARD_INCLUDE_DIRECTORIES 
  "${toolchain_path}/${include_path}"
  "${toolchain_path}/${include_path}/x86_64-nilrt-linux"
)
set(CMAKE_C_FLAGS "-Wall -fmessage-length=0")
set(CMAKE_C_FLAGS_DEBUG "-O0 -g3")
set(CMAKE_C_FLAGS_RELEASE "-O3")

#---------------------------------------------------------------------- 
# Define proper search behavior for cross compilation 
#---------------------------------------------------------------------- 
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
