.data
input1: .asciiz "tinh may   truc kien"
input2: .asciiz	"mips"
input3: .asciiz ""
input4: .asciiz "def bc a  "
input5: .asciiz "luu dia chi tro ve truoc khi goi"

.text
.globl main
main:
	la $a0, input1
	jal reverse_words
	
	la $a0, input1
	li $v0, 4
	syscall
	li   $v0, 11
	li   $a0, 10        #'\n'
	syscall
	
	la $a0, input2
	jal reverse_words
	
	la $a0, input2
	li $v0, 4
	syscall
	li   $v0, 11
	li   $a0, 10        #'\n'
	syscall
	
	la $a0, input3
	jal reverse_words
	
	la $a0, input3
	li $v0, 4
	syscall
	li   $v0, 11
	li   $a0, 10        #'\n'
	syscall
	
	la $a0, input4
	jal reverse_words
	
	la $a0, input4
	li $v0, 4
	syscall
	li   $v0, 11
	li   $a0, 10        #'\n'
	syscall
	
	la $a0, input5
	jal reverse_words
	
	la $a0, input5
	li $v0, 4
	syscall

	li $v0, 10
	syscall
#input:$a0(dia chi chuoi)
#output:$v0(so ky tu trong chuoi)
strlen:
	move $t0, $a0
	li $v0, 0
loop_strlen:
	lb $t1, 0($t0)
	beq $t1,$zero,end_strlen
	addi $t0, $t0, 1
	addi $v0, $v0, 1
	j loop_strlen
end_strlen:
	jr $ra
	
#input: $a0(dia chi dau chuoi), $a1(dia chi cuoi chuoi)
#output: khong co
rev_range:
	bleu $a1, $a0, end_rev_range
	lb $t0, 0($a1)		#luu last
	lb $t1, 0($a0)		#luu first
	sb $t1, 0($a1)
	sb $t0, 0($a0)
	addi $a1, $a1, -1
	addi $a0, $a0, +1
	j rev_range
end_rev_range:
	jr $ra
	
#input: $a0 (dia chi dau chuoi)
#output: khong co
reverse_words:
	addi $sp, $sp, -16
	sw   $ra, 12($sp)	#luu dia chi tra ve
	sw   $s0, 8($sp)
	sw   $s1, 4($sp)
	sw   $s2, 0($sp)
	#dung $s1 luu dau chuoi, $s0 luu cuoi chuoi 
	move $s1, $a0
	jal strlen
	add $s0, $s1, $v0
	addi $s0, $s0, -1
	
	move $a0, $s1
	move $a1, $s0
	jal rev_range	

	move $s2, $s1 		#luu dia chi hien tai
	
loop:
	lb $t0, 0($s2)
	beq  $t0, $zero, done
	beq  $t0, ' ', dao_nguoc      # 32 = ma ASCII dau cach
	addi $s2, $s2, 1	
	j loop
dao_nguoc:
	move $a0, $s1
	addi $a1, $s2, -1
	jal rev_range
	addi $s2, $s2, 1	#skip ' '
	move $s1, $s2
	j loop
done: 
	move $a0, $s1
	add $a1, $s2, -1
	jal rev_range
	
	lw   $ra, 12($sp)	
	lw   $s0, 8($sp)
	lw   $s1, 4($sp)
	lw   $s2, 0($sp)
	addi $sp, $sp, 16	
	jr $ra