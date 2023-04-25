#Author: Tri Bui
#Date: 04/24/2023
#Description: Simple text-based math game, player select the option that have the biggest value to win the game.
# Register List 
		# $t0 - level
		# $t1 - total
		# $t2 - enemies
		# $t3 - max_level
		# $t4 - num_equation
		# $t5 - use for i int counter
		# $t6 - use for j int counter
		
		
#.eqv is equivalent to #DEFINE in C
.eqv	NUM_EQUATIONS 3
.eqv	MAX_LEVEL 5
.eqv	KEY_LEFT 97 #ascii of a is 97
.eqv	KEY_RIGHT 100 #ascii of a is 100


.data
welcomestr:		.asciiz "Welcome to MathGame!\n"
levelstr:		.asciiz "Level: "
totalstr:		.asciiz "Total: "
enemystr:		.asciiz "Enemies: "
instrstr:		.asciiz "Use the (a and d) for left and right to move your character.\n"
enterstr:		.asciiz "Press 'Enter' to select the equation above your character.\n\n"
hashstr:		.asciiz "###"
spacestr:		.asciiz "   "
space2str:		.asciiz "  "
space1str:		.asciiz " "
charstr:		.asciiz "   @   "
morespaces:		.asciiz "       "
completegame:		.asciiz "\nYou completed all levels!\n"
score:			.asciiz "Your total score is: "
enemies:		.asciiz "Total number of enemies: "
endgame:		.asciiz "Thank you for playing MathGame!\n"

newline:		.asciiz "\n"


operators:	.asciiz "+-*/"
allEquations:	.word	0

buffer:		.space	10


.text 
li 	$v0, 30	# read time
syscall         
move 	$t0, $a0  

li 	$v0, 40     	# seed
move 	$a0, $zero  
move	$a1, $t0     
syscall

li	$t0, 1	# int level = 1;
li	$t1, 0	# int total = 0;
li	$t2, 0	# int enemies = 0;


# MathEquation allEquations[MAX_LEVEL][NUM_EQUATIONS];
li	$t3, MAX_LEVEL	# load MAX_LEVEL
li	$t4, NUM_EQUATIONS	# load NUM_EQUATIONS
li	$v0, 9		# create dynamic array
mul	$a0, $t3, $t4	# MAX_LEVEL * NUM_EQUATIONS
sll	$a0, $a0, 2	# multiply with 4 to make word aligned
syscall
sw	$v0, allEquations	# MathEquation allEquations[MAX_LEVEL][NUM_EQUATIONS];
lw	$t8, allEquations

li	$t5, 0		# i = 0
ifor:
beq	$t5, $t3, stop_ifor	# for (int i = 0; i < MAX_LEVEL; i++) 
li	$t6, 0			# j = 0
jfor:
beq	$t6, $t4, stop_jfor	# for (int j = 0; j < NUM_EQUATIONS; j++)

mul 	$t7, $t5, $t4		# row_index * col_size
add 	$t7, $t7, $t6		# add col_index
sll	$t7, $t7, 2		# multiply with 4 to make word aligned
add	$t7, $t7, $t8

li	$v0, 9
li	$a0, 20			# create struct of MathEquation
syscall
sw	$v0, 0($t7)		# store struct on allEquations[i][j]

addi	$t6, $t6, 1		# j++
j	jfor
stop_jfor:
	
addi	$t5, $t5, 1		# i++
j	ifor
stop_ifor:


li	$t5, 0		# l = 0
lfor1:
beq	$t5, $t3, stop_lfor1	# for (int l = 0; l < MAX_LEVEL; l++) 
li	$t9, 0			# int max_score = 0;
li	$t6, 0			# i = 0
ifor1:
beq	$t6, $t4, stop_ifor1	# for (int i = 0; i < NUM_EQUATIONS; i++)

mul 	$t7, $t5, $t4		# row_index * col_size
add 	$t7, $t7, $t6		# add col_index
sll	$t7, $t7, 2		# multiply with 4 to make word aligned
add	$t7, $t7, $t8

lw	$a0, 0($t7)		# pass &allEquations[l][i]
addi	$a1, $t5, 1		# l + 1
mul	$a1, $a1, 2		# (l + 1) * 2
jal	generateRandomEquation	# generateRandomEquation(&allEquations[l][i], (l + 1) * 2);

lw	$s0, 0($t7)		# allEquations[l][i]
lw	$s1, 16($s0)		# allEquations[l][i].answer
ble	$s1, $t9, next_ifor1	# if (allEquations[l][i].answer > max_score) 
move	$t9, $s1		# max_score = allEquations[l][i].answer;

