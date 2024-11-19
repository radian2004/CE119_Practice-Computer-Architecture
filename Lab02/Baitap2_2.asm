
.data

.text

main:
	addi $s0, $s0, 1 #load i = 1
	addi $s1, $s1, 9 #load N = 9 vao
	addi $s2, $s2, 0 #load Sum = 0
	
	
LOOP:
	bgt $s0, $s1, exit #If i > N exit 
	add $s2, $s2, $s0 #sum = sum + i
	addi $s0, $s0, 1 #++i
	j LOOP

exit: