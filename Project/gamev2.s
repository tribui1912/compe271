	.text
	.abicalls
	.option	pic0
	.section	.mdebug.abi32,"",@progbits
	.nan	legacy
	.text
	.file	"gamev2.c"
	.globl	generateRandomEquation          # -- Begin function generateRandomEquation
	.p2align	2
	.type	generateRandomEquation,@function
	.set	nomicromips
	.set	nomips16
	.ent	generateRandomEquation
generateRandomEquation:                 # @generateRandomEquation
	.frame	$fp,56,$ra
	.mask 	0xc01f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	.set	noat
# %bb.0:
	addiu	$sp, $sp, -56
	sw	$ra, 52($sp)                    # 4-byte Folded Spill
	sw	$fp, 48($sp)                    # 4-byte Folded Spill
	sw	$20, 44($sp)                    # 4-byte Folded Spill
	sw	$19, 40($sp)                    # 4-byte Folded Spill
	sw	$18, 36($sp)                    # 4-byte Folded Spill
	sw	$17, 32($sp)                    # 4-byte Folded Spill
	sw	$16, 28($sp)                    # 4-byte Folded Spill
	move	$fp, $sp
	move	$16, $4
	jal	rand
	addiu	$20, $5, 1
	div	$zero, $2, $20
	teq	$20, $zero, 7
	jal	rand
	mfhi	$17
	div	$zero, $2, $20
	lui	$1, %hi($__const.generateRandomEquation.operators)
	teq	$20, $zero, 7
	addiu	$19, $1, %lo($__const.generateRandomEquation.operators)
	jal	rand
	mfhi	$18
	sra	$1, $2, 31
	addiu	$3, $zero, -4
	srl	$1, $1, 30
	addu	$1, $2, $1
	and	$1, $1, $3
	subu	$1, $2, $1
	addu	$1, $19, $1
	lb	$19, 0($1)
	addiu	$2, $19, -42
	sltiu	$1, $2, 6
	beqz	$1, $BB0_9
	nop
$BB0_1:
	sll	$1, $2, 2
	lui	$2, %hi($JTI0_0)
	addu	$1, $1, $2
	lw	$1, %lo($JTI0_0)($1)
	jr	$1
	nop
$BB0_2:
	j	$BB0_8
	mul	$2, $18, $17
$BB0_3:
	j	$BB0_8
	addu	$2, $18, $17
$BB0_4:
	j	$BB0_8
	subu	$2, $17, $18
$BB0_5:
	bnez	$18, $BB0_7
	nop
$BB0_6:                                 # =>This Inner Loop Header: Depth=1
	jal	rand
	nop
	div	$zero, $2, $20
	teq	$20, $zero, 7
	mfhi	$18
	beqz	$18, $BB0_6
	nop
$BB0_7:
	div	$zero, $17, $18
	teq	$18, $zero, 7
	mflo	$2
$BB0_8:
	sw	$2, 16($16)
$BB0_9:
	lui	$1, %hi($.str)
	move	$4, $16
	addiu	$5, $zero, 16
	move	$7, $17
	sw	$18, 20($sp)
	sw	$19, 16($sp)
	jal	snprintf
	addiu	$6, $1, %lo($.str)
	move	$sp, $fp
	lw	$16, 28($sp)                    # 4-byte Folded Reload
	lw	$17, 32($sp)                    # 4-byte Folded Reload
	lw	$18, 36($sp)                    # 4-byte Folded Reload
	lw	$19, 40($sp)                    # 4-byte Folded Reload
	lw	$20, 44($sp)                    # 4-byte Folded Reload
	lw	$fp, 48($sp)                    # 4-byte Folded Reload
	lw	$ra, 52($sp)                    # 4-byte Folded Reload
	jr	$ra
	addiu	$sp, $sp, 56
	.set	at
	.set	macro
	.set	reorder
	.end	generateRandomEquation
$func_end0:
	.size	generateRandomEquation, ($func_end0)-generateRandomEquation
	.section	.rodata,"a",@progbits
	.p2align	2
$JTI0_0:
	.4byte	($BB0_2)
	.4byte	($BB0_3)
	.4byte	($BB0_9)
	.4byte	($BB0_4)
	.4byte	($BB0_9)
	.4byte	($BB0_5)
                                        # -- End function
	.text
	.globl	displayEquations                # -- Begin function displayEquations
	.p2align	2
	.type	displayEquations,@function
	.set	nomicromips
	.set	nomips16
	.ent	displayEquations
