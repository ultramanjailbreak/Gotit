TARGET := payload

SRCS := main.c

CC := clang
LD := ld.lld

CFLAGS := -O2 -Wall -Wextra
CFLAGS += -ffreestanding
CFLAGS += -fno-stack-protector
CFLAGS += -fno-builtin

INCLUDES := -I/lib/ps4-payload-sdk/libPS4/include

LDFLAGS :=
LIBS :=

$(TARGET): $(SRCS)
	$(CC) $(CFLAGS) $(INCLUDES) -c $(SRCS) -o main.o
	$(LD) $(LDFLAGS) main.o $(LIBS) -o $(TARGET).elf

.PHONY: all clean

all: $(TARGET)

clean:
	rm -f main.o $(TARGET).elf $(TARGET).bin
