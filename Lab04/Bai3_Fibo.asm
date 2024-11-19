.data
	str: .asciiz "Nhap vao so n: "
	xuat: .asciiz "Chuoi Fibonacci tu 0 den so thu n là: "
	endl: .asciiz "\n"
	space: .asciiz " "
.text
main:
  
    li $v0, 4
    la $a0, str
    syscall
    
    li $v0, 5
    syscall
    move $t0, $v0   		# to = v0 = n
    
   
    li $v0, 4
    la $a0, xuat #In thong bao chuoi fibo
    syscall
  
    move $t1, $zero   		#t1 = 0
    li $t2, 1   		#t2 0 1
    
    li $v0, 1
    move $a0, $t1		#in ra so 0
    syscall

    li $v0, 4
    la $a0, space
    syscall  #In khoang trang
 
    li $v0, 1
    move $a0, $t2		#in ra co 1
    syscall
    
    li $v0, 4
    la $a0, space
    syscall #In khoang trang
    
# day tu so thu 3 den so thu n
    addi $t0, $t0, -2   # giam n di 2 vi da in hai sô 0 va 1
    blez $t0, exit      # n <= 1 thi thoat
    
    loop:
        add $t3, $t1, $t2   #so tiep theo bang hai so sau cong lai
        li $v0, 1
        move $a0, $t3      
        syscall #in ra so vua tinh duoc

	li $v0, 4
	la $a0, space
	syscall #In khoang trang
	
        move $t1, $t2      #cap nhat lai so t1 = t2
        move $t2, $t3      #cap nhat lai so t2 = t3
        
        addi $t0, $t0, -1   #giam di mot vi da in ra mot so
        bgtz $t0, loop      #neu n > 0 thi tiep tuc vong lap
    
    exit:
   
    li $v0, 4
    la $a0, endl
    syscall #In endl
    
    j end

end: