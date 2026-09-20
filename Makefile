# Define the final output file name
TARGET = payload

# The target system layout format for Orbis OS
CompilerTarget = freebsd

# Include standard compiler flags and definitions from the SDK
include $(PS4SDK)/defs.mk

# Add your source files here (main.c is our entry point)
SRCS = main.c

# Link the core system kernels and standard C library functions
LIBS = -lkernel -lc

# Include the automated linking rules to generate the .bin output
include $(PS4SDK)/rules.mk
