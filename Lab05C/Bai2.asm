
#2. Nhap tu ban phim mot so N bat ky (N>3). Nhap N so tu ban phim. 
#Xuat ra so lon nhat, so nho nhat trong N so do
.data
	
	Template:   	.asciiz "Chuong trinh duoc viet boi RadiAn!\n"
	NhapN:		.asciiz "Nhap so N (> 3) tu ban phim la: "
	TBSaiDK:    .asciiz "So ban nhap khong thoai dieu kien! Moi ban nhap lai!\n"
	NhapThuN:	.asciiz "Nhap gia tri cua chi so thu "
	La:		.asciiz " la: "
	Max:		.asciiz "So lon nhat la: "
	Min:		.asciiz "\nSo be nhat la: "
	array:		.word	4:100
	TiepTuc:    .asciiz "\nNhap '1' de tiep tuc, cac so khac de ket thuc, cau tra loi cua ban la: "
	Thoat:	    .asciiz "Xin chao va hen gap lai!"
	
.text
	la $a0, Template
    	li $v0, 4
    	syscall # In template

Main:   
    	la $a0, NhapN
    	li $v0, 4
    	syscall # In NhapN

    	la $v0, 5
    	syscall # Nhap N

    	addi $s1, $v0, 0
    	li $t1, 3   # load 3
    	bgt $s1, $t1, FOR  # Neu N > 3 thì tiep tuc

    	la $a0, TBSaiDK
    	li $v0, 4
    	syscall  # In thông báo sai dk
    	j Main #Quay lai main khi nhap sai

FOR:
	la $s2, array
	li $t2, 1 #Chi so dau tien cua mang
	
LOOPNHAP:	

	bgt $t2, $s1, OUTLOOPNHAP #Neu chi so mang lon hon N => out Nhap
	
	la $a0, NhapThuN
	li $v0, 4
	syscall #In thong bao nhap thu N
	
	addi $a0, $t2, 0
	li $v0, 1
	syscall #In chi so nhap
	
	la $a0, La
	li $v0, 4
	syscall #In chu la
	
	li $v0, 5
	syscall #Nhap gia tri
	
	sw $v0, 0($s2) #Luu gia tri vao ram
	
	addi $t2, $t2, 1 #Tang chi so mang len 1
	addi $s2, $s2, 4 #Tang chi so offset len 4
	
	j LOOPNHAP 
	
	
OUTLOOPNHAP:
	
	#Tim Max
	
	li $t4, 2
	la $s2, array
	
	
	lw $t1, 0($s2)
	addi $s4, $t1, 0 #Max = $t1
FindMax:
	
	bgt $t4, $s1, OUTFINDMAX #Neu $t4 > $s1 => Out de xuat MAX

	lw $t2, 4($s2)
	bgt $s4, $t2, IFMAX #$s4 > $t2 => IFMAX
	addi $s4, $t2, 0 #Max = $t2
	j PlusMax
	
IFMAX:
	addi $s4, $s4, 0 #Max = $s4
	
PlusMax:	
	addi $s2, $s2, 4 #Tang chi so offset len 4
	addi $t4, $t4, 1
	j FindMax

OUTFINDMAX:
		
	la $a0, Max
	la $v0, 4
	syscall #In thong bao Max
	
	la $v0, 1
	addi $a0, $s4, 0
	syscall #In ra so Max

	#Tim Min
	
	li $t4, 2
	la $s2, array
	
	lw $t1, 0($s2)
	addi $s5, $t1, 0 #Min = $t1
FindMin:
	
	bgt $t4, $s1, OUTFINDMIN #Neu $t4 > $s1 => Out de xuat MIN
	lw $t2, 4($s2)
	blt $s5, $t2, IFMIN #$s5 < $t2 => IFMIN
	addi $s5, $t2, 0 #MIN = $t2
	j PlusMin
	
IFMIN:
	addi $s5, $s5, 0 #MIN = $s5
	
PlusMin:	
	addi $s2, $s2, 4 #Tang chi so offset len 4
	addi $t4, $t4, 1
	j FindMin

OUTFINDMIN:
	la $a0, Min
	la $v0, 4
	syscall #In thong bao Min
	
	la $v0, 1
	addi $a0, $s5, 0
	syscall #In ra so Min
	
Tieptuc:
	li $v0, 4
	la $a0, TiepTuc
	syscall

	li $t3, 1
	li $v0, 5
	syscall
	
	move $t0, $v0
	beq $t0, $t3, Main #quay lai main neu $t0 = 1 


Exit:
	li $v0, 4
	la $a0, Thoat
	syscall #In thong bao thoat
	
	li $v0, 10 
	syscall #Exit
	
	
