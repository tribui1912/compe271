.eqv	NUM_EQUATIONS 3
.eqv	MAX_LEVEL 5

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


newline:		.asciiz "\n"


operators:	.asciiz "+-*/"
MathEquation:	.word	0:5
# typedef struct {
#    char equation[16]; /// storing the equation
#    int answer; /// storing answer of equation
# } MathEquation;


.text 


li	$v0, 10		# terminate program
syscall

############################# generateRandomEquation ##########################
generateRandomEquation:
	move	$s0, $a0	# move equation in $s0
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
	addi	$s0, $s0, 16		# equation->answer
	add	$s5, $s2, $s3		# num1 + num2
	sw	$s5, ($s0)		# equation->answer = num1 + num2;
        j	_break			# break
	
	case_min:
	bne	$s4, '-', case_mul	# op '-':
	addi	$s0, $s0, 16		# equation->answer
	sub	$s5, $s2, $s3		# num1 - num2
	sw	$s5, ($s0)		# equation->answer = num1 - num2;
        j	_break			# break
	
	case_mul:
	bne	$s4, '*', case_div	# op '*':	
	addi	$s0, $s0, 16		# equation->answer
	mul	$s5, $s2, $s3		# num1 * num2
	sw	$s5, ($s0)		# equation->answer = num1 * num2;
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
	addi	$s0, $s0, 16		# equation->answer
	div	$s5, $s2, $s3		# num1 / num2
	sw	$s5, ($s0)		# equation->answer = num1 / num2;
        j	_break			# break
        no_op:
        _break:
        li	$v0, 1		# print int
        move	$a0, $s2	# print num1
        syscall
        
        li	$v0, 11		# print char
        li	$a0, ' '	# print ' '
        syscall
        
        move	$a0, $s4	# print op
        syscall
        
        li	$a0, ' '	# print ' '
        syscall
        
        li	$v0, 1		# print int
        move	$a0, $s3	# print num2
        syscall
        
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
	j	out_cond
	out_cond:
	
	
	addi	$s4, $s4, 1		# i++
	j	for_i
	stop_for_i:
	
	
	
	addi	$s3, $s3, 1		# j++
	j	for_j
	stop_for_j:
	
	
	jr	$ra	# return back at caller address
