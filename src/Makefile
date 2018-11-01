# <h.zeller@acm.org>
##

TARGET_ARCH=-mmcu=attiny85
CXX=avr-g++
CXXFLAGS=-Os -g -Wall -Wextra -ffunction-sections -fdata-sections -mcall-prologues
AVRDUDE_DEVICE ?= /dev/ttyUSB0
AVRDUDE     = avrdude -p t85 -c stk500v2 -P $(AVRDUDE_DEVICE)
FLASH_CMD   = $(AVRDUDE) -e -U flash:w:main.hex
LINK=avr-g++ -g $(TARGET_ARCH) -Wl,-gc-sections
OBJECTS=adns-main.o

all : main.hex

main.elf: $(OBJECTS)
	$(LINK) -o $@ $(OBJECTS)
	avr-size $@

disasm: main.elf
	avr-objdump -C -S main.elf

main.hex: main.elf
	avr-objcopy -j .text -j .data -O ihex main.elf main.hex

flash: main.hex
	$(FLASH_CMD)

clean:
	rm -f $(OBJECTS) main.elf main.hex

# fuses: E:FF, H:DF, L:62
