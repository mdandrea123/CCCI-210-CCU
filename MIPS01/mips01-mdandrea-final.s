# Tell assembler to not insert instructions to fill branch delay slots.
# This is necessary when branch delay slots are disabled.
.set noreorder
 
.global _start
_start:
    # set the SP to the "correct" value 
    la $sp, 0x7FFFFFFC  # consistent with the book
    jal main
    li $v0, 10
    syscall       # Use syscall 10 to stop simulation
 
main:
    # allocate space to save the RA on the stack
    addi   $sp, $sp, -4
    # save the RA on the stack
    sw     $ra, 0($sp)
    
    la $a0, A
    li $a1, 6
    jal printArray
    # print a newline
    li $v0, 4
    la $a0, newline
    syscall
    # need to call sort on A , pass it the size of A (6 elements)
    # void sort(int v[], int n);
	la $a0, A
	li $a1, 6
	jal sort
	
	la $a0, A
    	li $a1, 6
    	jal printArray
 
# return back to start 
    # restore the RA from the stack
    lw     $ra, 0($sp)
    # deallocate space to save the RA on the stack
    addi   $sp, $sp, 4
  
jr $ra                 # return to calling routine
 
END:
    j END
 
 
sort:    addi $sp,$sp, -20      # make room on stack for 5 registers
            sw $ra, 16($sp)        # save $ra on stack
            sw $s3,12($sp)         # save $s3 on stack
            sw $s2, 8($sp)         # save $s2 on stack
            sw $s1, 4($sp)         # save $s1 on stack
            sw $s0, 0($sp)         # save $s0 on stack
            
            move $s2, $a0           # save $a0 into $s2
            move $s3, $a1           # save $a1 into $s3
            move $s0, $zero         # i = 0
for1tst: slt  $t0, $s0, $s3      # $t0 = 0 if $s0 ≥ $s3 (i ≥ n)
            beq  $t0, $zero, exit1  # go to exit1 if $s0 ≥ $s3 (i ≥ n)
            addi $s1, $s0, -1       # j = i – 1
for2tst: slti $t0, $s1, 0        # $t0 = 1 if $s1 < 0 (j < 0)
            bne  $t0, $zero, exit2  # go to exit2 if $s1 < 0 (j < 0)
            sll  $t1, $s1, 2        # $t1 = j * 4
            add  $t2, $s2, $t1      # $t2 = v + (j * 4)
            lw   $t3, 0($t2)        # $t3 = v[j]
            lw   $t4, 4($t2)        # $t4 = v[j + 1]
            slt  $t0, $t4, $t3      # $t0 = 1 if $t4 < $t3
            bne  $t0, $zero, exit2  # go to exit2 if $t4 < $t3
            move $a0, $s2           # 1st param of swap is v (old $a0)
            move $a1, $s1           # 2nd param of swap is j
            jal  swap               # call swap procedure
            addi $s1, $s1, -1       # j –= 1
            j    for2tst            # jump to test of inner loop
exit2:   addi $s0, $s0, 1        # i += 1
            j    for1tst            # jump to test of outer loop
          
          
          
            exit1: lw $s0, 0($sp)  # restore $s0 from stack
            lw $s1, 4($sp)         # restore $s1 from stack
            lw $s2, 8($sp)         # restore $s2 from stack
            lw $s3,12($sp)         # restore $s3 from stack
            lw $ra,16($sp)         # restore $ra from stack
            addi $sp,$sp, 20       # restore stack pointer
            jr $ra                 # return to calling routine
 
 
 
swap: sll $t1, $a1, 2   # $t1 = k * 4
        add $t1, $a0, $t1 # $t1 = v+(k*4)
                                #   (address of v[k])
        lw $t0, 0($t1)    # $t0 (temp) = v[k]
        lw $t2, 4($t1)    # $t2 = v[k+1]
        sw $t2, 0($t1)    # v[k] = $t2 (v[k+1])
        sw $t0, 4($t1)    # v[k+1] = $t0 (temp)
        jr $ra            # return to calling routine
 
printArray:
     # Function prologue
     addi $sp, $sp, -20       # Make room on the stack for registers
     sw $ra, 16($sp)          # Save $ra on the stack
     sw $s3, 12($sp)          # Save $s3 on the stack
     sw $s2, 8($sp)           # Save $s2 on the stack
     sw $s1, 4($sp)           # Save $s1 on the stack
     sw $s0, 0($sp)           # Save $s0 on the stack
     
     move $s0, $a0            # Load the address of the array into $s0
     move $s1, $a1            # Load the length of the array into $s1
     li $s2, 0                # Initialize a counter $s2

printLoop:
     # Load the element from the array into $s3
     lw $s3, 0($s0)
     
     # Print the element
     li $v0, 1                # Set $v0 to 1 for printing an integer
     move $a0, $s3            # Load the element to be printed into $a0
     syscall
     
     # Print a space or newline if necessary
     li $v0, 4                # Set $v0 to 4 for printing a string
     la $a0, space            # Load the address of a space character
     syscall

     # Increment the counter
     addi $s0, $s0, 4         # Point to the next element
     addi $s2, $s2, 1         # Increment the counter

     # Check for loop termination
     beq $s2, $s1, printExit  # Exit the loop when the counter reaches the array length
     j printLoop

printExit:
     # Function epilogue
     lw $s0, 0($sp)           # Restore $s0 from the stack
     lw $s1, 4($sp)           # Restore $s1 from the stack
     lw $s2, 8($sp)           # Restore $s2 from the stack
     lw $s3, 12($sp)          # Restore $s3 from the stack
     lw $ra, 16($sp)          # Restore $ra from the stack
     addi $sp, $sp, 20        # Restore the stack pointer
     jr $ra                   # Return to the calling routine

.data
A: .word 2, 4, 3, 1, 9, 7
space: .asciiz " "  # Define a space character as a null-terminated string
newline: .asciiz "\n"  # Define a newline character as a null-terminated string
