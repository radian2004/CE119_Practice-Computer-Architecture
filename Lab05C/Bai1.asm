
#Nhap 1 so bat ky lon hon 50, liet ke cac so nguyen to nho hon so vua nhap.

.data 
    	Template:   .asciiz "Chuong trinh duoc viet boi RadiAn!\n"
    	NhapN:      .asciiz "Nhap so N (> 50) tu ban phim la: "
    	TBSaiDK:    .asciiz "So ban nhap khong thoai dieu kien! Moi ban nhap lai!\n"
   	XuatSNT:    .asciiz "Cac so nguyen to nho hon "
    	La:         .asciiz " la: \n"
    	Endln:      .asciiz "\n"
	TiepTuc:    .asciiz "Nhap '1' de tiep tuc, cac so khac de ket thuc, cau tra loi cua ban la: "
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

    	add $s1, $v0, $0
    	li $t1, 50   # load 50
    	bgt $s1, $t1, FOR  # Neu N > 50 thì tiep tuc

    	la $a0, TBSaiDK
    	li $v0, 4
    	syscall  # In thông báo sai dk
    	j Main #Quay lai main khi nhap sai

FOR:
    	la $a0, XuatSNT
    	li $v0, 4
    	syscall # In thong bao xuat snt
    
    	addi $a0, $s1, 0
    	li $v0, 1
    	syscall # In ra so N
    
    	la $a0, La
    	li $v0, 4
    	syscall # In thong bao la
    	# Gan 2 la snt dau tien 
    	li $t5, 2
        
print_primes_loop:
    	# Kiem tra xem $t5 co phai la snt
    	move $a0, $t5           # $a0 = $t5
    	jal isPrime             # Goi ham ktra snt
    	beq $v0, $0, not_prime    # Neu khong la snt, nhay not_prime

    	# In snt
    	li $v0, 1               # In snt
    	syscall

    	li $v0, 4
    	la $a0, Endln   #Xuong dong       
    	syscall

not_prime:

    	addi $t5, $t5, 1  # Tang gia tri $t5

    	# Kiem tra xem $t5 co be hon N
    	addi $t1, $s1, 0        # $t1 = N
    	bge $t5, $t1, Tieptuc   #Neu $t5 >= $t1 -> Tieptuc

    	# Lap lai vong in snt
    	j print_primes_loop


# Ham kiem tra snt
# $a0: Tham so dau vao
# $v0: Tra ve: 1 la snt; 0 ko phai la snt
isPrime:

    	li $t0, 2     	# Gán $t0 = 2

    	# Lap while ($t0 * $t0 <= $a0)
check_divisible:

    	mul $t1, $t0, $t0       # Tính $t1 = $t0 * $t0
    	bgt $t1, $a0, la_snt  # Neu $t1 > $a0, thoát khoi vòng lap

   	 # Kiem tra num % i == 0
    	divu $a0, $t0           # $a0 = $a0 / $t0 (lay phan du)
    	mfhi $t2                # $t2 = phan du

    	beq $t2, $0, ko_snt     # Neu phan du = 0 => khong phai la snt

    	# Tang gia tri $t0 va lap lai while
    	addi $t0, $t0, 1
    	j check_divisible

	# Truong hop ko phai snt
	ko_snt:
    		li $v0, 0               # Gán $v0 = 0 (false)
    		jr $ra                  # Tra ve

	# Truong hop num la snt
	la_snt:
    		li $v0, 1               # Gán $v0 = 1 (true)
    		jr $ra                  # Tra ve

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
