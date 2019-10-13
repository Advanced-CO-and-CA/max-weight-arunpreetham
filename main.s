


/******************************************************************************
* file: main.s
* author: Arunpreetham.
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/

/*
  This is the starter code for assignment 2
  */

  @ BSS section
      .bss

  @ DATA SECTION
      .data
data_start: 
        .word 0x205A15E3, 0x256C8700 
            @(0010 0000 0101 1010 0001 0101 1101 0011 – 13)
            @(0010 0101 0110 1100 1000 0111 0000 0000 – 11)
data_end: .word 0x295468F2 
            @(0010 1001 0101 0100 0110 1000 1111 0010 – 14)

@Output variables:
max_weight_no: .word 0x0 @variable to store the max weight number
weight: .word 0x0 @variable to store the max weight
            
/* 
Output: NUM     295468F2
        WEIGHT  14
*/
  @ TEXT section
      .text

.globl _main


_main:
    LDR r3, =data_start @ Get the address of the start of input array
    LDR r4, =data_end @ Get the address of the last element

    @r4 is a temp variable to store the last array element
    LDR r4, [r4] @obtain the value from the address location

    MOV r7, #0 @max weight
    MOV r1, #0 @reference 0 variable

loopB: @loop for all the elements of the array

    @r5 is a temp variable to store the current array element
    LDR r5, [r3] @obtain the value from the address location
    
    MOV r6, #0 @temp weight register

@ we use Brian Kernighan’s Algorithm to compute the weight
@ this loop will iterate till the number is greater than 0 where we do n & (n-1).
loop:
    MOV r9, r5 @ make a copy of the number
    SUB r5, r5, #1 @substract 1 from the number so we get n-1
    AND r5, r5, r9 @ now we do and ( n & (n-1) )
    ADD r6, r6, #1 @ now we add #1 to the temp weight variable

    @ CMP if > 0
    CMP r5, r1
        BGT loop

    @ Now the variable is 0, so we check the weight of it with the max weight and 
    @update the max if the current number has a greater weight
    CMP r6, r7
        BLT next @ Current number is not having the highest weight so go to next variable

    @ the number is greater so update the globals to store the current variable
    MOV r7, r6
    LDR r10, [r3]
    
    next: 

    @check and terminate if the current element is the end of array
    LDR r5, [r3]
    CMP r4, r5
        BEQ end

    @there are still elements in the array so update the address and continue to check 
    ADD r3, #4
    B loopB

    end:
    #update the memory
    LDR r8, =max_weight_no @storage for the number having maximum weight.
    STR r10, [r8]

    LDR r8, =weight @storage for the maximum weight.
    STR r7, [r8]
