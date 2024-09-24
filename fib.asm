.data 


.text

li $v0, 5
syscall 

addi $s3, $v0, 1 

beq $s3, 1, fib0

li $s1, 2
li $t0, 1
li $t1, 1
LOOP:
	beq $s1, $s3, LOOP_EXIT 
	
	add $t2, $t1, $t0
	move $t0, $t1
	move $t1, $t2
	
	addi $s1, $s1, 1
	j LOOP


LOOP_EXIT:
	move $s0, $t1
	j exit


fib0:
	li $s0, 1
	
	 
exit:
	li, $v0, 1
	move $a0, $s0
	syscall 