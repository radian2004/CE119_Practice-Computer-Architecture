
.data

	Template: .asciiz "Chuong trinh tinh toan co ban!"
	Nhap1: .asciiz "\nNhap so nguyen thu nhat la: "
	Nhap2: .asciiz "\nNhap so nguyen thu hai la: "
	Xuat1: .asciiz "\nTong hai so la: "
	Xuat2: .asciiz "\nHieu hai so la: "
	Xuat3: .asciiz "\nTich hai so la: "
	Xuat4: .asciiz "\nThuong hai so la: "
	Xuat5: .asciiz "\nSo lon hon la: "
	Xuat6: .asciiz "Khong. Vi hai so bang nhau."
	Xuat7: .asciiz "Khong thuc hien duoc phep chia."

.text

main:
	#Template
	li $v0, 4
	la $a0, Template
	syscall
	
	#Nhap hai so nguyen
	li $v0, 4 
	la $a0, Nhap1	#Nhap so thu 1
	syscall
	li $v0, 5
	syscall
	move $s1, $v0
	
	li $v0, 4
	la $a0, Nhap2	#Nhap so thu 2
	syscall
	li $v0, 5
	syscall
	move $s2, $v0
	
	add $t0, $s1, $s2 #Tong hai so
	
	sub $t1, $s1, $s2 #Tinh hieu
	
	#Tinh tich
	mult $s1, $s2
	mfhi $t2
	mflo $t3
	
	#Tinh thuong
	beq $s2, $zero, bo_qua
	div $t4, $s1, $s2
	bo_qua: 
	
	#Xuat ket qua
	li $v0, 4
	la $a0, Xuat5 	#Thong bao so lon hon
	syscall
	
	slt $t5, $s1, $s2 	#t5 = 1 khi s1 < s2
	bne $t5, $zero, in_2
	slt $t5, $s2, $s1
	bne $t5, $zero, in_1
	
	Hai_so_bang_nhau:
		li $v0, 4
		la $a0, Xuat6
		syscall
		j continue
	in_2:
		li $v0, 1
		la $a0,($s2)
		syscall
		j continue
	in_1:
		li $v0, 1
		la $a0,($s1)
		syscall
	continue:
	#Xuat phep cong
	li $v0, 4
	la $a0, Xuat1
	syscall
	li $v0, 1
	la $a0, ($t0)
	syscall
	
	#Xuat phep tru
	li $v0, 4
	la $a0, Xuat2
	syscall
	li $v0, 1
	la $a0, ($t1)
	syscall
	
	#Xuat phep tich
	li $v0, 4
	la $a0, Xuat3
	syscall
	li $v0, 1
	la $a0, ($t2)
	syscall
	li $v0, 1
	la $a0, ($t3)
	syscall
	
	#Xuat phep thuong
	li $v0, 4
	la $a0, Xuat4
	syscall
	beq $s2, $zero, KO_phep_chia
	li $v0, 1
	la $a0, ($t4)
	syscall
	j end
	KO_phep_chia:
		li $v0, 4
		la $a0, Xuat7
		syscall
	end:
	
	#Ket thuc 
	
	li $v0, 10
	syscall
	
	