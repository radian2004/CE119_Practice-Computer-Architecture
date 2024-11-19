
# i - $s0		j - $s1			A - $s3

.data	
	array:				.word		0:50
	Template: 			.asciiz 	"Chuong trinh viet by RadiAn!\n"
	mess_NhapPT:			.asciiz		"Nhap phan tu thu "
	mess_Nhap_n:			.asciiz		"Nhap so phan tu cua mang( 0 <= n <= 50) la: "
	mess_NKHL:			.asciiz		"So phan tu nhap vao khong hop le!\n"
	mess_HC:			.asciiz		": "
	mess_XD:			.asciiz		"\n"
	mess_KC:			.asciiz		" "
	mess_Nhap_j:			.asciiz		"Nhap j: "
	mess_Thao_tac_tai_a_i:		.asciiz		"Voi a["
	mess_1:				.asciiz		"]\n    "
	mess_Mang_Truoc_Doi:		.asciiz		"Mang truoc khi thay doi array la: "
	mess_Mang_Sau_Doi:		.asciiz		"Mang sau khi thay doi array la: "
	mess_Muon_thuc_hien_lai_khong:	.asciiz		"Ban muon thuc hien lai chuong trinh khong (1 neu co, 0 neu khong): "
	mess_Ket_Thuc_CT:		.asciiz		"Xin chao va hen gap lai!\n"
.text

main:
	la $a0, Template
	li $v0, 4
	syscall	#In Template
		
	# Load di chi mang vo $s3
	la	$s3, array
	
	li 	$v0, 4
	la	$a0, mess_Nhap_n
	syscall # Message thong bao nhap n
	
	# Nhap n
	li 	$v0, 5
	syscall
	move	$s2, $v0
	slt	$t0, $s2, $zero		# n < 0 => t0 = 1
	bne	$t0, $zero, NKHL
	addi	$t1, $zero, 50		# t1 = 50
	slt	$t0, $t1, $s2		# 200 < n => t0 = 1
	bne	$t0, $zero, NKHL
	
	# Thoat neu n = 0
	beq	$s2, $zero, Exit1
	# Set bien i($s0) de nhap mang
	addi	$s0, $zero, 0
	
	Loop_Nhap_Mang:
		# Kiem tra dieu kien nhap mang
		slt 	$t1, $s0, $s2	
		beq 	$t1, $zero, End1
		
		li	$v0, 4
		la	$a0, mess_NhapPT
		syscall # Message nhap phan tu thu
		
		li	$v0, 1 	
		la	$a0, ($s0)
		syscall #Nhap phan tu thu 
		
		li 	$v0, 4
		la	$a0, mess_HC
		syscall #In ra dau :
		
		li	$v0, 5
		syscall
		sw	$v0, 0($s3) # Nhan gia tri
		
		#Tang gia tri cua bien dem + gia tri con tro mang
		addi	$s0, $s0, 1
		addi	$s3, $s3, 4	
		j Loop_Nhap_Mang
	End1:
	
	# Set s3 ve phan tu thu 0
	la	$s3, array
	#Set gia tri cho i ve 0
	addi	$s0, $zero, 0
	
	li	$v0, 4
	la	$a0, mess_Mang_Truoc_Doi
	syscall # In mang truoc khi thay doi
	
	Loop_In:
		# Kiem tra dieu kien lap mang
		slt 	$t1, $s0, $s2	
		beq 	$t1, $zero, End2
		
		li	$v0, 1
		lw	$a0, ($s3)
		syscall # In mang
		
		li	$v0, 4
		la	$a0, mess_KC
		syscall #In Khoang trang
		
		# Tang gia tri bien dem va con tro mang
		addi	$s0, $s0, 1
		addi 	$s3, $s3, 4
		j Loop_In
		
	End2:
		# Xuong dong
		li	$v0, 4
		la	$a0, mess_XD
		syscall
	
		
	# Set s3 ve phan tu thu 0
	la	$s3, array
	#Set gia tri cho i ve 0
	addi	$s0, $zero, 0
	
	Loop_3B:
		# Kiem tra dieu kien lap mang
		slt 	$t1, $s0, $s2	
		beq 	$t1, $zero, End3
		
		li 	$v0, 4
		la	$a0, mess_Thao_tac_tai_a_i
		syscall # Message thao tac tai a[i]
		
		li	$v0, 1
		la	$a0, ($s0)
		syscall #Nhap phan tu
		
		li	$v0, 4
		la	$a0, mess_1
		syscall #In ra ]\n
		
		li	$v0, 4
		la	$a0, mess_Nhap_j
		syscall # Message nhap gia tri cho j
		
		li 	$v0, 5
		syscall
		move 	$s1, $v0 # Nhan gia tri cua j -> s1 = j
		
		# Kiem tra dieu kien j
		slt 	$t3, $s0, $s1
		beq	$t3, $zero, ELSE
		IF:
			sw	$s0, ($s3)
			j Return_Loop
		ELSE:
			sw	$s1, ($s3)
		Return_Loop:
			#tang gia tri cho i va tro cua mang
			addi	$s0, $s0, 1
			addi	$s3, $s3, 4
			j Loop_3B
	End3:
	
	# Set s3 ve phan tu thu 0
	la	$s3, array
	
	#Set gia tri cho i ve 0
	addi	$s0, $zero, 0
	
	li	$v0, 4
	la	$a0, mess_Mang_Sau_Doi
	syscall # In mang sau khi thay doi
	
	Loop_In2:
		# Kiem tra dieu kien lap mang
		slt 	$t1, $s0, $s2	
		beq 	$t1, $zero, End4
		
		li	$v0, 1
		lw	$a0, ($s3)
		syscall # In mang
		
		li	$v0, 4
		la	$a0, mess_KC
		syscall #In Khoang trang
		
		# Tang gia tri bien dem va con tro mang
		addi	$s0, $s0, 1
		addi 	$s3, $s3, 4
		j Loop_In2
		
	End4:
		# Xuong dong
		li	$v0, 4
		la	$a0, mess_XD
		syscall #In xuong dong
		j Exit1
	
	NKHL:
		li	$v0, 4
		la	$a0, mess_NKHL
		syscall	#Message n khong hop le
	Exit1: 
		
		li	$v0, 4
		la	$a0, mess_Muon_thuc_hien_lai_khong
		syscall # Message co muon tiep tuc khong
		
		li 	$v0, 5
		syscall #Nhan du lieu
		addi	$t3, $zero,1
		bne	$v0, $t3, Exit2
		j main
	Exit2:
		li	$v0, 4
		la	$a0, mess_Ket_Thuc_CT
		syscall
	
			 	
	
	
	
	
	
	
	
	