next_ifor1:
addi	$t6, $t6, 1		# i++
j	ifor1
stop_ifor1:
add	$t2, $t2, $t9		# enemies += max_score;

addi	$t5, $t5, 1		# l++
j	lfor1
stop_lfor1:


while_level:
bgt	$t0, MAX_LEVEL, out_while_level	# while (level <= MAX_LEVEL)
li	$t9, 0		# position = 0

# displayEquations(allEquations[level - 1], position, level, total, enemies);
addi	$sp, $sp, -20

addi	$t3, $t0, -1		# level - 1
sll	$t3, $t3, 2		# multiply with 4 to make word aligned
lw	$t4, allEquations	# address allEquations
add	$t4, $t4, $t3
sw	$t4, 0($sp)		# pass allEquations[level - 1]
sw	$t9, 4($sp)		# pass position
sw	$t0, 8($sp)		# pass level
sw	$t1, 12($sp)		# pass total
sw	$t2, 16($sp)		# pass enemies
jal	displayEquations

while_1:	# while(1)
li	$v0, 12	# scanf("%d", &input);
syscall
bne	$a0, KEY_LEFT, main_else_if	# if (input == KEY_LEFT)
addi	$t3, $t9, -1	# position - 1
addi	$t3, $t3, NUM_EQUATIONS	 # (position - 1 + NUM_EQUATIONS)
li	$t4, NUM_EQUATIONS	 # load NUM_EQUATIONS
div	$t3, $t4		 # (position - 1 + NUM_EQUATIONS) % NUM_EQUATIONS;
mfhi	$t9			# position = (position - 1 + NUM_EQUATIONS) % NUM_EQUATIONS;
j	call_dis_func

main_else_if:
bne	$a0, KEY_RIGHT, main_else	# if (input == KEY_RIGHT)
addi	$t3, $t9, 1			# position + 1
li	$t4, NUM_EQUATIONS	 	# load NUM_EQUATIONS
div	$t3, $t4		 	# (position + 1) % NUM_EQUATIONS;
mfhi	$t9				# position = (position + 1) % NUM_EQUATIONS;
j	call_dis_func

main_else:
beq	$a0, 10, _break1			# else if (input == 10)

call_dis_func:
addi	$t3, $t0, -1		# level - 1
sll	$t3, $t3, 2		# multiply with 4 to make word aligned
lw	$t4, allEquations	# address allEquations
add	$t4, $t4, $t3
sw	$t4, 0($sp)		# pass allEquations[level - 1]
sw	$t9, 4($sp)		# pass position
sw	$t0, 8($sp)		# pass level
sw	$t1, 12($sp)		# pass total
sw	$t2, 16($sp)		# pass enemies
jal	displayEquations

j	while_1

# total += allEquations[level - 1][position].answer;
lw	$t8, allEquations	# load allEquations
li	$t4, NUM_EQUATIONS
addi	$t3, $t0, -1		# level - 1
mul 	$t7, $t3, $t4		# row_index * col_size
add 	$t7, $t7, $t9		# add col_index
sll	$t7, $t7, 2		# multiply with 4 to make word aligned
add	$t7, $t7, $t8
lw	$t7, 0($t7)
lw	$t7, 16($t7)		# allEquations[level - 1][position].answer
add	$t1, $t1, $t7		# total += allEquations[level - 1][position].answer

addi	$t0, $t0, 1		# level++;

j	while_level

_break1:
out_while_level:
li	$v0, 4		# print string
la	$a0, completegame	# printf("\nYou completed all levels!\n");
syscall


li	$v0, 4		# print string
la	$a0, score	# printf("Your total score is: %d\n", total);
syscall
li	$v0, 1
move	$a0, $t1	# print total
syscall
li	$v0, 4		# print string
la	$a0, newline	# printf("\n");
syscall

# printf("Total number of enemies: %d\n", enemies);
li	$v0, 4		# print string
la	$a0, enemies	
syscall
li	$v0, 1
move	$a0, $t2	# print enemies
syscall
li	$v0, 4		# print string
la	$a0, newline	# printf("\n");
syscall

# printf("Thank you for playing MathGame!\n");
li	$v0, 4		# print string
la	$a0, endgame	
syscall

quit:
li	$v0, 10		# terminate program
syscall




