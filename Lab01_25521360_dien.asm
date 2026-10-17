
# Lab01_25521360_dien.asm - Tinh tien dien bac thang
# Vai tro thanh ghi:
#   $s0 = con tro vao mang nguong (tang 4 moi vong)
#         gia[i] doc bang 24($s0) vi mang gia nam ngay sau
#         mang nguong, cach 6 phan tu x 4 byte = 24 byte
#   $s1 = x, so kWh nhap vao
#   $s2 = tong tien
#   $s4 = can duoi cua bac hien tai (nguong cua bac truoc)
#   $t0 = nguong bac hien tai
#   $t1 = don gia bac hien tai
#   $t2 = gia tri tam (so kWh cua bac, tien cua bac)    
        .data
nguong:   .word 50, 100, 200, 300, 400, 9999
gia:      .word 1600, 1660, 1950, 2500, 2850, 3000
msg_nhap: .asciiz "Nhap so kWh (0..9999): "
msg_loi:  .asciiz "Gia tri khong hop le, nhap lai.\n"
msg_kq:   .asciiz "Tien dien: "
msg_dong: .asciiz " dong\n"
        .text
main:
nhap:   li   $v0, 4
        la   $a0, msg_nhap
        syscall
        li   $v0, 5
        syscall
        move $s1, $v0
        sltiu $t0, $s1, 10000     # t0 = 1 khi 0 <= x <= 9999 (so sanh khong dau)
        bne  $t0, $zero, hop_le   # hop le thi nhay
        li   $v0, 4
        la   $a0, msg_loi
        syscall
        j    nhap

hop_le: la   $s0, nguong
        li   $s2, 0               # tong = 0
        li   $s4, 0               # can duoi = 0

lap:
        lw   $t0, 0($s0)          # nguong bac hien tai
        lw   $t1, 24($s0)          # don gia bac hien tai
        ble  $s1, $t0, bac_cuoi   # x <= nguong: x nam trong bac nay
        sub  $t2, $t0, $s4        # so kWh day cua bac = nguong - can duoi
        mul  $t2, $t2, $t1        # tien cua bac
        add  $s2, $s2, $t2        # cong don vao tong
        move $s4, $t0             # can duoi moi = nguong vua xu ly
        addi $s0, $s0, 4
        j    lap

bac_cuoi:
        sub  $t2, $s1, $s4        # phan kWh con lai = x - can duoi
        mul  $t2, $t2, $t1
        add  $s2, $s2, $t2

in_kq:
        li   $v0, 4
        la   $a0, msg_kq
        syscall
        li   $v0, 1
        move $a0, $s2
        syscall
        li   $v0, 4
        la   $a0, msg_dong
        syscall
        li   $v0, 10
        syscall
