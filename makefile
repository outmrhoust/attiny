CC=avr-gcc
OBJCOPY=avr-objcopy
AVRDUDE=avrdude
CFLAGS=-Os -DF_CPU=1000000 -mmcu=attiny85
PORT=/dev/ttyACM0
BAUDE=19200
all: led_flash.hex 

led_flash.hex: led_flash.elf
	$(OBJCOPY) -O ihex $< $@
led_flash.elf: main.c
	$(CC) $(CFLAGS) -o $@ $^ 
upload: led_flash.hex 
	$(AVRDUDE) -c avrisp -p attiny85 -b $(BAUDE) -P $(PORT)  -U flash:w:$< 

clean: 
	$(RM) led_flash.elf led_flash.hex 

.PHONY: all upload clean