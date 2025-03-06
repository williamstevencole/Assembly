.data
    promptA:   .asciiz "Digite el numero a: "
    promptB:   .asciiz "Digite el numero b: "
    promptC:   .asciiz "Digite el numero c: "
    promptD:   .asciiz "Digite el numero d: "
    plusStr:   .asciiz " + "
    midStr:    .asciiz ") - ("
    equalStr:  .asciiz ") = "
    newline:   .asciiz "\n"

.text
.globl main

main:
    # (a)
    li $v0, 4           
    la $a0, promptA
    syscall

    li $v0, 5          
    syscall
    move $t0, $v0       

    # (b)
    li $v0, 4
    la $a0, promptB
    syscall

    li $v0, 5
    syscall
    move $t1, $v0       

    # (c)
    li $v0, 4
    la $a0, promptC
    syscall

    li $v0, 5
    syscall
    move $t2, $v0       

    # (d)
    li $v0, 4
    la $a0, promptD
    syscall

    li $v0, 5
    syscall
    move $t3, $v0      

    # (a + b)
    add $t4, $t0, $t1   
    # (c + d)
    add $t5, $t2, $t3   
    # (a+b) - (c+d)
    sub $t6, $t4, $t5   






    # "(a + b) - (c + d) = e"
    
    # (
    li $v0, 11         
    li $a0, 40          
    syscall

    # a
    li $v0, 1          
    move $a0, $t0
    syscall

    # + 
    li $v0, 4
    la $a0, plusStr
    syscall

    # b
    li $v0, 1
    move $a0, $t1
    syscall

    # ") - ("
    li $v0, 4
    la $a0, midStr
    syscall

    # c
    li $v0, 1
    move $a0, $t2
    syscall

    # +
    li $v0, 4
    la $a0, plusStr
    syscall

    # d
    li $v0, 1
    move $a0, $t3
    syscall

    # =
    li $v0, 4
    la $a0, equalStr
    syscall

    # e
    li $v0, 1
    move $a0, $t6
    syscall
