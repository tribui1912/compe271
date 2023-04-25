.data
equation:          .space 16
answer:            .word 0
max_operand:       .word 0
operators:         .asciiz "+-*/"
newline:    	   .asciiz "\n"
str_format:    	   .asciiz "%d %c %d"
seed:	       	   .word 12345
welcome_msg:       .asciiz "Welcome to MathGame!\n"
level_msg:         .asciiz "Level: %d\n"
total_msg:         .asciiz "Total: %d\n"
enemies_msg:       .asciiz "Enemies: %d\n\n"
instructions_1:    .asciiz "Use the left and right arrow keys to move your character.\n"
instructions_2:    .asciiz "Press 'Enter' to select the equation above your character.\n\n"
hash_string:       .asciiz "###"
space_string:      .asciiz "   "
space2_string:     .asciiz "  "
complete_msg:      .asciiz "\nYou completed all levels!\n"
total_score_msg:   .asciiz "Your total score is: %d\n"
total_enemies_msg: .asciiz "Total number of enemies: %d\n"
thank_you_msg:     .asciiz "Thank you for playing MathGame!\n"


.text
.globl main
main:
    # Initialize the stack
    addi $sp, $sp, -24

    # Call generateRandomEquation
    la $a0, equation
    lw $a1, max_operand
    jal generateRandomEquation
   
   
    # Save registers
    addi $sp, $sp, -40
    sw $ra, 36($sp)
    sw $s0, 32($sp)
    sw $s1, 28($sp)
    sw $s2, 24($sp)
    sw $s3, 20($sp)
    sw $s4, 16($sp)
    sw $s5, 12($sp)
    sw $s6, 8($sp)
    sw $s7, 4($sp)

    # Initialize variables
    li $s0, 1       # level
    li $s1, 0       # total
    li $s2, 0       # enemies

    # TODO: srand(time(NULL));

    # Generate allEquations and calculate enemies
    # for (int l = 0; l < MAX_LEVEL; l++) { ... }

    # TODO: Call initscr(), raw(), keypad(stdscr, TRUE), and noecho() functions

level_loop:
    # Check if level <= MAX_LEVEL
    li $t0, MAX_LEVEL
    bgt $s0, $t0, level_loop_end

    # Initialize position
    li $s3, 0       # position

    # Call displayEquations function
    # TODO: displayEquations(allEquations[level - 1], position, level, total, enemies);

input_loop:
    # TODO: Replace getch() with appropriate MIPS32 equivalent
    li $t1, KEY_LEFT
    beq $v0, $t1, move_left

    li $t1, KEY_RIGHT
    beq $v0, $t1, move_right

    li $t1, 10 # Enter key
    beq $v0, $t1, input_loop_end

    j input_loop

move_left:
    # position = (position - 1 + NUM_EQUATIONS) % NUM_EQUATIONS;
    # TODO: Implement position update logic
    j input_loop

move_right:
    # position = (position + 1) % NUM_EQUATIONS;
    # TODO: Implement position update logic
    j input_loop

input_loop_end:
    # total += allEquations[level - 1][position].answer;
    # TODO: Implement total update logic

    # Increment level
    addi $s0, $s0, 1

    j level_loop

level_loop_end:
    # TODO: Call endwin() function

    # Print final messages
    # TODO: Replace printf() calls with appropriate MIPS32 equivalents
    # printf(complete_msg);
    # printf(total_score_msg, total);
    # printf(total_enemies_msg, enemies);
    # printf(thank_you_msg);

    # Restore registers and return
    lw $ra, 36($sp)
    lw $s0, 32($sp)
    lw $s1, 28($sp)
    lw $s2, 24($sp)
    lw $s3, 20($sp)
    lw $s4, 16($sp)
    lw $s5, 12($sp)
    lw $s6, 8($sp)
    lw $s7, 4($sp)
    addi $sp, $sp, 40
    jr $ra

    # Return 0
    li $v0, 0
    jr $ra
    
    # Exit the program
    li $v0, 10
    syscall



.globl generateRandomEquation
generateRandomEquation:
    # Save registers
    addi $sp, $sp, -32
    sw $ra, 28($sp)
    sw $s0, 24($sp)
    sw $s1, 20($sp)
    sw $s2, 16($sp)
    sw $s3, 12($sp)
    sw $s4, 8($sp)
    sw $s5, 4($sp)
    sw $s6, 0($sp)

    # Initialize random numbers
    jal rand
    move $s0, $v0
    lw $t0, max_operand
    addi $t0, $t0, 1
    div $s0, $t0
    mfhi $s0
    jal rand
    move $s1, $v0
    lw $t1, max_operand
    addi $t1, $t1, 1
    div $s1, $t1
    mfhi $s1

    # Get random operator
    jal rand
    andi $v0, $v0, 3
    la $t2, operators
    add $t2, $t2, $v0
    lbu $s2, 0($t2)

    # Perform the operation and store result in $s3
    li $t3, '+'
    beq $s2, $t3, add
    li $t3, '-'
    beq $s2, $t3, subtract
    li $t3, '*'
    beq $s2, $t3, multiply
    li $t3, '/'
    beq $s2, $t3, divide

