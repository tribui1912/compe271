#include <stdio.h>

int lfsr32(int n)
{
	static unsigned int lfsr = 0x55AAFF00;
	int bit;
	if (n != 0) lfsr = n;
	for (int i = 0; i < 32; i++)	{
		bit = ((lfsr >> 31) ^ (lfsr >> 21) ^ (lfsr >> 1) ^ lfsr) & 1;
		lfsr = (lfsr >> 1) | (bit << 31);
	}
	return lfsr;
}

int main()
{
	int rand;
	lfsr32(0x55AAFF00);
	for (int i = 0; i < 10; i++)
	{
		rand = lfsr32(0);
		printf("%u\n", rand);
	}
	return 0;
}
