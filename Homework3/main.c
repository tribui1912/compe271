#include <stdio.h>
#include <stdint.h>

int arrayAddress(int row, int col, int ncolumns, int array[3][5])
{
	printf("Address of that element is: %p", array[row][col]);
	return 0;
}


int main()
{
	int array[3][5] = {{1,2,3,4,5},{6,7,8,9,10},{11,12,13,14,15}};
	int row,col;

	printf("Enter row number: ");
	scanf("%d",&row);

	printf("Enter column number: ");
	scanf("%d",&col);

	arrayAddress(row,col,5,array);

	return 0;

}

