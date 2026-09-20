# Define the target name
TARGET = payload

# Let the compiler find the online SDK path dynamically
PS4SDK ?= /lib/ps4-payload-sdk

# Explicitly pull the internal builder configurations
include $(PS4SDK)/defs.mk

# Point to your primary main file
SRCS = main.c

# Link essential runtime libraries
LIBS = -lkernel -lc

# Execute final binary compilation mechanics
include $(PS4SDK)/rules.mk
