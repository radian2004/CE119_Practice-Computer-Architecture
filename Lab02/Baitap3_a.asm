
.data 
string1: .asciiz "\nNhap ky tu (chi mot ky tu) la: "
string2: .asciiz "\nKy tu truoc cua ky tu ban vua nhap la: "
string3: .asciiz "\nKy tu sau cua ky tu ban vua nhap la: "
string4: .asciiz "\nKy tu ban nhap la chu thuong!"
string5: .asciiz "\nKy tu ban nhap la chu hoa!"
string6: .asciiz "\nKy tu ban nhap la so!"
string7: .asciiz "\nInvalid type!"
string8: .asciiz "\n" 
string9: .asciiz "Chuong trinh nhan dang ky tu!\n"

.text

main:
	#Template 
	li $v0, 4
	la $a0, string9
	syscall
	
	#Thong bao nhap du lieu 
	li $v0, 4
	la $a0, string1
	syscall
	
	#Nhan du lieu
	li $v0, 12
	syscall
	move $s0, $v0	#Chuyen du lieu nhap vao s0
	li $v0, 4
	la $a0, string8
	syscall
	
	#Bang ma ASCIIZ (47 < so < 58; 64 < chuhoa < 91; 96 < chuthuong < 123)
	addi $t3, $zero, 47 	#Khoang nay la So
	addi $t4, $zero, 58
	
	addi $t5, $zero, 64	#Khoang nay la Chu hoa
	addi $t6, $zero, 91	
	
	addi $t7, $zero, 96	#Khoang nay la Chu thuong
	addi $t8, $zero, 123
	
	#Kiem tra ki tu nhap co hop le hay khong
	
	slt $t0, $t3, $s0	#Kiem tra So
	slt $t1, $s0, $t4 
	and $t2, $t0, $t1
	bne $t2, $zero, SO	#Neu t2 != 0 xuat so
	
	slt $t0, $t5, $s0	#Kiem tra chu hoa
	slt $t1, $s0, $t6
	and $t2, $t0, $t1
	bne $t2, $zero, CHUHOA	#Neu t2 != 0 xuat chu hoa
	
	slt $t0, $t7, $s0	#Kiem tra chu thuong
	slt $t1, $s0, $t8
	and $t2, $t0, $t1
	bne $t2, $zero, CHUTHUONG	#Neu t2 != 0 xuat chu thuong
	
	j KOHOPLE
	#Xuat ky tu hop le:
	CHUTHUONG:
		li $v0, 4
		la $a0, string4
		syscall
		j KETQUA
	
	CHUHOA:
		li $v0, 4
		la $a0, string5
		syscall
		j KETQUA
		
	SO:
		li $v0, 4
		la $a0, string6
		syscall
		j KETQUA
		
	KETQUA:
		#Gia tri ki tu truoc va ki tu sau
		addi $s1, $s0, -1	#Ki tu truoc
		addi $s2, $s0, 1	#Ki tu sau
		
		#Xuat ki tu truoc
		li $v0, 4
		la $a0, string2 	#Xuat thong bao
		syscall
		li $v0, 11
		la $a0, ($s1)
		syscall		#Xuat gia tri
	
		#Xuat ki tu sau
		li $v0, 4
		la $a0, string3		#Xuat thong bao 
		syscall
		li $v0, 11
		la $a0, ($s2)
		syscall		#Xuat gia tri
		
		j exit
		
	#Thong bao ky tu khong hop le
	
	KOHOPLE:
		li $v0, 4
		la $a0, string7
		syscall
		j exit
	#Ket thu chuong trinh kiem tra
	
	exit:
	
	#Ket thuc chuong trinh
	
	li $v0, 10
	syscall
	
	

