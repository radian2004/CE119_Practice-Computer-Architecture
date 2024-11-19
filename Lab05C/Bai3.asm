
#3. Cho pt bac 2: ax2 + bx + c = 0. Nhap cac he so a,b,c tu bàn phím. Tìm nghiem
#cua pt bac 2 do.
	
.data
	Template:   .asciiz "Chuong trinh giai pt bac 2: ax2 + bx + c = 0 duoc viet boi RadiAn!\n"
    	Nhapa:      .asciiz "Nhap he so a la: "
    	Nhapb:      .asciiz "Nhap he so b la: "
    	Nhapc:      .asciiz "Nhap he so c la: "
    	TBSaiDK:    .asciiz "So ban nhap khong thoai dieu kien! Moi ban nhap lai!\n"
    	VoNghiem:   .asciiz "Phuong trinh vo nghiem!\n"
    	NghiemKep:  .asciiz "Phuong trinh co nghiem kep la: "
    	NghiemPB:   .asciiz "Phuong trinh co nghiem phan biet la: \n"
   	x1:    	    .asciiz "x1 = "
    	x2:         .asciiz "x2 = "
    	Endln:      .asciiz "\n"
 	TiepTuc:    .asciiz "Nhap '1' de tiep tuc, cac so khac de ket thuc, cau tra loi cua ban la: "
 	Thoat:	    .asciiz "Xin chao va hen gap lai!"
	KhongFloat: 	.float 0.0
	Mot: 		.float -1.0
	Bon: 		.float 4 
	Hai: 		.float 2
	x: 		.word 1
	
.text

    	li $v0, 4
    	la $a0, Template
    	syscall # In template
    	
    	
	lw $t3, x
 
 Main:
 	lwc1 $f4, KhongFloat
 	lwc1 $f2, Mot
 	lwc1 $f20, Hai
 	lwc1 $f18, Bon
 
 
 	li $v0, 4 
 	la $a0, Nhapa
 	syscall #In thong bao nhap so a
 
 	li $v0, 6
 	syscall
	mov.s $f6, $f0
 
 
 	li $v0, 4 
 	la $a0, Nhapb
 	syscall #In thong bao nhap so b
  
 	li $v0, 6
 	syscall
	mov.s $f8, $f0
  
	li $v0, 4
 	la $a0, Nhapc
 	syscall #In thong bao nhap so c
  
 
 	li $v0,6
 	syscall
 	mov.s $f10, $f0

	mul.s $f14, $f8, $f8 	# b * b
	mul.s $f2, $f8, $f2 	# -b 
	mul.s $f16, $f6, $f10   # a * c
	mul.s $f10, $f18, $f16 	# 4 * a * c
	sub.s $f22, $f14, $f10 	# b * b - 4 * a * c 
	mfc1 $t1, $f22		
	
	bltz $t1 Vonghiem	#Neu $t1 < 0 thi vo nghiem
	sqrt.s $f28, $f22 	# sqrt(b * b - 4 * a * c) = sqrt(delta)
	add.s $f22, $f2, $f28   # -b + sqrt(delta) = d1
	sub.s $f24, $f2, $f28   # -b - sqrt(delta) = d2	
	mul.s $f16, $f20, $f6   # 2a check $f16 if errorr
	div.s $f26, $f22, $f16  # d1 / 2a
	div.s $f30, $f24, $f16  # d2 / 2a

	beqz $t1 Nghiemkep
	
	li $v0, 4
 	la $a0, NghiemPB
 	syscall #In thong bao xuat nghiem phan biet
 
 	la $v0, 4
 	la $a0, x1
 	syscall #In thong bao x1
 	
 	li $v0, 2
 	add.d $f12, $f4, $f26
 	syscall #In x1
 	
 	li $v0, 4
 	la $a0, Endln
 	syscall #In Endln
 	
 	li $v0, 4
 	la $a0, x2
 	syscall #In thong bao x2
 	
  	li $v0,2
 	add.d $f12, $f4, $f30
 	syscall
 	
 	li $v0, 4
 	la $a0, Endln
 	syscall #In Endln
 	 
	b Tieptuc

Nghiemkep:
	li $v0, 4
	la $a0, NghiemKep
	syscall #In thong bao nghiem kep
	
	li $v0, 4
	la $a0, x1
	syscall #In thong bao x1
	
	li $v0, 4
	la $a0, x2
	syscall #In thong bao x2
	
	li $v0, 2
	add.d $f12, $f4, $f26
	syscall #Xuat nghiem x
	
	li $v0, 4
	la $a0, Endln
	syscall #In Endln
	
	b Tieptuc
	
Vonghiem:
	li $v0, 4
	la $a0, VoNghiem
	syscall #In thong bao pt vo nghiem
	
Tieptuc:
	li $v0, 4
	la $a0, TiepTuc
	syscall

	li $v0,5
	syscall
	move $t0, $v0
	beq $t0, $t3, Main #quay lai main neu $t0 = 1 


Exit:
	li $v0, 4
	la $a0, Thoat
	syscall #In thong bao thoat
	
	li $v0, 10 
	syscall #Exit
	
