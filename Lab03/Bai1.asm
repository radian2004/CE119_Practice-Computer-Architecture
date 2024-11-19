
.data 
	array1: 	.word  5, 6, 7, 8, 1, 2, 3, 9, 10, 4
	size1: 		.word 8 
	array2: 	.byte 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
	size2: 		.word 16 
	array3: 	.space 8 
	size3: 		.word 8
	Template: 	.asciiz 	"Chuong trinh duoc viet by RadiAn!\n"
	O1: 		.asciiz 	"Phan tu array1 la: " 
	O2: 		.asciiz 	"\nPhan tu array2 la: " 
	O3: 		.asciiz 	"\nPhan tu array3 la: "
	str1: 		.asciiz 	"\nBan nhap vao mang thu (1-3): " 
	str2: 		.asciiz 	"\nDia chi phan tu: " 
	str3: 		.asciiz 	"\nPhan tu la: " 
	space: 		.asciiz 	" " 
	
.text 
		la $a0, Template #load Templ
		li $v0, 4 #load 4 vao $v0 de print string
		syscall #In ra Template
	
	a1: 
		la $a0, O1 #load O1
		li $v0, 4 #load 4 vao $v0 de print string
		syscall #In ra man hinh chuoi O1 
	
		la $s0, array1 #load array1
		addi $t2, $t2, 0  #t2 = 0
		addi $t3, $t3, 10 #t3 = 10
	
	loop11: 
		beq $t2, $t3, a2 # t2 = t3 -> a2
		la $v0, 1 #v0 = 1 -> print int
		lw $t1, 0($s0) #load tu ram len thanh ghi
		add $a0, $t1, $0 #Gan a0 = t1 de in ra man hinh
		syscall #In ra man hinh a0 (t1)
	
		la $a0, space 
		li $v0, 4 
		syscall #In ra man hinh "space"

		addi $s0, $s0, 4 #S0 += 4
		addi $t2, $t2, 1 #t2 += 1
		j loop11  
	
	a2: #tuong tu a1
		la $a0, O2 
		li $v0, 4 
		syscall 

		la $s1, array2 
		addi $t2, $t2, 0 
		addi $t3, $t3, 16 
	
	loop12: #tuong tu loop11
		beq $t2, $t3, Bai2 
		la $v0, 1 
		lb $t1, 0($s1) 
		add $a0, $t1, $0 
		syscall 
	
		la $a0, space 
		li $v0, 4 
		syscall 

		addi $s1, $s1, 1 
		addi $t2, $t2, 1
		j loop12 
	
		#Bai 1.2: array3[i] = array2[i] + array2[size2 - 1 - i]
	Bai2:	
		la $s0, array3 #load array3[0] vao s0
		la $s1, array2 #load array2[0] vao s1
		li $t0, 8 #t0 = 8 
		li $t1, 0 #t1 = 0
		la $a0, O3 #load O3
		li $v0, 4 #Print O3
		syscall #In ra man hinh thong tin mang 3
	
	main2: 
		slt $t2, $t1, $t0 # If t1 < t0 -> t2 = 1 (0 < 8)
		beq $t2, 0, Bai3 # If t2 = 0 -> Bai3 (Thoat khoi bai 2)
		add $t3, $s1, $t1 # t3 = t1 + s1 (s1 la mang; t1 la thu tu phan tu)
		lb $t5, 0($t3) # Load tung byte tu dia chi (t3 + x) vao t5  
		li $t6, 16 #t6 = 16
		addi $a0, $t6, -1 #a0 = t6 - 1 (16 - 1) $a0 = $t6 - 1 (size2 - 1) 
		sub $a1, $a0, $t1 #$a1 = $a0 - $t1 (size2 - 1 - i)
		add $t7, $s1, $a1 #cong them dia chi nen cua array2 
		lb $t8, 0($t7) #load giá tri thanh ghi $t7 vào $t8 
		add $s4, $t5, $t8 #s4 = t5 + t8
		add $a0, $s4, 0 #a0 = s4
		li $v0, 1 
		syscall #in int
	
		la $a0, space 
		li $v0, 4 
		syscall #in "space"
	
		sll $s3, $s3, 2 #s3 = s3 * 4
		addi $t1, $t1, 1 #t1 += 1
		j main2 
	Bai3:
	
		la $s1, array1 #s1 chua address array1
		la $s2, array2 #s2 chua address array2
		la $a0, str1 
		li $v0, 4 
		syscall #In ra man hinh str1: Ban nhap vao mang thu 
	
		li $v0, 5 
		syscall #Nhap tu ban phim (read int)
	
		addi $t1, $v0, 0 #t1 = v0
		beq $t1, 1, arr1 #t1 = 1 -> arr1
		beq $t1, 2, arr2 #t1 = 2 -> arr2
	
	
	arr1: 
		li $s5,0 
		la $a0, str2 
		li $v0, 4 
		syscall #In ra cau hoi xuat phan tu thu may
	
		li $v0, 5 
		syscall #Nhan tu ban phim thu tu phan tu
		addi $t0, $v0, 0 #t0 = v0 (t0 luu thu tu)
	
	loop31: 
		beq $s5, $t0, output1 #If t0 (thu tu) = s5 -> output
		addi $s5, $s5, 1 #s5 += 1
		sll $s6, $s5, 2 #s6 = s5 * 4
		j loop31 
		
	output1: #Xuat mang1
		add $s7, $s1, $s6 
		lw $t0, 0($s7) 
		la $a0, str3 
		li $v0, 4 
		syscall #In ra mang hinh str3
	
		add $a0, $t0, 0 
		li $v0, 1 
		syscall #In ra phan tu a0
	
		j Exit 
	
	arr2: 
		la $a0, str2 
		li $v0, 4 
		syscall 
		li $v0, 5 
		syscall 
		addi $t2, $v0, 0 
	
	loop32: #tuong tu 31
		beq $t3, $t2, output2 
		addi $t3, $t3, 1 
		j loop32 
	
	output2: #Tuong tu output1
		add $t5, $s2, $t3 
		lb $t4, 0($t5) 
		la $a0, str3
		li $v0, 4 
		syscall 
		
		add $a0, $t4, 0 
		li $v0, 1 
		syscall 
		j Exit 
Exit:


