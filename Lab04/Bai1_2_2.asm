.data
str: .asciiz "(a + b) - (c + d) = "
str2: .asciiz "e - f = "
str3: .asciiz "\n"

.text
	#Thay doi gia tri a, b, c, d, e, f
	li	$s0, 10
	li	$s1, 6
	li 	$s2, 4
	li 	$s3, 2	
	li 	$s4, 9
	li 	$s5, 1
	
	#Chuyen gia tri de truoc khi vao ham
	move $a0, $s4		#a0 == e
	move $a1, $s5		#a1 = f
	move $a2, $s2     	#a2 = c
	move $a3, $s3		#a3 = d
	
	addi $sp, $sp, -4
	sw   $a0, 0($sp) 	#luu gia tri cua e vao sp 4
	move $a0, $s0		# a0 = a
	
	addi $sp, $sp, -4
	sw   $a1, 0($sp) 		#luu gia tri cua f vap sp 
	move $a1, $s1		# a1 = b
	
	jal proc_example

	li $v0, 4
	la $a0, str
	syscall #xuat (a+b) -( c+d)
	
	move $a0, $v0
	li $v0, 1
	syscall #xuat s0

	li $v0, 4
	la $a0, str3
	syscall #xuat endl

	li $v0, 4
	la $a0, str2
	syscall #xuat e - f
	
        move $a0, $v1
        li $v0, 1
        syscall # xuat s1
        
        j exit
        
proc_example:
	addi $sp, $sp, -4
	sw   $s0, 0($sp)	#luu gia tri a vao sp 
	add  $t0, $a0, $a1
	add  $t1, $a2, $a3
	sub  $s0, $t0, $t1
	
	move $v0, $s0		#v0 = (a+ b) - (c+d) 
	
	lw $s0, 0($sp)         #khoi phuc s0 = a
	addi $sp, $sp, 4
	
	lw $a1, 0($sp) #phuc hoi lai a1 = f
	addi $sp ,$sp,  4
	lw $a0, 0($sp) #phuc hoi lai a0 = e
	
	addi $sp, $sp, -8
	sw $s1, 0($sp)    #luu gia tri cua b vao sp
	
	sub $s1, $a0, $a1
	move $v1, $s1
	
	lw $s1, 0($sp) #khoi phuc lai gia tri s1 = b
	addi $sp, $sp, 8
	jr $ra
exit:
	
	
 

	
	
 
