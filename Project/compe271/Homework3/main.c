#include <stdio.h>
#include <stdint.h>

/// using define to make changes easier in case want to make the array bigger without having to change too much data
#define r 3
#define c 5

int arrayAddress(int row, int col, int ncolumns, int array[r][c])
{
	printf("Address of that element is: %p\n", array[row][col]);
	return 0;
}


int main()
{
	int array[r][c] = {{1,2,3,4,5},{6,7,8,9,10},{11,12,13,14,15}};
	int row = r + 1,col = c + 1;
	
	while(row > r || row < 0)
	{
		printf("Enter row number: ");
		scanf("%d",&row);
	}

	while(col > c || col < 0)
	{
		printf("Enter column number: ");
		scanf("%d",&col);
	}

	row--;
	col--;

	arrayAddress(row,col,5,array);

	return 0;

}

