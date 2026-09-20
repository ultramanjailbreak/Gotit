# Define the output file name
TARGET = payload

# Use the environment variable provided by the Docker runner
include $(PS4SDK)/defs.mk

# Specify your source file
SRCS = main.c

# Link the core system libraries
LIBS = -lkernel -lc

# Include the automated build rules
include $(PS4SDK)/rules.mk
