.text

.globl main

	main:
	li $t2 9
	li $t4 3
	li $t5 2
	mul $t3 $t4 $t5
	add $t1 $t2 $t3

	move $a0 $t1
	li $v0,1
	syscall

	li $v0,10
	syscall