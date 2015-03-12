.text

.globl main

main:
  ##### 2+3
  li $t0 2
  li $t1 3
  add $t0 $t0 $t1

  # printing result of 2+3
  li $v0,1
  move $a0, $t0
  syscall

  ##### 2*3
  li $t0 2
  li $t1 3
  mul $t0 $t0 $t1

  # printing result of 2*3
  li $v0,1
  move $a0, $t0
  syscall

  ##### 1+2*3
  li $a0 1
  li $t0 2
  li $t1 3
  mul $t0 $t0 $t1
  add $a0 $a0 $t0

  # printing result of 1+2*3
  li $v0,1
  syscall

  ##### 1+2*3+4
  li $a0 1
  li $t0 2
  li $t1 3
  li $t2 4
  mul $t0 $t0 $t1
  add $a0 $a0 $t0
  add $a0 $a0 $t2

  # printing result of 1+2*3+4
  li $v0,1
  syscall

  ##### exit program
  li	$v0,10
  syscall