displayEquations:                       # @displayEquations
	.frame	$fp,48,$ra
	.mask 	0xc01f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	.set	noat
# %bb.0:
	addiu	$sp, $sp, -48
	sw	$ra, 44($sp)                    # 4-byte Folded Spill
	sw	$fp, 40($sp)                    # 4-byte Folded Spill
	sw	$20, 36($sp)                    # 4-byte Folded Spill
	sw	$19, 32($sp)                    # 4-byte Folded Spill
	sw	$18, 28($sp)                    # 4-byte Folded Spill
	sw	$17, 24($sp)                    # 4-byte Folded Spill
	sw	$16, 20($sp)                    # 4-byte Folded Spill
	move	$fp, $sp
	lui	$1, %hi(stdscr)
	move	$16, $4
	lw	$20, 64($fp)
	move	$18, $7
	move	$19, $6
	move	$17, $5
	jal	wclear
	lw	$4, %lo(stdscr)($1)
	lui	$1, %hi($.str.1)
	jal	printw
	addiu	$4, $1, %lo($.str.1)
	lui	$1, %hi($.str.2)
	move	$5, $19
	jal	printw
	addiu	$4, $1, %lo($.str.2)
	lui	$1, %hi($.str.3)
	move	$5, $18
	jal	printw
	addiu	$4, $1, %lo($.str.3)
	lui	$1, %hi($.str.4)
	move	$5, $20
	jal	printw
	addiu	$4, $1, %lo($.str.4)
	lui	$1, %hi($.str.5)
	jal	printw
	addiu	$4, $1, %lo($.str.5)
	lui	$1, %hi($.str.6)
	jal	printw
	addiu	$4, $1, %lo($.str.6)
	beqz	$17, $BB1_3
	nop
# %bb.1:
	lui	$1, %hi($.str.8)
	move	$5, $16
	addiu	$18, $1, %lo($.str.8)
	jal	printw
	move	$4, $18
	addiu	$1, $zero, 1
	bne	$17, $1, $BB1_4
	addiu	$5, $16, 20
# %bb.2:
	lui	$1, %hi($.str.7)
	jal	printw
	addiu	$4, $1, %lo($.str.7)
	j	$BB1_5
	nop
$BB1_3:
	lui	$1, %hi($.str.7)
	move	$5, $16
	jal	printw
	addiu	$4, $1, %lo($.str.7)
	lui	$1, %hi($.str.8)
	addiu	$5, $16, 20
	addiu	$18, $1, %lo($.str.8)
	jal	printw
	move	$4, $18
	j	$BB1_5
	nop
$BB1_4:
	jal	printw
	move	$4, $18
	lui	$2, %hi($.str.7)
	xori	$1, $17, 2
	addiu	$2, $2, %lo($.str.7)
	movz	$18, $2, $1
$BB1_5:
	addiu	$5, $16, 40
	jal	printw
	move	$4, $18
	lui	$1, %hi(stdscr)
	jal	wrefresh
	lw	$4, %lo(stdscr)($1)
	move	$sp, $fp
	lw	$16, 20($sp)                    # 4-byte Folded Reload
	lw	$17, 24($sp)                    # 4-byte Folded Reload
	lw	$18, 28($sp)                    # 4-byte Folded Reload
	lw	$19, 32($sp)                    # 4-byte Folded Reload
	lw	$20, 36($sp)                    # 4-byte Folded Reload
	lw	$fp, 40($sp)                    # 4-byte Folded Reload
	lw	$ra, 44($sp)                    # 4-byte Folded Reload
	jr	$ra
	addiu	$sp, $sp, 48
	.set	at
	.set	macro
	.set	reorder
	.end	displayEquations
$func_end1:
	.size	displayEquations, ($func_end1)-displayEquations
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
	.set	nomicromips
	.set	nomips16
	.ent	main
main:                                   # @main
	.frame	$fp,408,$ra
	.mask 	0xc0ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	.set	noat
