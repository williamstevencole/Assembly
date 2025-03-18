.data 
    Sms_1:.asciiz "Division de numeros reales!!!\n"
    Sms_2:.asciiz "\nIngrese el numerador en decimal: "
    Sms_3:.asciiz "\nIngrese el denominador en decimal: "
    Sms_4:.asciiz "\nEl resultado de la division de: "
    Sms_5:.asciiz " / "
    Sms_6:.asciiz " es: "

    Sms_7:.asciiz "Error en la division, no se puede dividir por 0"
.text
.globl main

main:

    li $v0, 4
    la $a0, Sms_1
    syscall

    li $v0, 4
    la $a0, Sms_2
    syscall

    #leer numeroador
    li $v0, 6
    syscall
    mov.s $f1, $f0

    li $v0, 4
    la $a0, Sms_3
    syscall

    #leer denominador
    li $v0, 6
    syscall
    mov.s $f2, $f0
    
    #division
    div.s $f3, $f1, $f2

    #imprimir resultado
    li $v0, 4
    la $a0, Sms_4
    syscall

    #imprimir numerador
    li $v0, 2
    mov.s $f12, $f1
    syscall
    
    li $v0, 4
    la $a0, Sms_5
    syscall

    #imprimir denominador
    li $v0, 2
    mov.s $f12, $f2
    syscall
   
    li $v0, 4
    la $a0, Sms_6
    syscall
    
    #imprimir resultado de la division
    li $v0, 2
    mov.s $f12, $f3
    syscall