############################# generateRandomEquation ##########################
generateRandomEquation:
	addi	$sp, $sp, -28	# make space on stack
	sw	$s0, 0($sp)	# save registers on stack
	sw	$s1, 4($sp)
	sw	$s2, 8($sp)
	sw	$s3, 12($sp)
	sw	$s4, 16($sp)
	sw	$s5, 20($sp)
	sw	$ra, 24($sp)
	
	move	$s7, $a0	# move equation in $s7
	move	$s1, $a1	# move max_operand in $s1
	
	li	$v0, 42		# generate random number
	addi	$a1, $s1, 1	# int num1 = rand() % (max_operand + 1);
	syscall
	move	$s2, $a0	# num1
	
	li	$v0, 42		# generate random number
	addi	$a1, $s1, 1	# int num2 = rand() % (max_operand + 1);
	syscall
	move	$s3, $a0	# num2
	
	li	$v0, 42		# generate random number
	addi	$a1, $0, 4	# rand() % 4
	syscall
	move	$s4, $a0	# temp
	
	lb	$s4, operators($s4)	# char op = operators[rand() % 4];
					# switch (op)
	bne	$s4, '+', case_min	# op '+':
	add	$s5, $s2, $s3		# num1 + num2
	sw	$s5, 16($s7)		# equation->answer = num1 + num2;
        j	_break			# break
	
	case_min:
	bne	$s4, '-', case_mul	# op '-':
	sub	$s5, $s2, $s3		# num1 - num2
	sw	$s5, 16($s7)		# equation->answer = num1 - num2;
        j	_break			# break
	
	case_mul:
	bne	$s4, '*', case_div	# op '*':	
	mul	$s5, $s2, $s3		# num1 * num2
	sw	$s5, 16($s7)		# equation->answer = num1 * num2;
        j	_break			# break
	
	case_div:
	bne	$s4, '/', no_op		# op '/':
		while_gn_ran:
		bne	$s3, $0, out_while_gn_ran	# while(num2==0)
		li	$v0, 42		# generate random number
		addi	$a1, $s1, 1	# int num2 = rand() % (max_operand + 1);
		syscall
		move	$s3, $a0	# num2
		j	while_gn_ran	# jump to while_gn_ran
	out_while_gn_ran:
	div	$s5, $s2, $s3		# num1 / num2
	sw	$s5, 16($s7)		# equation->answer = num1 / num2;
        j	_break			# break
        no_op:
        _break:
        
        move	$a0, $s2	# store num1
        move	$a1, $s7	# pass equation
        jal	atoi
        add	$s7, $s7, $v0
        
        li	$a0, ' '	# store ' '
        sb	$a0, ($s7)
        addi	$s7, $s7, 1
        
        sb	$s4, ($s7)	# store op
        addi	$s7, $s7, 1
        
        li	$a0, ' '	# store ' '
        sb	$a0, ($s7)
        addi	$s7, $s7, 1
        
        move	$a0, $s3	# store num2
        move	$a1, $s7
        jal	atoi 
        add	$s7, $s7, $v0
        sb	$0, ($s7)
            
        
	lw	$s0, 0($sp)	# restore registers from stack
	lw	$s1, 4($sp)
	lw	$s2, 8($sp)
	lw	$s3, 12($sp)
	lw	$s4, 16($sp)
	lw	$s5, 20($sp)
	lw	$ra, 24($sp)
	addi	$sp, $sp, 28	# release space from stack
	jr	$ra	# return back at caller address
	
	
