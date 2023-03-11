.data
Array : .word 1 2 3 4 5
.word 6 7 8 9 10
.word 11 12 13 14 15
prompt1: .asciiz "\nPlease enter value of Row : "
prompt2: .asciiz "\nPlease enter value of Col : "
prompt3: .asciiz "\nThe value of the choosen element is : "
prompt4: .asciiz "\nThe address of the choosen element is : "

.text
la $s0,Array #load array
li $s1,5 #load ncolumns

li $v0,4
la $a0,prompt1 #it will print prompt
syscall
li $v0,5
syscall #ask user input
move $s2,$v0 #save a to t1

li $v0,4
la $a0,prompt2 #it will print prompt
syscall
li $v0,5
syscall #ask user input
move $s3,$v0 #save a to t1

jal arrayAddress
move $t0,$v0 #store result

li $v0,4
la $a0,prompt4 #it will print prompt
syscall
li $v0,1
move $a0,$t0
syscall


li $v0,4
la $a0,prompt3 #it will print prompt
syscall
li $v0,1
lw $a0,($t0)
syscall


li $v0,10
syscall #terminate


arrayAddress:
sub $t1,$s2,1 #get row-1
sub $t2,$s3,1 #get col-1

sll $t3,$t1,2 #get result of row*4
add $t3,$t3,$t1 #get result of row*5
add $t3,$t3,$t2 #get result of row*5 + col

sll $t3,$t3,2 #get address of row*5 + col
add $v0,$t3,$s0 #get address of array(row*5 + col)
jr $ra #return to caller