
.data	
	array:				.word		0:50
	Template:			.asciiz 	"Chuong trinh viet by RadiAN!\n"
	mess_NhapPT:			.asciiz		"Nhap phan tu thu "
	mess_Nhap_n:			.asciiz		"Nhap so phan tu cua mang( 0 <= n <= 50) la: "
	mess_NKHL:			.asciiz		"So phan tu cua mang khong hop le!\n"
	mess_0PT:			.asciiz		"Mang co 0 phan tu!\n"
	mess_HC:			.asciiz		": "
	mess_XD:			.asciiz		"\n"
	mess_KC:			.asciiz		" "
	mess_InArr:			.asciiz		"Mang la: "
	mess_Max:			.asciiz		"Gia tri lon nhat cua mang la: "
	mess_Min:			.asciiz		"Gia tri nho nhat cua mang la: "
	mess_Sum:			.asciiz		"Tong cac phan tu cua mang la: "
	mess_NhapChiSo:			.asciiz		"Nhap chi so cua phan tu can kiem tra (trong pham vi cua mang): "
	mess_PTKHL:			.asciiz		"Phan tu khong hop le.\n"
	mess_GiaTriPT:			.asciiz		"Gia tri cua phan tu can kiem tra la: "
	mess_Muon_thuc_hien_lai_khong:	.asciiz	"Ban muon thuc hien lai chuong trinh khong (1 neu co, 0 neu khong): "
	mess_Ket_Thuc_CT:		.asciiz		"Xin chao va hen gap lai!\n"
	
