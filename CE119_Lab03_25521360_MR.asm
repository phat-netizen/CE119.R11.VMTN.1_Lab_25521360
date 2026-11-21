.data
msg:    .asciiz "F(n) = "
.text
.globl main
main:
        li    $a0, 20
        jal   fib_opt
        move  $s0, $v0
        
        li    $v0, 4
        la    $a0, msg
        syscall
        
        move  $a0, $s0
        li    $v0, 1
        syscall
        
        li    $v0, 10
        syscall

# input : $a0 = n    output : $v0 = F(n)
fib_opt:
        slti  $t0, $a0, 2
        beq   $t0, $zero, fo_rec   # n >= 2 thi cap khung
        move  $v0, $a0             # co so: F(0)=0, F(1)=1
        jr    $ra                  # khong cap khung
fo_rec:
        addi  $sp, $sp, -12        # mo dau: cap khung 3 word
        sw    $ra, 8($sp)
        sw    $s0, 4($sp)
        sw    $s1, 0($sp)
        move  $s0, $a0             # giu n qua loi goi
        addi  $a0, $s0, -1
        jal   fib_opt              # v0 = F(n-1)
        
        move  $s1, $v0             # giu F(n-1) qua loi goi tiep
        addi  $a0, $s0, -2
        jal   fib_opt              # v0 = F(n-2)
        add   $v0, $s1, $v0        # F(n-1) + F(n-2)
        
        lw    $s1, 0($sp)          # ket thuc: nap lai dung offset
        lw    $s0, 4($sp)
        lw    $ra, 8($sp)
        addi  $sp, $sp, 12         # thu hoi khung
        jr    $ra