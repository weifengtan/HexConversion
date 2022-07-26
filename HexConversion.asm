###############################################################################################
# Created by: Tan, Wei feng							              #
# Wtan40										      #	
# 1 December 2020									      #	
#											      #	
# Assignment: Lab 4: Searching Hex			    				      #
# CMPE 012, Computer Systems and Assembly Language		    			      #
# UC Santa Cruz, Fall 2020								      #
#											      #		
# Description: This program prints out the program arguments, and turns them into integers,   #
#		Then finds the max number. 						      #
#											      #
# Notes: This program is intended to be run from the MARS IDE.			              #
#											      #
# PUESUDO CODE:    Make new registers for a1 and a0 so i can increment and print out	      #
#		   program arguments. 							      #
#		   Then I load each byte of the word from a1 and multiply by 1,16,256         #
#	           based on how many times i looped through the word argument.                #
#		   I make a new register to hold the max value, so when a bigger number       # 
#		   is calculated I replace it into the new register.                          #
###############################################################################################		   

.data
    ProgramArg: .asciiz "Program arguments:"
    IntVal: .asciiz "Integer values:"
    Max: .asciiz "Maximum value:"
    Space: .asciiz " "
    NewLine: .asciiz "\n"


.text
    li $t2  0		                 # counter for a0, counts which hex number its on.
    li $v0 4
    move $t0 $a0  			 # moves the number of total arguments into t0
    move $t1 $a1			
    la $a0 ProgramArg
    syscall
    la $a0 NewLine
    syscall
 Argument: nop
    beq $t2 $t0 ExitArg	                 # exit the loop when the counter is equal to the number of program arguments given
    lw $t3 ($t1)			 # putting the word in another register ($t0)
    li $v0 4						
    move $a0 $t3
    syscall	
    addi $t2 $t2 1
    beq $t2 $t0 NoSpaceArg			# branch away when I get last ProArg so I dont print space
    la $a0 Space
    syscall		                 	# print the word out 
NoSpaceArg:nop
    addi $t1 $t1 4		         	# add 4 to iterate to the next word
    
    b Argument
ExitArg: nop					#print out the prompt for integers
    li $v0 4 
    la $a0 NewLine
    syscall
    la $a0 NewLine
    syscall
    la $a0 IntVal
    syscall
    li $v0 4
    la $a0 NewLine
    syscall
    move $t1 $a1				# moves the argument address to t1
    
    li $t9 0					# Initialize  a new reg so i can exit to MaxNum
StartLength: nop
    beq $t9 $t0 MaxNum 
    addi $t9 $t9 1 
    li $s4 0					# total number
    li $t7 0 					# counting the number of bytes  
    li $t5 1 					# t5 = bytes
    lw $t4 ($t1)
    li $s0 0 				        # s0 counter for how many arguments there are  
    addi $t4 $t4 0			        # t4 = word (argument)
LengthArg: nop
     
     lb $t5 ($t4)				# load byte into t5 
     beqz $t5 ExitLength			# exit when byte is equal 0 (null)
     addi $t4 $t4 1				# increment byte by 1 
     addi $t7 $t7 1				 
     j LengthArg
     
ExitLength: nop
    
    li $t8 1 					#looping backwards untill i get x, multiply t8 by 16 each time untill i reach x
CheckChar: nop
    subi $t4 $t4 1				#length of bit -1
    lb $s2 ($t4) 				#load byte into s2 so s2 is byte of argument  
    
    beq $s2 'x' itX				#compare ascii value of x to s2
    ble $s2 '9' Integer				# branch to integer loop if ascii vaule is integer
    subi $s2 $s2 55				# else -55 because it is a char
Multiply: nop
    mul $s2 $s2 $t8				# multiply s2 by t8 which is exponent counter
    add $s4 $s4 $s2
    mul $t8 $t8 16				# exponent goes up by x16
    j CheckChar 				# loop back untill done with argument 
itX: nop
    li $v0 1
    la $a0 ($s4)
    syscall					# prints out the integer
    bgt $s4 $s5 Replace				#jump to replace where i change value of MAXnumber
    
Cont: nop
    addi $t1 $t1 4             			#when done with last byte increment to next word
    li $v0 4
    beq $t9 $t0 NoSpaceInt
    la $a0 Space
    syscall
NoSpaceInt:nop
    j StartLength

Integer: nop
    subi $s2 $s2 48				# If the ascii value in s2 is an integer -48
    j Multiply
    
Replace:
    move $s5 $s4				# replacing value of s5 everytime s4 is bigger to get max
    j Cont
    
MaxNum: nop					#Print out max number 
     li $v0 4
     la $a0 NewLine
     syscall
     la $a0 NewLine
     syscall
     la $a0 Max
     syscall
     la $a0 NewLine
     syscall
     li $v0 1
     la $a0 ($s5) 
     syscall 
     li $v0 4
     la $a0 NewLine
     syscall
     li $v0 10
     syscall
	
    
    
    
     
    
    
    
    
    
    
    
    
    
    
     

    
 
     

     
     

    

     
     
    
    
    
    
    
    

   
    
     
    
    
    
	
	
