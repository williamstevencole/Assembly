.data
    Sms1:   .asciiz "Digite el primer numero (a): "
    Sms2:   .asciiz "Digite el segundo numero (b): "
    Sms3:   .asciiz "Digite el tercer numero (c): "
    Sms4:   .asciiz "Digite el cuarto numero (d): "
    Sms5:   .asciiz "Digite el quinto numero (e): "
    mas:   .asciiz " + "
    menos:  .asciiz " - "
    igual:     .asciiz " = "
    newline:   .asciiz "\n"
.text
.globl main

main:
    # Solicitar a
    li $v0, 4
    la $a0, Sms1
    syscall

    li $v0, 5
    syscall
    move $t0, $v0       # a -> $t0

    # Solicitar b
    li $v0, 4
    la $a0, Sms2
    syscall

    li $v0, 5
    syscall
    move $t1, $v0       # b -> $t1

    # Solicitar c
    li $v0, 4
    la $a0, Sms3
    syscall

    li $v0, 5
    syscall
    move $t2, $v0       # c -> $t2

    # Solicitar d
    li $v0, 4
    la $a0, Sms4
    syscall

    li $v0, 5
    syscall
    move $t3, $v0       # d -> $t3

    # Solicitar e
    li $v0, 4
    la $a0, Sms5
    syscall

    li $v0, 5
    syscall
    move $t4, $v0       # e -> $t4

    # Calcular (a + b)
    add $t5, $t0, $t1   # t5 = a + b

    # Calcular (c + e)
    add $t6, $t2, $t4   # t6 = c + e

    # Calcular resultado: d - (a+b) - (c+e)
    sub $t7, $t3, $t5   # t7 = d - (a+b)
    sub $t7, $t7, $t6   # t7 = t7 - (c+e)








    # 40: ASCII de '('



    # Imprine (d - (a + b) - (c + e)) = resultado

    # Imprimir "("
    li $v0, 11
    li $a0, 40         
    syscall

    # Imprimir d
    li $v0, 1
    move $a0, $t3
    syscall


    # Imprimir " - ("
    li $v0, 4
    la $a0, menos  
    
    syscall
    li $v0, 11
    li $a0, 40         
    syscall

    # Imprimir a
    li $v0, 1
    move $a0, $t0
    syscall

    # Imprimir " + "
    li $v0, 4
    la $a0, mas
    syscall

    # Imprimir b
    li $v0, 1
    move $a0, $t1
    syscall

    # Imprimir ") - ("
    li $v0, 11
    li $a0, 41         
    syscall
    li $v0, 4
    la $a0, menos   
    syscall
    li $v0, 11
    li $a0, 40         
    syscall

    # Imprimir c
    li $v0, 1
    move $a0, $t2
    syscall

    # Imprimir " + "
    li $v0, 4
    la $a0, mas
    syscall

    # Imprimir e
    li $v0, 1
    move $a0, $t4
    syscall

    # Imprimir "))"
    li $v0, 11
    li $a0, 41         
    syscall
    li $v0, 11
    li $a0, 41        
    syscall

    # Imprimir " = "
    li $v0, 4
    la $a0, igual
    syscall

    # Imprimir el resultado
    li $v0, 1
    move $a0, $t7
    syscall



    # Salir del programa
    li $v0, 10
    syscall
