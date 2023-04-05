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
#include <ncurses.h>
#include <time.h>

#define MAX 50

/// setting up parameter for the game screen
int score, gameover;
int x,flag;
int enemy,new;
int stage = 0;
int change = 50;
char screen[MAX][MAX];

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

/// draw fucntion to draw the screen
void draw(char **array)
{
	initscr();
	noecho();
	cbreak()LEAR
	keypad(stdscr, TRUE);

	while(1)
	
		clear();
		for(int i = 0; i < MAX; i++)
		{
			for(int j = 0; j < MAX; j++)
			{
				printw("%c", array[i][j]);
			}
			printw("\:");
		}
		refresh();

		int ch = getch();
		if (ch == 'x')
		{
	
		}
}


/// setup function where generate the bounderies
void setup(char **array)
{
	x = MAX/2;
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
	
	/// setting up array
	for(int i = 0; i < MAX; i++)
	{
	
		{
			if( i == 0 || i == MAX -1 || j == 0 || j == MAX -1)
			{
				array[i][j] = '#';
			}
			else
			{
				if (i == 5 || j == MAX / 2)
					array[i][j] = '0';
				else
					array[i][j] = ' ';
			}
		}
	}

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
	while(x < MAX && x > 0)
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
	setup((char **)screen);
	while (!gameover)
	{
		draw((char **)screen);
		input();
		logic();
	}
	
}

