.data
cao_do: .word 64 64 65 67 67 65 64 62 60 60 62 64 64 62 62
do_dai: .word 2 2 2 2 2 2 2 2 2 2 2 2 3 1 4
so_luong_not: .word 15
msg_du_kien: .asciiz "Tong du kien (ms): "
msg_do_duoc: .asciiz "Thoi gian do duoc (ms): "	
	.text
main:
#$s0 = thoi gian bat dau do
#$s1 = thoi gian ket thuc do
#$s2 = tong thoi gian du kien (ms)			
#$s3 = thoi gian do duoc (ms) = $s1 - $s0		
#$s4 = i , chi so hien tai			
#$s5 = dia chi mang do_dai			
#$s6 = dia chi mang cao_do			
#$s7 = so luong not				
#$t1 = thoi gian chay not hien tai (ms)
#$t2 = cao do thuc phat cua not hien tai (cao_do + a)	
	li $s2,0					
	li $s4,0					
	la $s5, do_dai					
	lw $s7, so_luong_not 				
thoi_gian_du_kien:
	lw $t1, 0($s5)					
	mul $t1, $t1, 210 	#150 +6*10=210
	add $s2, $s2, $t1
	addi $s5, $s5, 4				
	addi $s4,$s4, 1					
	blt $s4, $s7, thoi_gian_du_kien			
							

	li $v0, 30
	syscall
	move $s0,$a0
	la $s5,do_dai					
	la $s6,cao_do					
	li $a2, 40 	#instruction theo mssv
	li $a3, 100
	li $s4,0	#i=0				
lap:	lw $t1, 0($s5)		#doc do_dai (nhip) cua not hien tai
	mul $t1, $t1, 210	#150 +6*10=210
	lw $t2, 0($s6)					
	addi $t2, $t2, 0				
	move $a0, $t2					
	li $v0, 1
	syscall
	li $a0, 32	# in dau cach
	li $v0, 11
	syscall
	move $a0, $t1					
	li $v0, 1
	syscall
	li $a0, 10	# xuong dong
	li $v0, 11
	syscall
	move $a1, $t1					
	move $a0, $t2					
	li $v0, 33
	syscall
	addi $s5,$s5,4					
	addi $s6,$s6,4					
	addi $s4,$s4,1	#i++				
	blt $s4,$s7,lap	#if(i<n) branch lap 		

	li $v0,30
	syscall
	move $s1,$a0
	sub $s3,$s1,$s0					

	li $v0, 4					
	la $a0, msg_du_kien
	syscall
	li $v0,1
	move $a0, $s2
	syscall
	li $a0, 10		#xuong dong
	li $v0, 11
	syscall

	li $v0, 4
	la $a0, msg_do_duoc
	syscall

	li $v0,1
	move $a0, $s3					
	syscall
	li $a0, 10		#xuong dong
	li $v0, 11
	syscall

	li $v0, 10
	syscall
