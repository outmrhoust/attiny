CC=avr-gcc
OBJCOPY=avr-objcopy
AVRDUDE=avrdude
CFLAGS=-Os -DF_CPU=1000000 -mmcu=attiny85
PORT=/dev/ttyACM0
BAUDE=19200
all: write_char.hex 

write_char.hex: write_char.elf
	$(OBJCOPY) -O ihex $< $@
write_char.elf: main.c
	$(CC) $(CFLAGS) -o $@ $^ 
upload: write_char.hex 
	$(AVRDUDE) -c avrisp -p attiny85 -b $(BAUDE) -P $(PORT)  -U flash:w:$< 

clean: 
	$(RM) write_char.elf write_char.hex 

.PHONY: all upload clean