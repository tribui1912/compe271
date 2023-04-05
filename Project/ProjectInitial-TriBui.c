/// Name: Tri Bui
/// RedID: 82813556
/// Class: Compe271
/// Professor: Kenneth Arnold
/// Project name: game project for class final
/// Project type: C
/////////////////
#include <stdio.h>
#include <stdlib.h>
#include <termios.h>
#include <unistd.h>
#include <fcntl.h>
#include <curses.h>
#include <time.h>

/// setting up parameter for the game screen
int score, gameover;
int height = 50;
int width = 50;
int x,flag;
int enemy,new;
int stage = 0;
int change = 50;


/// kbhit from conio.h but implement using ncurses.h created with help online on making it
int kbhit(void)
{
        struct termios oldt, newt;
        int ch;
        int oldf;

        tcgetattr(STDIN_FILENO,  &oldt);
        newt = oldt;
        newt.c_lflag &= ~(ICANON | ECHO);
        tcsetattr(STDIN_FILENO, F_GETFL, 0);
        fcntl(STDIN_FILENO, F_SETFL, oldf | O_NONBLOCK);

        ch = getchar();

        tcsetattr(STDIN_FILENO, TCSANOW, &oldt);
        fcntl(STDIN_FILENO, F_SETFL, oldf);

        if(ch != EOF)
        {
                ungetc(ch, stdin);
                return 1;
        }
        return 0;
}

/// Function to draw the area of game
void draw()
{
	system("clear");
	for(int i = 0; i < height; i++)
	{
		for(int j = 0; j < width; j++)
		{
			if (i == 0 || i == width - 1 || j == 0 || j == height - 1)
			{
				printf("#");
			} 
			else 
			{
				if ( i == x && j == height/2)
					printf("0");
				else
				printf(" ");
			}
		}
		printf("\n");
	}
	printf("Army size: %d",score);
	printf("\nEnemy size: %d",enemy);
	printf("\nPress X to quit");
}


/// setup function where generate the bounderies
void setup()
{
	x = width/2;
	score = 1;
	stage++;
	change += 100;
	while (new < enemy + 100)
	{
		new =rand() % change;
	}
	enemy = new;

	/// making function to generate math equation 
	int k = rand()%4; 


}


/// function to take movement input 
void input()
{
	if(kbhit())
	{
		switch(getchar())
		{
			/// if a pressed character move to the left 
			case 'a':
				flag = 1;
				break;
			/// if d pressed character move to the right
			case 'd':
				flag = 2;
				break;
			/// if x is pressed the game is stopped
			case 'x':
				gameover = 1;
				break;
		}
	}
}


/// function for the logic of the movement
void logic()
{
	sleep(0.01);
	while(x < width && x > 0)
	{
		switch(flag)
		{
			case 1:
				x--;
				break;
			case 2:
				x++;
				break;
			default: 
				break;
		}
	}
	
}


/// main function
void main()
{
	srand(time(NULL));
	setup();
	while (!gameover)
	{
		draw();
		input();
		logic();
	}
	
}