# %bb.0:
	addiu	$sp, $sp, -408
	sw	$ra, 404($sp)                   # 4-byte Folded Spill
	sw	$fp, 400($sp)                   # 4-byte Folded Spill
	sw	$23, 396($sp)                   # 4-byte Folded Spill
	sw	$22, 392($sp)                   # 4-byte Folded Spill
	sw	$21, 388($sp)                   # 4-byte Folded Spill
	sw	$20, 384($sp)                   # 4-byte Folded Spill
	sw	$19, 380($sp)                   # 4-byte Folded Spill
	sw	$18, 376($sp)                   # 4-byte Folded Spill
	sw	$17, 372($sp)                   # 4-byte Folded Spill
	sw	$16, 368($sp)                   # 4-byte Folded Spill
	move	$fp, $sp
	addiu	$4, $zero, 0
	jal	time
	addiu	$21, $zero, 0
	jal	srand
	move	$4, $2
	addiu	$1, $fp, 64
	lui	$2, %hi($__const.generateRandomEquation.operators)
	sw	$1, 52($fp)                     # 4-byte Folded Spill
	addiu	$1, $2, %lo($__const.generateRandomEquation.operators)
	sw	$1, 48($fp)                     # 4-byte Folded Spill
	lui	$1, %hi($.str)
	addiu	$1, $1, %lo($.str)
	sw	$1, 44($fp)                     # 4-byte Folded Spill
	addiu	$1, $zero, 0
	j	$BB2_4
	sw	$1, 60($fp)
$BB2_1:                                 #   in Loop: Header=BB2_4 Depth=1
	addu	$2, $16, $20
$BB2_2:                                 #   in Loop: Header=BB2_4 Depth=1
	sw	$2, 56($18)
$BB2_3:                                 #   in Loop: Header=BB2_4 Depth=1
	lw	$2, 56($fp)                     # 4-byte Folded Reload
	addiu	$4, $18, 40
	addiu	$5, $zero, 16
	move	$6, $19
	move	$7, $20
	sw	$16, 20($sp)
	sw	$17, 16($sp)
	slt	$1, $22, $2
	jal	snprintf
	movn	$22, $2, $1
	lw	$1, 56($18)
	addiu	$21, $21, 1
	slt	$2, $1, $22
	movn	$1, $22, $2
	slti	$2, $1, 1
	movn	$1, $zero, $2
	lw	$2, 60($fp)                     # 4-byte Folded Reload
	addu	$1, $2, $1
	addiu	$1, $1, -1
	sw	$1, 60($fp)                     # 4-byte Folded Spill
	addiu	$1, $zero, 5
	beq	$21, $1, $BB2_29
	nop
$BB2_4:                                 # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_10 Depth 2
                                        #     Child Loop BB2_19 Depth 2
                                        #     Child Loop BB2_27 Depth 2
	sll	$1, $21, 1
	jal	rand
	addiu	$23, $1, 3
	div	$zero, $2, $23
	teq	$23, $zero, 7
	jal	rand
	mfhi	$19
	div	$zero, $2, $23
	sll	$1, $21, 2
	sll	$2, $21, 6
	teq	$23, $zero, 7
	subu	$1, $2, $1
	lw	$2, 52($fp)                     # 4-byte Folded Reload
	addu	$18, $2, $1
	jal	rand
	mfhi	$16
	sra	$1, $2, 31
	addiu	$3, $zero, -4
	srl	$1, $1, 30
	addu	$1, $2, $1
	and	$1, $1, $3
	subu	$1, $2, $1
	lw	$2, 48($fp)                     # 4-byte Folded Reload
	addu	$1, $2, $1
	lb	$17, 0($1)
	addiu	$2, $17, -42
	sltiu	$1, $2, 6
	beqz	$1, $BB2_13
	nop
$BB2_5:                                 #   in Loop: Header=BB2_4 Depth=1
	sll	$1, $2, 2
	lui	$2, %hi($JTI2_0)
	addu	$1, $1, $2
	lw	$1, %lo($JTI2_0)($1)
	jr	$1
	nop
$BB2_6:                                 #   in Loop: Header=BB2_4 Depth=1
	j	$BB2_12
	mul	$2, $16, $19
$BB2_7:                                 #   in Loop: Header=BB2_4 Depth=1
	j	$BB2_12
	addu	$2, $16, $19
$BB2_8:                                 #   in Loop: Header=BB2_4 Depth=1
	j	$BB2_12
	subu	$2, $19, $16
$BB2_9:                                 #   in Loop: Header=BB2_4 Depth=1
	bnez	$16, $BB2_11
	nop
