.data 
    Sms_0: .asciiz "Bienvenidos a las Vacas de Narayana!!!\n"
    Sms_1: .asciiz "Digite la Cantidad a Generar: "
    Sms_2: .asciiz "Los primeros "
    Sms_3: .asciiz " valores de las Vacas de Narayana son: "
    Sms_4: .asciiz "\n"
.text 
.globl main

main:
    # Imprimir mensajes iniciales
    li $v0, 4       
    la $a0, Sms_0  
    syscall

    li $v0, 4       
    la $a0, Sms_1  
    syscall

    li $v0, 5       # Leer cantidad
    syscall
    move $t0, $v0   # $t0 = cantidad de términos a generar

    li $v0, 4       
    la $a0, Sms_2  
    syscall

    li $v0, 1       
    move $a0, $t0 
    syscall

    li $v0, 4       
    la $a0, Sms_3  
    syscall

    # Inicializar la secuencia: v(1)=v(2)=v(3)=1  
    li $t1, 1   
    li $t2, 1   
    li $t3, 1   
    li $t4, 0   # Contador

for:
    li $v0, 4       # Imprimir salto de línea
    la $a0, Sms_4  
    syscall

    li $v0, 1       # v(n-3)
    move $a0, $t1  
    syscall

    # nuevo = v(n-1) + v(n-3)
    add $t5, $t3, $t1

    # Actualizar los registros:
    move $t1, $t2  # v(n-3) <- v(n-2)
    move $t2, $t3  # v(n-2) <- v(n-1)
    move $t3, $t5  # v(n-1) <- nuevo

    addi $t4, $t4, 1
    blt $t4, $t0, for

    li $v0, 10     # Terminar el programa
    syscall
