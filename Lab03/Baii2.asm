
.data 
	array1: 	.word  5, 6, 7, 8, 1, 2, 3, 9, 10, 4
	size1: 		.word 8 
	array2: 	.byte 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
	size2: 		.word 16 
	array3: 	.space 8 
	size3: 		.word 8
	Template: 	.asciiz "Chuong trinh duoc viet by RadiAn!\n"
	O1: 		.asciiz "Phan tu array1 la: " 
	O2: 		.asciiz "\nPhan tu array2 la: " 
	O3: 		.asciiz "\nPhan tu array3 la: "
	str1: 		.asciiz "\nBan nhap vao mang thu (1-3): " 
	str2: 		.asciiz "\nDia chi phan tu: " 
	str3: 		.asciiz "\nPhan tu la: " 
	space: 		.asciiz " " 
	
.text 
		la $a0, Template #load Templ
		li $v0, 4 #load 4 vao $v0 de print string
		syscall #In ra Template
	
	a1: 
		la $a0, O1 
		li $v0, 4 
		syscall #In ra man hinh chuoi O1
	
		la $s0, array1 
		li $t3, 10 #t3 = 10
		sll $t1, $t3, 2 # t1 = t3 * 4
		add $t2, $s0, $t1 #t2 = array1[0] + t1  
	loop11: 
		lw $s1, 0($s0) 
		addi $a0, $s1, 0 
		li $v0, 1 
		syscall #Xuat phan tu dau tien trong $s0
	
		la $a0, space 
		li $v0, 4 
		syscall #Xuat 'space'
	
		addi $s0, $s0, 4 
		slt $s3, $s0, $t2 
		beq $s3, 0, a2 #Neu s3 = 0 -> qua array2
		j loop11 #Xuat phan tu tiep theo
	
	a2: #Tuong tu a1
		la $a0, O2
		li $v0, 4 
		syscall 
	
		la $t3 , array2 
		li $t4, 16 
		add $t5, $t3, $t4 
	loop12: #Tuong tu loop11
		lb $t6, 0($t3) 
		addi $a0, $t6, 0 
		li $v0, 1 
		syscall 
	
		la $a0, space 
		li $v0, 4 
		syscall 
	
		addi $t3, $t3, 1 
		slt $t7, $t3, $t5 
		beq $t7, 0, Bai2
		j loop12 

	Bai2: 
		la $s1, array3 
		la $s2, array2 
		la $a0, O3 #load O3 vao a0
		li $v0, 4 
		syscall #In ra man hinh thong tin mang3
	
		addi $t2, $s2, 15 #t2 = s2 + 15
		addi $t7, $s1, 8  #t7 = s1 + 8
	loop2: 
		lb $t3, 0($s2) #Doc gia tri tu thanh ghi s2 vao t3
		lb $t4, 0($t2) #Doc gia tri tu thanh ghi t2 vao t4
		add $t5, $t3, $t4 #t5 = t3 + t4
		sb $t5, 0($s1) 
		lb $s3, 0($s1) 
		addi $a0, $s3, 0 
		li $v0, 1 
		syscall #In ra phan tu dang tro toi trong array3
	
		la $a0, space 
		li $v0, 4 
		syscall #In ra khoang trang
		
		addi $s2, $s2, 1 #s2 += 1
		addi $t2, $t2, -1 #t2 -= 1
		addi $s1, $s1, 1 #Tro den con tro ke tiep
		slt $t8, $s1, $t7 
		beq $t8, 0, Bai3 
		j loop2 

	Bai3:
		la $s1, array1 
		la $s2, array2 
		la $a0, str1 
		li $v0, 4 
		syscall #In ra man hinh 
	
		li $v0, 5 
		syscall #Cho nguoi dung nhap vao v0
	
		addi $t1, $v0, 0 
		beq $t1, 1, output1 #nguoi dung nhap vao 1 thi output 1
		j output2 #con lai output2
	
	output1: 
		la $a0, str2 
		li $v0, 4 
		syscall #In ra chuoi str2
	
		li $v0, 5 
		syscall #Nhap vao v0
			
		addi $t2, $v0,0 
		sll $t2, $t2, 2 
		add $t2,$s1,$t2 
		lw $s3, 0($t2) 
		la $a0, str3 
		li $v0, 4 
		syscall #In ra chuoi str3
	
		addi $a0, $s3, 0 
		li $v0, 1 
		syscall #In ra gia tri 
		j Exit 
		
	output2: #Tuong tu output1
		la $a0, str2
		li $v0, 4 
		syscall 
	
		li $v0, 5 
		syscall #Cho nguoi dung nhap vao
			
		addi $t3, $v0, 0 
		add $t3, $t3, $s2 
		la $a0, str3 
		li $v0, 4 
		syscall 
		
		lb $s4, 0($t3) 
		addi $a0, $s4, 0 
		li $v0, 1 
		syscall 
		j Exit 
Exit:

	
	

	
	