$BB2_10:                                #   Parent Loop BB2_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	jal	rand
	nop
	div	$zero, $2, $23
	teq	$23, $zero, 7
	mfhi	$16
	beqz	$16, $BB2_10
	nop
$BB2_11:                                #   in Loop: Header=BB2_4 Depth=1
	div	$zero, $19, $16
	teq	$16, $zero, 7
	mflo	$2
$BB2_12:                                #   in Loop: Header=BB2_4 Depth=1
	sw	$2, 16($18)
$BB2_13:                                #   in Loop: Header=BB2_4 Depth=1
	sw	$16, 20($sp)
	sw	$17, 16($sp)
	move	$4, $18
	addiu	$5, $zero, 16
	lw	$6, 44($fp)                     # 4-byte Folded Reload
	jal	snprintf
	move	$7, $19
	lw	$1, 16($18)
	jal	rand
	sw	$1, 56($fp)
	div	$zero, $2, $23
	teq	$23, $zero, 7
	jal	rand
	mfhi	$20
	div	$zero, $2, $23
	lui	$1, %hi($__const.generateRandomEquation.operators)
	teq	$23, $zero, 7
	addiu	$17, $1, %lo($__const.generateRandomEquation.operators)
	jal	rand
	mfhi	$16
	sra	$1, $2, 31
	addiu	$3, $zero, -4
	srl	$1, $1, 30
	addu	$1, $2, $1
	and	$1, $1, $3
	subu	$1, $2, $1
	addu	$1, $17, $1
	lb	$19, 0($1)
	addiu	$2, $19, -42
	sltiu	$1, $2, 6
	beqz	$1, $BB2_22
	nop
$BB2_14:                                #   in Loop: Header=BB2_4 Depth=1
	sll	$1, $2, 2
	lui	$2, %hi($JTI2_1)
	addu	$1, $1, $2
	lw	$1, %lo($JTI2_1)($1)
	jr	$1
	nop
$BB2_15:                                #   in Loop: Header=BB2_4 Depth=1
	j	$BB2_21
	mul	$2, $16, $20
$BB2_16:                                #   in Loop: Header=BB2_4 Depth=1
	j	$BB2_21
	addu	$2, $16, $20
$BB2_17:                                #   in Loop: Header=BB2_4 Depth=1
	j	$BB2_21
	subu	$2, $20, $16
$BB2_18:                                #   in Loop: Header=BB2_4 Depth=1
	bnez	$16, $BB2_20
	nop
$BB2_19:                                #   Parent Loop BB2_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	jal	rand
	nop
	div	$zero, $2, $23
	teq	$23, $zero, 7
	mfhi	$16
	beqz	$16, $BB2_19
	nop
$BB2_20:                                #   in Loop: Header=BB2_4 Depth=1
	div	$zero, $20, $16
	teq	$16, $zero, 7
	mflo	$2
$BB2_21:                                #   in Loop: Header=BB2_4 Depth=1
	sw	$2, 36($18)
$BB2_22:                                #   in Loop: Header=BB2_4 Depth=1
	lui	$1, %hi($.str)
	sw	$16, 20($sp)
	sw	$19, 16($sp)
	addiu	$4, $18, 20
	addiu	$5, $zero, 16
	move	$7, $20
	addiu	$19, $1, %lo($.str)
	jal	snprintf
	move	$6, $19
	lw	$22, 36($18)
	jal	rand
	nop
	div	$zero, $2, $23
	teq	$23, $zero, 7
	jal	rand
	mfhi	$20
	div	$zero, $2, $23
	teq	$23, $zero, 7
	jal	rand
	mfhi	$16
	sra	$1, $2, 31
	addiu	$3, $zero, -4
	srl	$1, $1, 30
	addu	$1, $2, $1
	and	$1, $1, $3
	subu	$1, $2, $1
	addu	$1, $17, $1
	lb	$17, 0($1)
	addiu	$2, $17, -42
	sltiu	$1, $2, 6
	beqz	$1, $BB2_3
	nop
$BB2_23:                                #   in Loop: Header=BB2_4 Depth=1
	sll	$1, $2, 2
	lui	$2, %hi($JTI2_2)
	addu	$1, $1, $2
	lw	$1, %lo($JTI2_2)($1)
	jr	$1
	nop
$BB2_24:                                #   in Loop: Header=BB2_4 Depth=1
	j	$BB2_2
	mul	$2, $16, $20
$BB2_25:                                #   in Loop: Header=BB2_4 Depth=1
	j	$BB2_2
	subu	$2, $20, $16
