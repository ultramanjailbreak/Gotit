# Define the target output name
TARGET = payload

# Let the automated compiler load its internal configuration files directly
include defs.mk

# Point to your primary main file
SRCS = main.c

# Link essential runtime libraries
LIBS = -lkernel -lc

# Execute final binary compilation mechanics
include rules.mk
