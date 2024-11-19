	
.data
str: .asciiz "(a + b) - (c + d) = "
str2: .asciiz "(a - b) + (c - d) = "
str3: .asciiz "\n"

.text
	#Thay doi gia tri a, b, c, d
	li	$s0, 9
	li	$s1, 3
	li 	$s2, 5
	li 	$s3, 2	
	
	#Chuyen gia tri de truoc khi vao ham
	move	$a0, $s0
	move 	$a1, $s1
	move 	$a2, $s2
	move 	$a3, $s3
	jal	proc_example
	
	addi $s0, $v0, 0
	addi $s1, $v1, 0
	
	la $a0, str
	li $v0, 4
	syscall #in ra cau s0
	
	addi 	$a0, $s0, 0 	
	li	$v0, 1
	syscall #In ra s0
	
	la $a0, str3
	li $v0, 4
	syscall #in ra endln
	
	la $a0, str2
	li $v0, 4
	syscall #in ra cau s1
	
	addi 	$a0, $s1, 0
	li 	$v0, 1
	syscall #In ra s1
	j exit
	
proc_example:
	addi	$sp, $sp, -4
	sw	$s0, 0($sp)
	
	add	$t0, $a0, $a1 #t0 = a + b
	add 	$t1, $a2, $a3 #t1 = c + d
	sub 	$s0, $t0, $t1 #s0 = t0 - t1
	
	sub 	$t0, $a0, $a1 #t0 = a - b
	sub 	$t1, $a2, $a3 #t1 = c - d
	add 	$s1, $t0, $t1 #s1 = t0 + t1
	
	move	$v0, $s0 #doi s0 ra v0 de thoat khoi ham
	move 	$v1, $s1 #doi s1 ra v1 de thoat khoi ham
	
	lw	$s0, 0($sp) #luu s0 vao sp
	addi	$sp, $sp, 4 #tang sp len 1 o nho
	
	jr 	$ra

exit:
