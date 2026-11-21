
.data
msg: .asciiz "F(n) = "
.text
.globl main
main:
	
	la $a0, msg
	li $v0, 4
	syscall

	li $a0, 30
	jal fib_rec
	
	move $a0,$v0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall

#input: $a0 la so n
#output: $v0 la F(n)
fib_rec:
	addi $sp, $sp, -16
	sw $s2, 12($sp)
	sw $s1, 8($sp)
	sw $ra, 4($sp)
	sw $a0, 0($sp)
	
	slti $t0, $a0,2
	bnez $t0, end_fib_rec
	
	addi $a0, $a0, -1
	jal fib_rec
	move $s1,$v0
	
	addi $a0,$a0,-1
	jal fib_rec
	move $s2, $v0
	
	add $v0, $s1, $s2
	lw $s2, 12($sp)
	lw $s1, 8($sp)
	lw $ra, 4($sp)
	lw $a0, 0($sp)
	addi $sp, $sp, +16
	jr $ra
end_fib_rec:
	slti $v0, $a0, 1		#v0 = 0 if $a0<=0, $v0=1 if $a0=1
	slti $v0, $v0, 1
	
	lw $s2, 12($sp)
	lw $s1, 8($sp)
	lw $ra, 4($sp)
	lw $a0, 0($sp)
	addi $sp, $sp, +16
	jr $ra
	
# fib_iter: tinh F(n) bang vong lap
# Tham so : $a0 = n    Tra ve : $v0 = F(n)
# Thanh ghi: $t0-$t3 (thu tuc la)
fib_iter:
        move  $v0, $zero        # a = F(0)
        li    $t0, 1            # b = F(1)
        move  $t1, $zero        # i = 0
fi_loop:
        slt   $t2, $t1, $a0
        beq   $t2, $zero, fi_done
        addu  $t3, $v0, $t0     # a + b
        move  $v0, $t0
        move  $t0, $t3
        addiu $t1, $t1, 1
        j     fi_loop
fi_done:
        jr    $ra
