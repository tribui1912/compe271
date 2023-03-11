# Author:	Tri Bui
# Date:		March 10, 2023
# Description:	Homework #3: Find 2D array content by row/col

.data
askrow:	.asciiz	"Enter row in the range [0..2]: "
askcol:	.asciiz	"Enter column in the range [0..4]: "
print:	.asciiz	"array[row][col] = "

# array oinitialization
array:
	.word	  1, 2, 3, 4, 5
	.word	  6, 7, 8, 9,10
	.word	  11,12,13,14,15


.text
la $s0,array #load array
li $s1,5 #load ncolumns

li $v0,4
la $a0,askrow #print prompt
syscall
li $v0,5
syscall #ask user input
move $s2,$v0 

li $v0,4
la $a1,askcol #print prompt
syscall
li $v0,5
syscall #ask user input
move $s3,$v0 

jal arrayAddress
move $t0,$v0 #store result

li $v0,4
la $a0,print #print prompt
syscall
li $v0,1
move $a0,$t0
syscall


li $v0,10
syscall #terminate


arrayAddress:
sll $t1, $s2,2
add $t1, $t1, $t1
add $t1, $t1, $s3

sll $t1, $t1, 2
add $v0, $t1, $s0

jr $ra #return to caller