############################# displayEquations ##########################	
displayEquations:
	
	li	$v0, 4	# print string
	la	$a0, welcomestr	# printf("Welcome to MathGame!\n");
	syscall
	
	li	$v0, 4	# print string
	la	$a0, levelstr	# printf("Level: %d\n", level);
	syscall
	
	lw	$a0, 8($sp)	# print level
	li	$v0, 1
	syscall
	
	la	$a0, newline	# print new line
	li	$v0, 4
	syscall
	
	li	$v0, 4	# print string
	la	$a0, totalstr	# printf("Total: %d\n", total);
	syscall
	
	lw	$a0, 12($sp)	# print total
	li	$v0, 1
	syscall
	
	la	$a0, newline	# print new line
	li	$v0, 4
	syscall
	
	li	$v0, 4	# print string
	la	$a0, enemystr	# printf("Enemies: %d\n\n", enemies);
	syscall
	
	lw	$a0, 16($sp)	# print enemy
	li	$v0, 1
	syscall
	
	la	$a0, newline	# print new line
	li	$v0, 4
	syscall
	
	la	$a0, instrstr	# print instrstr
	li	$v0, 4
	syscall
	
	
	lw	$s0, 16($sp)	# load enemies
	li	$s1, NUM_EQUATIONS
	add	$s2, $s0, $s1	# (enemies + NUM_EQUATIONS)
	addi	$s2, $s2, -1	# (enemies + NUM_EQUATIONS - 1)
	div	$s2, $s2, $s1	# int enemies_per_column = (enemies + NUM_EQUATIONS - 1) / NUM_EQUATIONS;
	
	li	$s3, 0		# j = 0
	for_j:
	beq	$s3, $s2, stop_for_j	# for (int j = 0; j < enemies_per_column; j++) 
	li	$s4, 0			# i = 0
	for_i:
	beq	$s4, $s1, stop_for_i	# for (int i = 0; i < NUM_EQUATIONS; i++)
	mul 	$s5, $s3, $s1		# j * NUM_EQUATIONS
	add	$s5, $s5, $s4		# j * NUM_EQUATIONS + i
	bge	$s5, $s0, dis_else	# if (j * NUM_EQUATIONS + i < enemies)
	li	$v0, 4		# print string
	la	$a0, hashstr	# printf("###");
	syscall
	j	out_cond
	dis_else:
	li	$v0, 4		# print string
	la	$a0, spacestr	# printf("   ");
	syscall
	out_cond:
	addi	$s6, $s1, -1	# NUM_EQUATIONS - 1
	bge	$s4, $s6, next_i_dis	# if (i < NUM_EQUATIONS - 1)
	li	$v0, 4		# print string
	la	$a0, space2str	# printf("  ");
	syscall
	
	next_i_dis:
	addi	$s4, $s4, 1	# i++
	j	for_i
	stop_for_i:
	li	$v0, 4		# print string
	la	$a0, newline	# printf("\n");
	syscall
	
	addi	$s3, $s3, 1		# j++
	j	for_j
	stop_for_j:
	
	li	$s4, 0			# i = 0
	for_i1:
	beq	$s4, $s1, stop_for_i1	# for (int i = 0; i < NUM_EQUATIONS; i++)
	li	$v0, 4		# print string
	la	$a0, space1str	# printf(" ");
	syscall
	
	sll	$s5, $s4, 2	# multiply with 4
	lw	$s6, 0($sp)	# equations
	add	$s6, $s6, $s5
	lw	$a0, 0($s6)	# printf(" %s  ", equations[i].equation);
	syscall
	
	li	$v0, 4		# print string
	la	$a0, space2str	# printf("  ");
	syscall
		
	addi	$s4, $s4, 1		# i++
	j	for_i1
	stop_for_i1:
	li	$v0, 4		# print string
	la	$a0, newline	# printf("\n");
	syscall
	
	li	$s4, 0			# i = 0
	lw	$s5, 4($sp)		# load position
	for_i2:
	beq	$s4, $s1, stop_for_i2	# for (int i = 0; i < NUM_EQUATIONS; i++)
	bne	$s4, $s5, dis_else1	# if (i == position) 
	li	$v0, 4		# print string
	la	$a0, charstr	# printf("   @   ");
	syscall
	j	next_ifor2
	
	dis_else1:
	li	$v0, 4		# print string
	la	$a0, morespaces	# printf("       ");
	syscall
	
	next_ifor2:	
	addi	$s4, $s4, 1		# i++
	j	for_i2
	stop_for_i2:
	
	jr	$ra	# return back at caller address
	
	
#############################atoi##########################
atoi:
	li	$s0, 0	# length = 0
	li	$s1, 10	# load 10 
	atoi_while:
	beq	$a0, $0, stop_atoi_while	# stop when num is 0
	addi	$s0, $s0, 1	# length++
	
	div	$a0, $s1	
	mfhi	$s5	# num % 10
	mflo	$a0	# num / 10
	addi	$s5, $s5, 48	# convert int to ascii
	
	addi	$sp, $sp, -1
	sb	$s5, ($sp)
	
	j	atoi_while
	stop_atoi_while:
	move	$v0, $s0	# move length
	store_loop:
	beq	$s0, $0, stop_store_loop	# stop when length is 0
	lb	$s5, ($sp)	# load char
	addi	$sp, $sp, 1	# release space
	sb	$s5, ($a1)	# store byte
	addi	$a1, $a1, 1	# update address of equation 
	
	addi	$s0, $s0, -1		# length--
	j	store_loop
	stop_store_loop:
	
	
	jr	$ra	# return back at caller address
