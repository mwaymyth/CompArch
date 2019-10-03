  li $a2, 0 # grand piano
  li $a3, 100
  li $a1 500
  
  li $t0, 0 #array counter
  li $t1, 64 #array size
  la $s0, notes
  la $s1, duration
  loop:
  	beq $t0, $t1, exit #loop checker
  	
  	add $t3, $s0, $t0 #position
  	lb $a0, 0($t3)#load notes
  	sll $t5, $t0, 2
  	add $t2, $s1, $t5
  	lw $a1, 0($t2) #load duration
  	
  	addi $t6, $a0, 0
  	la $a0, ($t6)
  	li $v0, 31
  	syscall #call play notes
  	
  	addi $t6, $a1, 0
  	la $v0, 32
  	la $a0, ($t6)
  	syscall#call pauses
  	
  	addi $t0, $t0, 2
  	
  	j loop
  exit:
  
  li $v0, 10
  syscall
  
  .data
    notes: .byte 61, 72, 63, 70, 72, 68, 63, 70, 60, 67
    duration: .word 600, 500, 400, 500, 600, 300, 400, 500, 300

#.data
 #   notes: .byte 67, 63, 67, 63, 68, 67, 66, 62, 63, 67, 66 56, 63, 60, 67
  #  duration: .word 600, 300, 600, 300, 600, 200, 600, 300, 450, 150, 300, 600, 300, 1800, 600, 300