$BB2_26:                                #   in Loop: Header=BB2_4 Depth=1
	bnez	$16, $BB2_28
	nop
$BB2_27:                                #   Parent Loop BB2_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	jal	rand
	nop
	div	$zero, $2, $23
	teq	$23, $zero, 7
	mfhi	$16
	beqz	$16, $BB2_27
	nop
$BB2_28:                                #   in Loop: Header=BB2_4 Depth=1
	div	$zero, $20, $16
	teq	$16, $zero, 7
	j	$BB2_2
	mflo	$2
$BB2_29:
	jal	initscr
	nop
	jal	raw
	nop
	lui	$18, %hi(stdscr)
	addiu	$5, $zero, 1
	jal	keypad
	lw	$4, %lo(stdscr)($18)
	jal	noecho
	nop
	lui	$1, %hi($.str.1)
	addiu	$17, $zero, 0
	addiu	$19, $zero, 1
	addiu	$1, $1, %lo($.str.1)
	sw	$1, 48($fp)                     # 4-byte Folded Spill
	lui	$1, %hi($.str.2)
	addiu	$1, $1, %lo($.str.2)
	sw	$1, 44($fp)                     # 4-byte Folded Spill
	lui	$1, %hi($.str.3)
	addiu	$1, $1, %lo($.str.3)
	sw	$1, 40($fp)                     # 4-byte Folded Spill
	lui	$1, %hi($.str.4)
	addiu	$1, $1, %lo($.str.4)
	sw	$1, 36($fp)                     # 4-byte Folded Spill
	lui	$1, %hi($.str.5)
	addiu	$1, $1, %lo($.str.5)
	sw	$1, 32($fp)                     # 4-byte Folded Spill
	lui	$1, %hi($.str.6)
	addiu	$1, $1, %lo($.str.6)
	sw	$1, 28($fp)                     # 4-byte Folded Spill
	lui	$1, %hi($.str.7)
	addiu	$1, $1, %lo($.str.7)
	sw	$1, 24($fp)                     # 4-byte Folded Spill
	lui	$1, 21845
	ori	$1, $1, 21846
	j	$BB2_31
	sw	$1, 56($fp)
$BB2_30:                                #   in Loop: Header=BB2_31 Depth=1
	sll	$1, $16, 2
	sll	$2, $16, 4
	addiu	$19, $19, 1
	addu	$1, $2, $1
	addu	$1, $20, $1
	lw	$1, 16($1)
	addu	$17, $1, $17
	addiu	$1, $zero, 6
	beq	$19, $1, $BB2_43
	nop
$BB2_31:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_33 Depth 2
	jal	wclear
	lw	$4, %lo(stdscr)($18)
	lw	$4, 48($fp)                     # 4-byte Folded Reload
	jal	printw
	nop
	lw	$4, 44($fp)                     # 4-byte Folded Reload
	jal	printw
	move	$5, $19
	lw	$4, 40($fp)                     # 4-byte Folded Reload
	jal	printw
	move	$5, $17
	lw	$4, 36($fp)                     # 4-byte Folded Reload
	lw	$5, 60($fp)                     # 4-byte Folded Reload
	jal	printw
	nop
	lw	$4, 32($fp)                     # 4-byte Folded Reload
	jal	printw
	nop
	lw	$4, 28($fp)                     # 4-byte Folded Reload
	jal	printw
	nop
	addiu	$1, $19, -1
	lw	$4, 24($fp)                     # 4-byte Folded Reload
	sll	$2, $1, 2
	sll	$1, $1, 6
	subu	$1, $1, $2
	lw	$2, 52($fp)                     # 4-byte Folded Reload
	addu	$20, $2, $1
	jal	printw
	move	$5, $20
	lui	$1, %hi($.str.8)
	addiu	$21, $20, 20
	addiu	$23, $1, %lo($.str.8)
	move	$5, $21
	jal	printw
	move	$4, $23
	addiu	$22, $20, 40
	j	$BB2_33
	addiu	$16, $zero, 0
$BB2_32:                                #   in Loop: Header=BB2_33 Depth=2
	lui	$1, %hi($.str.7)
	move	$5, $20
	jal	printw
	addiu	$4, $1, %lo($.str.7)
	lui	$1, %hi($.str.8)
	move	$5, $21
	addiu	$23, $1, %lo($.str.8)
	jal	printw
	move	$4, $23
