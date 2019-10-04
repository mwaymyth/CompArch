li $t5, 1 # counter for loops
la $s1, array
 
promptLoop: 
beq $t5, 5, finishedInput # ends after 4 iter
la $a0, prompt #load prompt message into $a0 
li $v0, 4 #print string
syscall 
la $a0, ($t5) #load prompt message into $a0 for syscall 
li $v0, 1 #print int 
syscall 
la $a0, colon # load colon into $a0 
li $v0, 4 
syscall
 
readLoop: 
 
jal getc #jump to getc
  
lb $t0, char #stripping space 
sb $t0, 0($s1) #store the char into the correct elem of array
  
lb $t1, newline #load newline char into t1, checking for end of line
beq $t0, $t1, increaseCount  #end of string? jump to finished_looping
 
lb $t1, space #load newline char into t1 , checking for space
beq $t0, $t1, readLoop
addi $s1, $s1, 1 # increments base address of array j loop #jump to start of read loop
 
getc: #read char from keyboard and return ascii
li $v0, 8 # read string 
la $a0, char #load address of char
li $a1, 2 # 1byte char and 1byte for space
syscall 
jr $ra #jump-register, back to read
 
increaseCount:
addi $t5, $t5, 1 # increment counter
j promptLoop # jumps back to promptLoop
 
finishedInput:
addi $t5, $t5, -4 # resets the counter
la $s1, array # loads the array back into $s1
 
outputLoop:
beq $t5, 5, end 
la $a0, Output #load output prompt to $a0
li $v0, 4 
syscall 
la $a0, ($t5) # load prompt message into $a0
li $v0, 1 # print int 
syscall
la $a0, colon #load prompt message into $a0  
li $v0, 4 
syscall 

li $t3, 1 # outputCounter
 
stringToInt: 
beq $t3, 5, outputIncreaseCount 
addi $t3,$t3,1 # increment counter
lb $a0,($s1) # load byte of the first char
lb $t1, newline #load newline char into t1
beq $a0, $t1, end 
 
addi $a0, $a0,-48 # turns ascii to int
li $v0, 1 
syscall 
la $a0, space # load prompt message into $a0 for syscall
li $v0, 4 #load syscall to print string 
syscall 
addi $s1, $s1, 1 #increments base address of array
 
j stringToInt # loops back itself
 
outputIncreaseCount:
 
addi $t5, $t5, 1 #increment
j outputLoop # back to the loop again
 
#program is done
end: 
 
li $v0, 10
syscall

.data 
array: .space 33 
char: .space 2 
prompt: .asciiz "Input Row " 
colon: .asciiz ": "
Output: .asciiz "\nRow " 
space: .asciiz " "
newline: .asciiz "\n"