add:
    add $s3, $s0, $s1
    j operation_end
subtract:
    sub $s3, $s0, $s1
    j operation_end
multiply:
    mul $s3, $s0, $s1
    j operation_end
divide:
    beqz $s1, divide_zero
    div $s0, $s1
    mflo $s3
    j operation_end
divide_zero:
    jal rand
    move $s1, $v0
    lw $t1, max_operand
    addi $t1, $t1, 1
    div $s1, $t1
    mfhi $s1
    j divide

operation_end:
    # Store result in the answer field of the struct
    sw $s3, 16($a0)

    # Create the string with snprintf
    la $a1, str_format
    move $a2, $s0
    move $a3, $s2
    move $t4, $s1
    addi $sp, $sp, -20
    sw $a0, 16($sp)
    sw $a1, 12($sp)
    sw $a2, 8($sp)
    sw $a3, 4($sp)
    sw $t4, 0($sp)
    li $v0, 13
    syscall
    addi $sp, $sp, 20

    # Restore registers and return
    lw $ra, 28($sp)
    lw $s0, 24($sp)
    lw $s1, 20($sp)
    lw $s2, 16($sp)
    lw $s3, 12($sp)
    lw $s4, 8($sp)
    lw $s5, 4($sp)
    lw $s6, 0($sp)
    addi $sp, $sp, 32
    jr $ra

.globl rand
rand:
    # Seed for random number generator
    .data

    .text
    lw $t0, seed
    li $t1, 1103515245
    li $t2, 12345
    li $t3, 0x7fffffff

    mul $t0, $t0, $t1
    add $t0, $t0, $t2
    and $t0, $t0, $t3

    sw $t0, seed
    move $v0, $t0
    jr $ra

.globl displayEquations
displayEquations:
    # Save registers
    addi $sp, $sp, -48
    sw $ra, 44($sp)
    sw $s0, 40($sp)
    sw $s1, 36($sp)
    sw $s2, 32($sp)
    sw $s3, 28($sp)
    sw $s4, 24($sp)
    sw $s5, 20($sp)
    sw $s6, 16($sp)
    sw $s7, 12($sp)
    sw $a0, 8($sp)
    sw $a1, 4($sp)
    sw $a2, 0($sp)

    # TODO: Call clear() function

    # Print welcome message and instructions
    # TODO: Replace printw() calls with appropriate MIPS32 equivalent
    # printw(welcome_msg);
    # printw(level_msg, level);
    # printw(total_msg, total);
    # printw(enemies_msg, enemies);
    # printw(instructions_1);
    # printw(instructions_2);

    # Calculate enemies_per_column
    lw $s0, 4($sp) # enemies
    lw $s1, 0($sp) # NUM_EQUATIONS
    addi $s0, $s0, -1
    add $s0, $s0, $s1
    div $s0, $s1
    mfhi $s2

    # j loop
j_loop:
    # Initialize j loop counter
    li $t0, 0

    # i loop
i_loop:
    # Initialize i loop counter
    li $t1, 0

    # TODO: Implement printw("###") or printw("   ") based on condition
    # TODO: Implement printw("  ") if (i < NUM_EQUATIONS - 1)

    # Increment i loop counter and check the termination condition
    addi $t1, $t1, 1
    lw $t2, 0($sp)
    bge $t1, $t2, i_loop_end
    j i_loop

i_loop_end:
    # TODO: Implement printw("\n")

    # Increment j loop counter and check the termination condition
    addi $t0, $t0, 1
    bge $t0, $s2, j_loop_end
    j j_loop

j_loop_end:
    # Print equations
    # Initialize i loop counter
    li $t1, 0

equation_loop:
    # TODO: Implement printw(" %s  ", equations[i].equation)

    # Increment i loop counter and check the termination condition
    addi $t1, $t1, 1
    lw $t2, 0($sp)
    bge $t1, $t2, equation_loop_end
    j equation_loop

equation_loop_end:
    # TODO: Implement printw("\n")

    # Print player position
    # Initialize i loop counter
    li $t1, 0

position_loop:
    lw $t2, 8($sp) # position
    beq $t1, $t2, print_at

    # TODO: Implement printw("           ")

    j position_loop_skip

print_at:
    # TODO: Implement printw("     @     ")

position_loop_skip:
    # Increment i loop counter and check the termination condition
    addi $t1, $t1, 1
    lw $t2, 0($sp)
    bge $t1, $t2, position_loop_end
    j position_loop

position_loop_end:
    # TODO: Call refresh() function

    # Restore registers and return
    lw $ra, 44($sp)
    lw $s0, 40($sp)
    lw $s1, 36($sp)
    lw $s2, 32($sp)
    lw $s3, 28($sp)
    lw $s4, 24($sp)
    lw $s5, 20($sp)
    lw $s6, 16($sp)
    lw $s7, 12($sp)
    lw $a0, 8($sp)
    lw $a1, 4($sp)
    lw $a2, 0($sp)
    addi $sp, $sp, 48
    jr $ra
