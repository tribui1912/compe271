#include <stdio.h>

unsigned int lfsr_state = 0x55AAFF00; // initial seed value

unsigned int lfsr32(int n) {
    if (n != 0) {
        lfsr_state = n; // save seed value in memory
    }

    unsigned int bit = ((lfsr_state >> 1) ^ (lfsr_state >> 21) ^ (lfsr_state >> 31) ^ lfsr_state) & 1;
    lfsr_state = (lfsr_state >> 1) | (bit << 31); // shift and XOR

    return lfsr_state;
}

int main() {
    int i;
    for (i = 0; i < 10; i++) {
        printf("%u\n", lfsr32(0));
    }
    return 0;
}
