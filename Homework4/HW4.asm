.data
    seed: .word 0xF00F5AA5 # Initial seed value
    space: .asciiz " "
.text
.globl lfsr
lfsr:
    # Load the seed value into a register
    lw $t0, seed

    # Set the loop counter
    li $t1, 10    # Set the loop counter to 10

    # Loop to generate 10 numbers
    loop:
        # XOR the selected bits of the LFSR
        srl $t0, $t0, 30
        srl $t0, $t0, 4
        srl $t0, $t0, 1

        # Shift the result into bit 1 (MSB) and shift all other bits right
        sll $t0, $t0, 31
        srl $t0, $t0, 1

        # Multiply the value in $t2 by 4 and add it to the current LFSR value
        sll $t2, $t2, 2      # Multiply $t2 by 4
        add $t0, $t0, $t2    # Add $t2 to $t0

        # Print the current value of the LFSR
        li $v0, 1
        move $a0, $t0
        syscall
        li $v0, 11
        la $a0, space
        syscall

        # Decrement the loop counter and continue if not 0
        addi $t1, $t1, -1
        bnez $t1, loop

    # Return from the function
    jr $ra
