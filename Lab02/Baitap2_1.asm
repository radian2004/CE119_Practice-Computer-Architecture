
.data

.text

main: 
	addi $s0, $s0, 6  #load i
	addi $s1, $s1, 5  #load j
	addi $t0, $t0, 8  #load g
	addi $t1, $t1, 7  #load h
	bne $s0, $s1,ELSE #If i == j thi lam IF
IF:
	add $s2, $t0, $t1 #f = g + h
	j exit
ELSE:
	sub $s2, $t0, $t1 #f = g - h
exit:	