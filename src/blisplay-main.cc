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

// ADNS 3050 registers
#define ADNS_RESET            0x3a
#define ADNS_MOUSE_CTRL       0x0d
#define ADNS_MOTION_CTRL      0x41
#define ADNS_PIX_GRAB         0x0b
#define ADNS_PIX_MIN          0x0a
#define ADNS_PIX_MAX          0x08

#define COIL_LED_1 0x01000000
#define COIL_LED_2 0x00000100

// The frame needed for
struct Frame {
    static uint8_t constexpr WIDTH = 4;
    static uint8_t constexpr HEIGHT = 6;

    uint8_t pixels[WIDTH * HEIGHT];
    uint8_t min_value;
    uint8_t max_value;

    void set(uint8_t x, uint8_t y, uint8_t v) { pixels[WIDTH * y + x] = v; }
    uint8_t get(uint8_t x, uint8_t y) const { return pixels[WIDTH * y + x]; }
};

// Lookup-table which bits control which actuator.
static const uint8_t pixel2actuator_bits[Frame::WIDTH * Frame::HEIGHT] = {
    1,  1,  1,  1,     // TODO: fill
    1,  1,  1,  1,
    1,  1,  1,  1,

    16, 16, 16, 16,    // TODO: fill
    16, 16, 16, 16,
    16, 16, 16, 16,
};

void spi_init() {
    DDRB |= SPI_SCK | SPI_DO;
    USISR = (1<<USIWM0) | (1<<USICS1) | (1<<USICLK) | (1<<USITC);
}

uint8_t spi_transfer(uint8_t data) {
    USIDR = data;

    USISR = (1<<USIOIF);
    while ((USISR & (1<<USIOIF)) == 0) {
        USICR = (1<<USIWM0)              // Three wire mode
            | (1<<USICS1) | (1<<USICLK)  // "external" positive edge
            | (1<<USITC);                // Toggle clock.
    }
    return USIDR;
}

void actuators_send(uint32_t coil_state) {
    PORTB &= ~CS_COILS;
    spi_transfer(coil_state & 0xff);
    spi_transfer((coil_state >> 8) & 0xff);
    spi_transfer((coil_state >> 16) & 0xff);
    spi_transfer((coil_state >> 24) & 0xff);
    PORTB |= CS_COILS;
}

void adns3050_write(uint8_t reg, uint8_t data) {
    PORTB &= ~CS_CAMERA;
    spi_transfer(reg | 0x80);  // MSB=1: write
    spi_transfer(data);
    _delay_us(30);
    PORTB |= CS_CAMERA;
    _delay_us(30);
}

uint8_t adns3050_read(uint8_t reg){
    PORTB &= ~CS_CAMERA;
    // send address of the register, with MSBit = 0 to say it's reading
    spi_transfer(reg & 0x7f);  // MSB=0: read
    _delay_us(100);
    uint8_t result = spi_transfer(0);
    _delay_us(30);
    PORTB |= CS_CAMERA;
    _delay_us(30);

    return result;
}

// Read a column into buffer.
void adns3050_read_column(uint8_t *buffer) {
    for (int i = 0; i < 19; ++i) {
        *buffer++ = adns3050_read(ADNS_PIX_GRAB) & 0x7f;  // MSB: ready
    }
}

void adns3050_grab_frame(Frame *f) {
    f->min_value = adns3050_read(ADNS_PIX_MIN);
    f->max_value = adns3050_read(ADNS_PIX_MAX);

    adns3050_write(ADNS_PIX_GRAB, 0);  // Write: Init reading pixel buffer.
    uint8_t column[19];
    for (int x = Frame::WIDTH - 1; x >= 0; --x) {  // Matrix grab: right->left
        // The tactile 'pixels' are staggered, so we grab them from different
        // columns in the optical domain to match that.
        adns3050_read_column(column);
        f->set(x, 0, column[0 * 3]);
        f->set(x, 3, column[3 * 3]);
        adns3050_read_column(column);
        f->set(x, 1, column[1 * 3]);
        f->set(x, 4, column[4 * 3]);
        adns3050_read_column(column);
        f->set(x, 2, column[2 * 3]);
        f->set(x, 5, column[5 * 3]);
    }
}

void adns3050_init() {
    adns3050_write(ADNS_RESET, 0x5a);  // force reset.
    _delay_ms(100);  // wait for it to fully initialize
    adns3050_write(ADNS_MOUSE_CTRL, 0x20);   // needed ?
    adns3050_write(ADNS_MOTION_CTRL, 0x00);  // needed ?
    _delay_ms(100);
}

int main() {
    DDRB = CS_COILS | CS_CAMERA;
    PORTB = CS_CAMERA | CS_COILS;  // CS high.

    spi_init();
    adns3050_init();

    Frame frame;
    uint32_t actuator_state = 0;
    for (;;) {
        adns3050_grab_frame(&frame);

        uint8_t threshold = frame.min_value/2 + frame.max_value/2;
        const uint8_t *lookup = pixel2actuator_bits;
        for (uint8_t y = 0; y < Frame::HEIGHT; ++y) {
            for (uint8_t x = 0; x < Frame::WIDTH; ++x) {
                if (frame.get(x, y) < threshold) {
                    actuator_state |= (1L<<*lookup);
                } else {
                    actuator_state &= ~(1L<<*lookup);
                }
                ++lookup;
            }
        }
        actuator_state ^= COIL_LED_1;
        actuators_send(actuator_state);
    }
}
