
	.data 
Output: 	.asciiz "The factorial of 10 is: "
	.text
	
main: 	   	
    	addi 	$v0, $0, 10
    	move    $a0, $v0   
    	add     $a0,$a0,1
    	
    	jal     fact   # nhay den ham giai thua  
        move 	$s2, $v0
        
        la 	$a0, Output
        li 	$v0, 4
        syscall #In ra thong bao
        	
    	li      $v0, 1        
	addi 	$a0, $s2, 0      
    	syscall #Xuat 10!
    	j 	exit
    	
fact:   addi    $sp, $sp, -8 #tao vung nho cho stack de luu dia chi va gia tri tra ve
    	sw      $a0, 4($sp)   #luu $a0 vao stack
    	sw      $ra, 0($sp)   #luu $ra vao stack
   	bne     $a0, 1, else  # if n != 1 nhay toi else
    	addi    $v0, $zero, 1    #return 1
    	j 	return                #nhay den return
 
else:	addi    $a0, $a0, -1   # n = n - 1
    	jal     fact       #  gia tri fact(n - 1) trong $v0
    	mulo    $v0, $v0 ,$a0 # return n * fact(n - 1)
   
return:	lw      $a0, 4($sp) # lay gia tri $a0 trong stack
    	lw      $ra, 0($sp) # lay gia tri $ra trong stack 
    	addi    $sp, $sp, 8 # giai phong vung nho cu trong stack
    	jr      $ra         # nhay den dia chi cau lenh sau cau lenh jal
exit: 


