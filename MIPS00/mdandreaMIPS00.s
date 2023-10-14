# Tell assembler to not insert instructions to fill branch delay slots.
# This is necessary when branch delay slots are disabled.
.set noreorder

# this is what we need to do
#  int A[] = {1,2,3,4};
#  int B[] = {5,6,7,8};
#  int C[4];
#  int i; int dp = 0;
#  for(i=0; i<4; i++) {
#    C[i]=A[i]+B[i];
#    
#  } 
.data
A: .word 1,2,3,4
B: .word 5,6,7,8
C: .space 16

.text
.global _start
_start:

# use t0 as the base address of A
la $t0, A
# use t1 as the base address of B
la $t1, B
# use t2 as the base address of C
la $t2, C

# initialize any variables you need here
li $t3, 0 #int i = 0;
# outside of the looop

FOR:    # write a loop here
    bge $t3, 4, END

    mul $t4, $t3, 4
    add $t4, $t4, $t0

    lw $t5, 0($t4)

    mul $t4, $t3, 4
    add $t4, $t4, $t1

    lw $t6, 0($t4)

    add $t7, $t5, $t6

    mul $t4, $t3, 4
    add $t4, $t4, $t2

    sw $t7, 0($t4)

    # Increment 'i' after each iteration
    addi $t3, $t3, 1

    j FOR

# end the program 
END:
	j END



