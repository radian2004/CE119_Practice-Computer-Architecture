	
	.data
prompt: .asciiz "Enter one number: "
prompt2: .asciiz "Your number + 1 is: "

	.text
main:	jal getInt
	move $s0, $v0
	jal showInt
	j exit
	
getInt:	li $v0, 4
	la $a0, prompt
	syscall #In ra nhap so
	
	li $v0, 5
	syscall #Nhap so
	jr $ra #Tro ve vi tri truoc khi goi getInt
	
showInt: 	
	li $v0, 4
	la $a0, prompt2
	syscall #In ra cau so cua minh
		
	li $v0, 1
	addi $a0, $s0, 1	
	syscall #In ra so
	jr $ra #Tro ve vi tri truoc khi goi showInt
exit:


	
