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
                printw("###");
            } else {
                printw("   ");
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
    initscr();
    raw();
    keypad(stdscr, TRUE);
    noecho();

    int total = 0;
    int enemies = 0;

    for (int level = 1; level <= NUM_LEVELS; level++) {
        MathEquation equations[NUM_EQUATIONS];
        generateEquations(equations);

        int largest_answer = findLargestAnswer(equations);
        enemies += largest_answer;

        int score = playLevel(equations, level, total, enemies);
        total += score;
    }

    int result = total - enemies;

    clear();
    if (result == 0) {
        printw("Congratulations! You've won the game!\n");
    } else {
        printw("Sorry, you've lost the game. Better luck next time!\n");
    }

    printw("Press any key to exit...\n");
    refresh();
    getch();
    endwin();

    return 0;
}