.text
main:		
	
	la $a0, Template
	li $v0, 4
	syscall 	#In ra Template

	la	$s3, array	#load mang vao
	
	li 	$v0, 4		
	la	$a0, mess_Nhap_n	
	syscall	# thong bao nhap n		
	
	li 	$v0, 5		
	syscall			
	move	$s2, $v0 # Nhan gia tri n
		
	# Kiem tra n co hop le hay khong
	slt	$t0, $s2, $zero			
	bne	$t0, $zero, NKHL	
	addi	$t1, $zero, 50			
	slt	$t0, $t1, $s2			
	bne	$t0, $zero, NKHL		
	
	beq	$s2, $zero, M0PT # Thoat neu n = 0

	addi	$s0, $zero, 0 	# Set bien i($s0) de nhap mang
	
	# Nhap mang
	
	Loop_Nhap_Mang:
		# Kiem tra dieu kien nhap mang
		slt 	$t1, $s0, $s2		
		beq 	$t1, $zero, End1	
		
		li	$v0, 4 			
		la	$a0, mess_NhapPT		
		syscall	# In nhap phan tu thu			
		
		li	$v0, 1 			
		la	$a0, ($s0)		
		syscall # In chi so cua phan tu dang nhap	
				
		li 	$v0, 4			
		la	$a0, mess_HC		
		syscall	# in dau ":"			
		
		li	$v0, 5			
		syscall				
		sw	$v0, 0($s3) # Luu gia tri vao mang	
			
		# i++ , tang gia tri tro mang va tien hanh lap lai
		addi	$s0, $s0, 1		
		addi	$s3, $s3, 4		
		j Loop_Nhap_Mang		
	# ket thuc vong lap nhap mang array
	
	End1:

	# Set gia tri cho cac thanh ghi
	la	$s3, array		
	addi	$s0, $zero, 0		

	li	$v0, 4			
	la	$a0, mess_InArr		
	syscall	# Thong bao in mang	
		
	# In mang
	Loop_In:
		# Kiem tra dieu kien lap mang
		slt 	$t1, $s0, $s2		
		beq 	$t1, $zero, End2	
		
		li	$v0, 1			
		lw	$a0, ($s3)		
		syscall	# In arr[i] ra man hinh			
		
		li	$v0, 4			
		la	$a0, mess_KC		
		syscall	# In khoan trang			
		# i++ , tang gia tri tro mang va tien hanh lap lai
		addi	$s0, $s0, 1		
		addi 	$s3, $s3, 4		
		j Loop_In			
	# ket thuc lap in mang array
	
	End2:	
		
		li	$v0, 4		
		la	$a0, mess_XD	
		syscall	# In Xuong dong		

	# Set gia tri cho cac thanh ghi
	la	$s3, array		
	addi	$s0, $zero, 0		
	lw	$t0, ($s3)		
	lw	$t1, ($s3)		
	addi	$t2, $zero, 0		
	Loop_Max_min_Sum:
		#kiem tra dieu kien vong lap
		slt	$t4, $s0, $s2
		beq	$t4, $zero, EXIT
		
		#tinh tong(t2)
		lw	$t4, ($s3)	
		add	$t2, $t2, $t4	
		
		#kiem tra max(t1)
		slt	$t5, $t1, $t4	
		beq	$t5, $zero, continue2	
		add	$t1, $zero, $t4
		continue2:
		
		#kiem tra min(t0)
		slt 	$t5, $t4, $t0	
		beq	$t5, $zero, continue3
		add	$t0, $zero, $t4
		continue3:
		
		#tang i len 1 don vi: chi toi vi tri tiep theo
		addi 	$s0, $s0, 1
		addi	$s3, $s3, 4
		j Loop_Max_min_Sum
	EXIT:
	
	li	$v0, 4
	la	$a0, mess_Max
	syscall # in message max
	
	li 	$v0, 1
	la	$a0, ($t1)
	syscall # in max 
	
	li	$v0, 4
	la	$a0, mess_XD
	syscall # In xuong dong
	
	li	$v0, 4
	la	$a0, mess_Min
	syscall # in message min
	
	li 	$v0, 1
	la	$a0, ($t0)
	syscall # in min
	

	li	$v0, 4
	la	$a0, mess_XD
	syscall # xuong dong
	
	li	$v0, 4
	la	$a0, mess_Sum
	syscall # in message Sum
	
	li 	$v0, 1
	la	$a0, ($t2)
	syscall # in Sum
	
	li	$v0, 4
	la	$a0, mess_XD
	syscall # xuong dong
	
	li	$v0, 4
	la	$a0, mess_NhapChiSo
	syscall # Thong bao nhap chi so
	
	li	$v0, 5
	syscall	
	move 	$s4, $v0 #Nhan chi so
	
	#Kiem tra chi so
	slt	$t0, $s4, $zero		
	bne	$t0, $zero, PTKHL
	add	$t1, $zero, $s2		
	slt	$t0, $s4, $t1		
	beq	$t0, $zero, PTKHL
	
	la	$s3, array #Set lai vi tri s3
	
	
	li	$v0, 4
	la	$a0, mess_GiaTriPT
	syscall # Thong bao in phan tu thu n
	
	# In gia tri
	sll	$s4, $s4, 2
	add	$s3, $s3, $s4
	li	$v0, 1
	lw	$a0, ($s3)
	syscall
	
	li	$v0, 4
	la	$a0, mess_XD
	syscall # Xuong dong
	
	j EXIT1
	M0PT:
		li	$v0, 4
		la	$a0, mess_0PT
		syscall # Message mang khong co phan tu nao
		j EXIT1 
	PTKHL:
		li	$v0, 4
		la	$a0, mess_PTKHL
		syscall # Message phan tu nhap khong hop le
		j EXIT1
	
	NKHL:
		li	$v0, 4
		la	$a0, mess_NKHL
		syscall # Message n khong hop le
	EXIT1: 
		
		li	$v0, 4
		la	$a0, mess_Muon_thuc_hien_lai_khong
		syscall # Message co muon tiep tuc khong
		
		li 	$v0, 5
		syscall #Nhan du lieu
		addi	$t3, $zero,1
		bne	$v0, $t3, EXIT2
		j	main 
	EXIT2:
		li	$v0, 4
		la	$a0, mess_Ket_Thuc_CT
		syscall

	
	
	
	
