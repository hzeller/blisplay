/* -*- mode: c++; c-basic-offset: 4; indent-tabs-mode: nil; -*-
 * Copyright (c) h.zeller@acm.org. GNU public License.
 */
#define F_CPU 1000000

#include <avr/io.h>
#include <util/delay.h>

#define CS_CAMERA (1<<3)
#define CS_COILS (1<<4)
#define SPI_SCK (1<<2)
#define SPI_DO (1<<1)

#define COIL_LED_1 0x01000000
#define COIL_LED_2 0x00000100

// Lookup-table for bits for given x/y position.
static const uint32_t pixel2coil[4][6] = {
    // TODO: fill with mapping bit to coil
    { 0x00000001, 0x00000001, 0x00000001, 0x00000001, 0x00000001, 0x00000001},
    { 0x00000001, 0x00000001, 0x00000001, 0x00000001, 0x00000001, 0x00000001},
    { 0x00000001, 0x00000001, 0x00000001, 0x00000001, 0x00000001, 0x00000001},
    { 0x00000001, 0x00000001, 0x00000001, 0x00000001, 0x00000001, 0x00000001},
};

uint8_t spi_send(uint8_t data) {
    USISR = (1<<USIOIF);
    USIDR = data;

    while ((USISR & (1<<USIOIF)) == 0) {
        USICR = (1<<USIWM0)|(1<<USICS1)|(1<<USICLK)|(1<<USITC);
    }
    return USIDR;
}

void send_coils(uint32_t coil_state) {
    PORTB &= ~CS_COILS;
    spi_send(coil_state & 0xff);
    spi_send((coil_state >> 8) & 0xff);
    spi_send((coil_state >> 16) & 0xff);
    spi_send((coil_state >> 24) & 0xff);
    PORTB |= CS_COILS;
}

int main() {
    DDRB = CS_COILS | CS_CAMERA | SPI_SCK | SPI_DO;

    // Set up SPI
    USISR = (1<<USIWM0) | (1<<USICS1) | (1<<USICLK) | (1<<USITC);

    int x = 2;
    int y = 4;
    uint32_t coil_state = pixel2coil[x][y];

    for (;;) {
        coil_state = COIL_LED_1;
        send_coils(coil_state);
        _delay_ms(100);
        coil_state = 0x00;
        send_coils(coil_state);
        _delay_ms(100);
    }
}
