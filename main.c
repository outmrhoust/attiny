#include <avr/io.h>
#include <util/delay.h>

#define BIT_DURATION_US (3330)
#define PATTE PB3

void serial_setup() {
    DDRB |= (1 << PATTE);
}

/**
 * Sends a character over serial communication.
 *
 * @param c The character to be sent.
 */
void serial_send_char(char c) {
    // Start bit
    PORTB &= ~(1 << PATTE);
    _delay_us(BIT_DURATION_US);


    for (int i = 0; i < 8; i++) {
        if (c & (1 << i)) {
            PORTB |= (1 << PATTE);
        } else {
            PORTB &= ~(1 << PATTE);
        }
        _delay_us(BIT_DURATION_US);
    }

    // Stop bit
    PORTB |= (1 << PATTE);
    _delay_us(BIT_DURATION_US);
    _delay_us(BIT_DURATION_US);
}

int main(void) {
    serial_setup();

    char *message = "Bonjour moi c'est hicham, ravi de faire votre connaissance ";
    while(1) {
        // loop through each char in the message until it reach end of message and send each char
        for (int i = 0; message[i] != 0; i++) {
            serial_send_char(message[i]);
            _delay_ms(100);
        }
        _delay_ms(1000);
    }

    return 0;
}