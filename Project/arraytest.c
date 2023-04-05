#include <stdio.h>

#define MAX 50

void main()
{
	char screen[MAX][MAX];
	for(int i = 0; i < MAX; i++)
	{
		for(int j = 0; j < MAX; j++)
		{
			if (i == 0 || i == MAX - 1 || j == 0 || j == MAX - 1)
			{
				screen[i][j] = '#';
			}
			else 
			{
				if ( i == 5 && j == MAX/2)
					screen[i][j] = '0';
				else
					screen[i][j] = ' ';
			}
		}
	}
	for(int i = 0; i < MAX; i++)
	{
		for(int j = 0; j < MAX; j++)
		{
			printf("%c",screen[i][j]);
		}
		printf("\n");
	}
}


