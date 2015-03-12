.text

.globl main

	main:
	li $t2 3
	li $t3 4
	add $t1 $t2 $t3

	move $a0 $t1
	li $v0,1
	syscall

	li $v0,10
	syscall