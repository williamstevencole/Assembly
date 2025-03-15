.data
Vector:   .space 40               
Sms_0:    .asciiz "Bienvenido a LOS CUBOS DE NICOMACO EN ARREGLO!!!\n"
Sms_1:    .asciiz "Digite la Cantidad de Cubos a Generar: "
Sms_:     .asciiz ", "
Sms_I:    .asciiz " = "
Sms_pow:  .asciiz "^3 = "
Sms_plus: .asciiz " + "
Sms_nl:   .asciiz "\n"

.text
.globl main

main:
    li  $t0, 0            # Inicializa contador de cubos
    la  $t1, Vector       # Puntero al arreglo

    li  $v0, 4
    la  $a0, Sms_0
    syscall               # Imprime mensaje de bienvenida

    li  $v0, 4
    la  $a0, Sms_1
    syscall               # Imprime solicitud de cantidad

    li  $v0, 5
    syscall               # Lee cantidad de cubos
    move $t2, $v0         # Guarda cantidad en $t2

    li  $t5, 1            # Inicializa primer impar (1)

for:
    bge  $t0, $t2, imprimir   # ya generó t2 cubos, imprimir
    bge  $t0, 1, general      # t0 >= 1, general
    beq  $t0, 0, casobase     # t0 == 0, caso base

casobase:
    li   $t8, 1            # n = 1
    
    li   $v0, 1
    move $a0, $t8
    syscall                # Imprime "1"

    li   $v0, 4
    la   $a0, Sms_pow
    syscall                # Imprime "^3 = "

    move $t3, $t5          # t3 = 1 (primer impar)
    addi $t5, $t5, 2       # Actualiza siguiente impar (pasa a 3)

    li   $v0, 1
    move $a0, $t3
    syscall                # Imprime "1"

    li   $v0, 4
    la   $a0, Sms_I
    syscall                # Imprime " = "

    li   $v0, 1
    move $a0, $t3
    syscall                # Imprime "1"

    li   $v0, 4
    la   $a0, Sms_nl
    syscall                # Imprime salto de línea

    sw   $t3, 0($t1)       # Guarda cubo en el arreglo
    addi $t1, $t1, 4
    addi $t0, $t0, 1       # Incrementa contador de cubos
    j    for

general:
    addi $t8, $t0, 1       # n = (t0 + 1)
    li   $v0, 1
    move $a0, $t8
    syscall                # Imprime n
    li   $v0, 4
    la   $a0, Sms_pow
    syscall                # Imprime "^3 = "
    li   $t6, 0            # Acumulador para suma de impares
    li   $t7, 0            # Contador de impares

sum_loop:
    bge  $t7, $t8, exit_sum  # Si sumados n impares, salir del loop
    bgt  $t7, $zero, print_plus  # Si no es el primer impar, imprimir " + "

print_impar:
    li   $v0, 1
    move $a0, $t5
    syscall                # Imprime el impar actual

    add  $t6, $t6, $t5     # Acumula el impar
    addi $t5, $t5, 2       # Actualiza al siguiente impar
    addi $t7, $t7, 1       # Incrementa contador de impares
    j    sum_loop

print_plus:
    li   $v0, 4
    la   $a0, Sms_plus
    syscall                # Imprime " + "
    j    print_impar

exit_sum:
    li   $v0, 4
    la   $a0, Sms_I
    syscall                # Imprime " = "
    li   $v0, 1
    move $a0, $t6
    syscall                # Imprime el resultado (cubo)
    li   $v0, 4
    la   $a0, Sms_nl
    syscall                # Imprime salto de línea
                   
    sw   $t6, 0($t1)       # Guarda cubo en el arreglo
    addi $t1, $t1, 4
    addi $t0, $t0, 1       # Incrementa contador de cubos
    j    for

imprimir:
    li   $t0, 0
    la   $t1, Vector
    move $t4, $zero

foreach:
    bge  $t0, $t2, fin
    lw   $t3, 0($t1)
    add  $t4, $t4, $t3     # Acumula suma total de cubos
    li   $v0, 1
    move $a0, $t3
    syscall                # Imprime cubo
    addi $t1, $t1, 4
    addi $t0, $t0, 1
    beq  $t0, $t2, foreach
    li   $v0, 4
    la   $a0, Sms_
    syscall                # Imprime ", "
    j    foreach

fin:
    li   $v0, 4
    la   $a0, Sms_I
    syscall                # Imprime " = "
    li   $v0, 1
    move $a0, $t4
    syscall                # Imprime suma total
    li   $v0, 10
    syscall                # Finaliza el programa
