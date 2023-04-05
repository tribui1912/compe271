#include <ncurses.h>
#include <stdlib.h>
#include <time.h>

#define NUM_EQUATIONS 3
#define MAX_LEVEL 5

typedef struct {
    char equation[16];
    int answer;
} MathEquation;

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

void displayEquations(MathEquation equations[NUM_EQUATIONS], int position, int level, int total, int enemies) {
    clear();
    printw("Welcome to MathGame!\n");
    printw("Level: %d\n", level);
    printw("Total: %d\n", total);
    printw("Enemies: %d\n\n", enemies);
    printw("Use the left and right arrow keys to move your character.\n");
    printw("Press 'Enter' to select the equation above your character.\n\n");

    int enemies_per_column = (enemies + NUM_EQUATIONS - 1) / NUM_EQUATIONS;

    for (int j = 0; j < enemies_per_column; j++) {
        for (int i = 0; i < NUM_EQUATIONS; i++) {
            if (j * NUM_EQUATIONS + i < enemies) {
                printw("#");
            } else {
                printw(" ");
            }
            if (i < NUM_EQUATIONS - 1) {
                printw("  ");
            }
        }
        printw("\n");
    }

    for (int i = 0; i < NUM_EQUATIONS; i++) {
        printw(" %s  ", equations[i].equation);
    }

    printw("\n");
    for (int i = 0; i < NUM_EQUATIONS; i++) {
        if (i == position) {
            printw("  @  ");
        } else {
            printw("     ");
        }
    }

    refresh();
}

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
    }

    initscr();
    raw();
    keypad(stdscr, TRUE);
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

    endwin();

    printf("\nYou completed all levels!\n");
    printf("Your total score is: %d\n", total);
    printf("Total number of enemies: %d\n", enemies);
    printf("Thank you for playing MathGame!\n");

    return 0;
}
