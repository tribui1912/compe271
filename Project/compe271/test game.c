#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define ROWS 5
#define COLS 5

int player_pos = 2; // start player at column 2 (0-based indexing)
int num_enemies = 5; // number of enemies to defeat
int enemies_defeated = 0; // number of enemies defeated so far

// Function to print the game board
void print_board(int board[ROWS][COLS]) {
    int row, col;
    for (row = 0; row < ROWS; row++) {
        for (col = 0; col < COLS; col++) {
            if (board[row][col] == 0) {
                printf(" "); // empty space
            } else if (board[row][col] == 1) {
                printf("P"); // player
            } else if (board[row][col] == 2) {
                printf("%d", enemies_defeated + 1); // enemy
            } else {
                printf("%c", board[row][col]); // math operator
            }
            printf(" ");
        }
        printf("\n");
    }
}

// Function to generate a random number
int generate_random_number(int max_number) {
    srand(time(NULL));
    return rand() % max_number + 1;
}

// Function to generate a random math equation
void generate_math_equation(int *num1, int *num2, char *operator) {
    int random_operator = rand() % 3; // 0 = +, 1 = -, 2 = *
    *num1 = generate_random_number(10); // generate first random number between 1 and 10
    *num2 = generate_random_number(10); // generate second random number between 1 and 10
    switch (random_operator) {
        case 0:
            *operator = '+';
            break;
        case 1:
            *operator = '-';
            break;
        case 2:
            *operator = '*';
            break;
    }
}

// Function to get player input and update game state
void handle_player_input(int board[ROWS][COLS]) {
    char input;
    scanf(" %c", &input);
    if (input == 'a') { // move left
        if (player_pos > 0) {
            board[ROWS-1][player_pos] = 0; // clear current player position
            player_pos--;
            board[ROWS-1][player_pos] = 1; // set new player position
        }
    } else if (input == 'd') { // move right
        if (player_pos < COLS-1) {
            board[ROWS-1][player_pos] = 0; // clear current player position
            player_pos++;
            board[ROWS-1][player_pos] = 1; // set new player position
        }
    } else if (input == '1' || input == '2' || input == '3') { // select math equation
        int selected_equation = input - '0'; // convert char input to int
        int num1, num2;
        char operator;
        generate_math_equation(&num1, &num2, &operator); // generate new math equation
        int result;
        switch (operator) { // calculate result of math equation
            case '+':
                result = num1 + num2;
                break;
            case '-':
                result = num1 - num2;
            case '*':
result = num1 * num2;
break;
}
if (selected_equation == (enemies_defeated + 1) && result == selected_equation) { // player selected correct equation
enemies_defeated++;
board[ROWS-1][player_pos] = 0; // clear current player position
player_pos = 2; // set player position back to center
board[ROWS-1][player_pos] = 1; // set new player position
if (enemies_defeated == num_enemies) {
printf("You win!\n");
exit(0); // exit program
}
} else { // player selected incorrect equation
printf("Incorrect equation selected. Try again.\n");
}
}
}

int main() {
int board[ROWS][COLS] = { // initialize game board
{0, 0, ' ', 0, 0},
{0, 0, ' ', 0, 0},
{0, 0, ' ', 0, 0},
{0, 0, ' ', 0, 0},
{0, 0, 1, 0, 0}
};
 while (1) { // game loop
    system("clear"); // clear console
    print_board(board);
    handle_player_input(board);
}   
}
