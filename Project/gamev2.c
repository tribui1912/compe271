#include <ncurses.h>
#include <stdlib.h>
#include <time.h>

#define NUM_EQUATIONS 3
#define MAX_LEVEL 5

/// Creating new data structure "MathEquation"
typedef struct {
    char equation[16]; /// storing the equation
    int answer; /// storing answer of equation
} MathEquation;

/// Function to generate random equation
void generateRandomEquation(MathEquation *equation, int max_operand) {
    int num1 = rand() % (max_operand + 1);
    int num2 = rand() % (max_operand + 1);
    char operators[] = "+-*/";
    char op = operators[rand() % 4];

    switch (op) {
        case '+':
            equation->answer = num1 + num2;
            break;
        case '-':
            equation->answer = num1 - num2;
            break;
        case '*':
            equation->answer = num1 * num2;
            break;
        case '/':
            while (num2 == 0) {
                num2 = rand() % (max_operand + 1);
            }
            equation->answer = num1 / num2;
            break;
    }

    snprintf(equation->equation, sizeof(equation->equation), "%d %c %d", num1, op, num2);
}

/// Function to display equation and selection
void displayEquations(MathEquation equations[NUM_EQUATIONS], int position, int level, int total, int enemies) {
    clear();
    printw("Welcome to MathGame!\n");
    printw("Level: %d\n", level);
    printw("Army: %d\n", total);
    printw("Enemies: %d\n\n", enemies);
    printw("Use the left and right arrow keys to choose an equation.\n");
    printw("Press 'Enter' to select the equation.\n\n");

    for (int i = 0; i < NUM_EQUATIONS; i++) {
        if (i == position) {
            printw("[ %s ] ", equations[i].equation);
        } else {
            printw("  %s   ", equations[i].equation);
        }
    }

    refresh();
}

/// Main game
int main() {
    srand(time(NULL));

    int level = 1;
    int total = 0;

    int enemies = 0;
    MathEquation allEquations[MAX_LEVEL][NUM_EQUATIONS];

    for (int l = 0; l < MAX_LEVEL; l++) {
        int max_score = 0;
        for (int i = 0; i < NUM_EQUATIONS; i++) {
            generateRandomEquation(&allEquations[l][i], (l + 1) * 2);
            if (allEquations[l][i].answer > max_score) {
                max_score = allEquations[l][i].answer;
            }
        }
        enemies += max_score;
		enemies += -1;
    }
	/// Using initscr to setup ncurses and clear screen
    initscr();
	/// Put terminal to raw mode (passing all input directly to app)
    raw();
	/// Enables keypad (to use left right key)
    keypad(stdscr, TRUE);
	/// Disable the automatic echoing of keyboard input so it doesn't show what is user input
    noecho();

    while (level <= MAX_LEVEL) {
        int position = 0;

        displayEquations(allEquations[level - 1], position, level, total, enemies);

        while (1) {
            int input = getch();
            if (input == KEY_LEFT) {
                position = (position - 1 + NUM_EQUATIONS) % NUM_EQUATIONS;
            } else if (input == KEY_RIGHT) {
                position = (position + 1) % NUM_EQUATIONS;
            } else if (input == 10) { // Enter key           
                break;
            }
            displayEquations(allEquations[level - 1], position, level, total, enemies);
        }

        total += allEquations[level - 1][position].answer;
        level++;
    }


	/// Restore terminal to normal state, flushing initscr(),raw(),keypad() and noecho()
    endwin();

    printf("\nYou completed all levels!\n");
    printf("Your army is: %d\n", total);
    printf("Total number of enemies: %d\n", enemies);
	if (total - enemies > 0){
		printf("You won\n");
	} else printf("You lost, good luck next time\n");
    printf("Thank you for playing MathGame!\n");

    return 0;
}
