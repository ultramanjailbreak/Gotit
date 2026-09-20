TARGET := payload.bin

LIBPS4 := $(PS4SDK)/libPS4

CC := gcc
OBJCOPY := objcopy

ODIR := build

CFLAGS := -I$(LIBPS4)/include
CFLAGS += -Iinclude
CFLAGS += -Os
CFLAGS += -std=c11
CFLAGS += -ffunction-sections
CFLAGS += -fdata-sections
CFLAGS += -fno-builtin
CFLAGS += -nostdlib
CFLAGS += -Wall
CFLAGS += -Wextra
CFLAGS += -m64
CFLAGS += -fpie
CFLAGS += -fPIC

LFLAGS := -L$(LIBPS4)
LFLAGS += -T$(LIBPS4)/linker.x
LFLAGS += -Wl,--build-id=none
LFLAGS += -Wl,--gc-sections

LIBS := -lPS4

SRCS := main.c
OBJS := $(ODIR)/main.o

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(LIBPS4)/crt0.s $(OBJS) \
		$(CFLAGS) \
		$(LFLAGS) \
		$(LIBS) \
		-o temp.elf
	$(OBJCOPY) -O binary temp.elf $(TARGET)
	rm -f temp.elf

$(ODIR)/main.o: main.c
	mkdir -p $(ODIR)
	$(CC) $(CFLAGS) -c main.c -o $(ODIR)/main.o

clean:
	rm -rf $(ODIR) $(TARGET) temp.elf
