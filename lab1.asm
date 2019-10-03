li $v0,4 #load service number for string print in $v0
la $a0, name_string # load address of string to be printed into $a0
syscall
li $v0,8 # system code for read string
la $a0,answer #put address of answer string in $a0
lw $a1,alength #put length of string in $a1
syscall # read value goes into v0
li $v0,4
la $a0, age_string 
syscall
li $v0,5 #load service number in $v0
syscall
move $t0,$v0 #store value entered into another register
add $t1,$t0,4
li $v0,4
la $a0,greeting_string
syscall 
la $a0,answer
syscall
li $v0,4
la $a0,uwill_string
syscall
li $v0,1
move $a0,$t1
syscall
li $v0,4
la $a0,years_string
syscall


# the null-terminated string must be defined in data segment
.data
answer: .space 51
alength: .word 50
name_string: .asciiz "What is your name? "
age_string: .asciiz "What is your Age? "
greeting_string: .asciiz "Hello, "
uwill_string: .asciiz "You will be "
years_string: .asciiz " years old in four years"
