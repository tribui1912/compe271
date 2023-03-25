#include <stdio.h>
#include <stdint.h>

// Define the LFSR parameters
#define LFSR_WIDTH 32
#define LFSR_TAP1  32
#define LFSR_TAP2  22
#define LFSR_TAP3  2
#define LFSR_TAP4  1

// Global variable to store the LFSR state
uint32_t lfsr_state = 0x55AAFF00u;

// Generate the next pseudorandom number in the sequence
uint32_t lfsr_next() {
    uint32_t feedback = ((lfsr_state >> LFSR_TAP1) ^ (lfsr_state >> LFSR_TAP2) ^ (lfsr_state >> LFSR_TAP3) ^ (lfsr_state >> LFSR_TAP4)) & 1;
    lfsr_state = (lfsr_state >> 1) | (feedback << (LFSR_WIDTH - 1));
    return lfsr_state;
}

// Generate 32 new LFSR bits based on the last result
uint32_t lfsr32(int n) {
    if (n != 0) {
        lfsr_state = n;
    }
    return lfsr_next();
}

int main() {
    // Print the first 10 unsigned 32 bit random number values
    for (int i = 0; i < 10; i++) {
        printf("%u\n", lfsr32(0));
    }
    return 0;
}