$BB2_33:                                #   Parent Loop BB2_31 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	move	$4, $23
	jal	printw
	move	$5, $22
	jal	wrefresh
	lw	$4, %lo(stdscr)($18)
	jal	wgetch
	lw	$4, %lo(stdscr)($18)
	addiu	$1, $zero, 260
	beq	$2, $1, $BB2_37
	nop
$BB2_34:                                #   in Loop: Header=BB2_33 Depth=2
	addiu	$1, $zero, 261
	beq	$2, $1, $BB2_38
	nop
$BB2_35:                                #   in Loop: Header=BB2_33 Depth=2
	addiu	$1, $zero, 10
	bne	$2, $1, $BB2_39
	nop
$BB2_36:                                #   in Loop: Header=BB2_31 Depth=1
	j	$BB2_30
	nop
$BB2_37:                                #   in Loop: Header=BB2_33 Depth=2
	lw	$2, 56($fp)                     # 4-byte Folded Reload
	addiu	$1, $16, 2
	mult	$1, $2
	mfhi	$2
	srl	$3, $2, 31
	addu	$2, $2, $3
	sll	$3, $2, 1
	addu	$2, $3, $2
	j	$BB2_39
	subu	$16, $1, $2
$BB2_38:                                #   in Loop: Header=BB2_33 Depth=2
	lw	$2, 56($fp)                     # 4-byte Folded Reload
	addiu	$1, $16, 1
	mult	$1, $2
	mfhi	$2
	srl	$3, $2, 31
	addu	$2, $2, $3
	sll	$3, $2, 1
	addu	$2, $3, $2
	subu	$16, $1, $2
$BB2_39:                                #   in Loop: Header=BB2_33 Depth=2
	jal	wclear
	lw	$4, %lo(stdscr)($18)
	lui	$1, %hi($.str.1)
	jal	printw
	addiu	$4, $1, %lo($.str.1)
	lui	$1, %hi($.str.2)
	move	$5, $19
	jal	printw
	addiu	$4, $1, %lo($.str.2)
	lui	$1, %hi($.str.3)
	move	$5, $17
	jal	printw
	addiu	$4, $1, %lo($.str.3)
	lui	$1, %hi($.str.4)
	lw	$5, 60($fp)                     # 4-byte Folded Reload
	jal	printw
	addiu	$4, $1, %lo($.str.4)
	lui	$1, %hi($.str.5)
	jal	printw
	addiu	$4, $1, %lo($.str.5)
	lui	$1, %hi($.str.6)
	jal	printw
	addiu	$4, $1, %lo($.str.6)
	beqz	$16, $BB2_32
	nop
# %bb.40:                               #   in Loop: Header=BB2_33 Depth=2
	lui	$1, %hi($.str.8)
	move	$5, $20
	addiu	$23, $1, %lo($.str.8)
	jal	printw
	move	$4, $23
	addiu	$1, $zero, 1
	bne	$16, $1, $BB2_42
	nop
# %bb.41:                               #   in Loop: Header=BB2_33 Depth=2
	lui	$1, %hi($.str.7)
	move	$5, $21
	jal	printw
	addiu	$4, $1, %lo($.str.7)
	j	$BB2_33
	nop
$BB2_42:                                #   in Loop: Header=BB2_33 Depth=2
	move	$4, $23
	jal	printw
	move	$5, $21
	lui	$2, %hi($.str.7)
	xori	$1, $16, 2
	addiu	$2, $2, %lo($.str.7)
	j	$BB2_33
	movz	$23, $2, $1
$BB2_43:
	jal	endwin
	nop
	lui	$1, %hi($str)
	jal	puts
	addiu	$4, $1, %lo($str)
	lui	$1, %hi($.str.10)
	move	$5, $17
	jal	printf
	addiu	$4, $1, %lo($.str.10)
	lw	$16, 60($fp)                    # 4-byte Folded Reload
	lui	$1, %hi($.str.11)
	addiu	$4, $1, %lo($.str.11)
	jal	printf
	move	$5, $16
	lui	$2, %hi($str.15)
	slt	$1, $16, $17
	addiu	$4, $2, %lo($str.15)
	lui	$2, %hi($str.17)
	addiu	$2, $2, %lo($str.17)
	jal	puts
	movn	$4, $2, $1
	lui	$1, %hi($str.16)
	jal	puts
	addiu	$4, $1, %lo($str.16)
	addiu	$2, $zero, 0
	move	$sp, $fp
	lw	$16, 368($sp)                   # 4-byte Folded Reload
	lw	$17, 372($sp)                   # 4-byte Folded Reload
	lw	$18, 376($sp)                   # 4-byte Folded Reload
	lw	$19, 380($sp)                   # 4-byte Folded Reload
	lw	$20, 384($sp)                   # 4-byte Folded Reload
	lw	$21, 388($sp)                   # 4-byte Folded Reload
	lw	$22, 392($sp)                   # 4-byte Folded Reload
	lw	$23, 396($sp)                   # 4-byte Folded Reload
	lw	$fp, 400($sp)                   # 4-byte Folded Reload
	lw	$ra, 404($sp)                   # 4-byte Folded Reload
	jr	$ra
	addiu	$sp, $sp, 408
	.set	at
	.set	macro
	.set	reorder
	.end	main
$func_end2:
	.size	main, ($func_end2)-main
	.section	.rodata,"a",@progbits
	.p2align	2
$JTI2_0:
	.4byte	($BB2_6)
	.4byte	($BB2_7)
	.4byte	($BB2_13)
	.4byte	($BB2_8)
	.4byte	($BB2_13)
	.4byte	($BB2_9)
$JTI2_1:
	.4byte	($BB2_15)
	.4byte	($BB2_16)
	.4byte	($BB2_22)
	.4byte	($BB2_17)
	.4byte	($BB2_22)
	.4byte	($BB2_18)
$JTI2_2:
	.4byte	($BB2_24)
	.4byte	($BB2_1)
	.4byte	($BB2_3)
	.4byte	($BB2_25)
	.4byte	($BB2_3)
	.4byte	($BB2_26)
                                        # -- End function
	.type	$__const.generateRandomEquation.operators,@object # @__const.generateRandomEquation.operators
	.section	.rodata.str1.1,"aMS",@progbits,1
$__const.generateRandomEquation.operators:
	.asciz	"+-*/"
	.size	$__const.generateRandomEquation.operators, 5

	.type	$.str,@object                   # @.str
$.str:
	.asciz	"%d %c %d"
	.size	$.str, 9

	.type	$.str.1,@object                 # @.str.1
$.str.1:
	.asciz	"Welcome to MathGame!\n"
	.size	$.str.1, 22

	.type	$.str.2,@object                 # @.str.2
$.str.2:
	.asciz	"Level: %d\n"
	.size	$.str.2, 11

	.type	$.str.3,@object                 # @.str.3
$.str.3:
	.asciz	"Army: %d\n"
	.size	$.str.3, 10

	.type	$.str.4,@object                 # @.str.4
$.str.4:
	.asciz	"Enemies: %d\n\n"
	.size	$.str.4, 14

	.type	$.str.5,@object                 # @.str.5
$.str.5:
	.asciz	"Use the left and right arrow keys to choose an equation.\n"
	.size	$.str.5, 58

	.type	$.str.6,@object                 # @.str.6
$.str.6:
	.asciz	"Press 'Enter' to select the equation.\n\n"
	.size	$.str.6, 40

	.type	$.str.7,@object                 # @.str.7
$.str.7:
	.asciz	"[ %s ] "
	.size	$.str.7, 8

	.type	$.str.8,@object                 # @.str.8
$.str.8:
	.asciz	"  %s   "
	.size	$.str.8, 8

	.type	$.str.10,@object                # @.str.10
$.str.10:
	.asciz	"Your army is: %d\n"
	.size	$.str.10, 18

	.type	$.str.11,@object                # @.str.11
$.str.11:
	.asciz	"Total number of enemies: %d\n"
	.size	$.str.11, 29

	.type	$str,@object                    # @str
$str:
	.asciz	"\nYou completed all levels!"
	.size	$str, 27

	.type	$str.15,@object                 # @str.15
$str.15:
	.asciz	"You lost, good luck next time"
	.size	$str.15, 30

	.type	$str.16,@object                 # @str.16
$str.16:
	.asciz	"Thank you for playing MathGame!"
	.size	$str.16, 32

	.type	$str.17,@object                 # @str.17
$str.17:
	.asciz	"You won"
	.size	$str.17, 8

	.ident	"clang version 15.0.7 (Fedora 15.0.7-2.fc37)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.text
