.data
    promptA: .asciiz "Digite el primer numero (a): "
    promptB: .asciiz "Digite el segundo numero (b): "
    promptC: .asciiz "Digite el tercer numero (c): "
    promptD: .asciiz "Digite el cuarto numero (d): "
    promptE: .asciiz "Digite el quinto numero (e): "
    eqStr:   .asciiz " = "
    newline: .asciiz "\n"

.text
.globl main

main:
    # Solicitar el número a
    li $v0, 4
    la $a0, promptA
    syscall

    li $v0, 5
    syscall
    move $t0, $v0         # a en $t0

    # Solicitar el número b
    li $v0, 4
    la $a0, promptB
    syscall

    li $v0, 5
    syscall
    move $t1, $v0         # b en $t1

    # Solicitar el número c
    li $v0, 4
    la $a0, promptC
    syscall

    li $v0, 5
    syscall
    move $t2, $v0         # c en $t2

    # Solicitar el número d
    li $v0, 4
    la $a0, promptD
    syscall

    li $v0, 5
    syscall
    move $t3, $v0         # d en $t3

    # Solicitar el número e
    li $v0, 4
    la $a0, promptE
    syscall

    li $v0, 5
    syscall
    move $t4, $v0         # e en $t4

    # Calcular (b + c) => $t5 = b + c
    add $t5, $t1, $t2

    # Calcular a + (b + c) => $t6 = a + t5
    add $t6, $t0, $t5

    # Calcular (d - e) => $t7 = d - e
    sub $t7, $t3, $t4

    # Calcular resultado: (a + (b + c)) - (d - e)
    sub $t8, $t6, $t7

    # Imprimir la expresión: (a+(b+c)-(d-e)) = resultado

    # Imprimir "("
    li $v0, 11
    li $a0, 40          # ASCII de '('
    syscall

    # Imprimir a
    li $v0, 1
    move $a0, $t0
    syscall

    # Imprimir "+"
    li $v0, 11
    li $a0, 43          # ASCII de '+'
    syscall

    # Imprimir "("
    li $v0, 11
    li $a0, 40          # '('
    syscall

    # Imprimir b
    li $v0, 1
    move $a0, $t1
    syscall

    # Imprimir "+"
    li $v0, 11
    li $a0, 43          # '+'
    syscall

    # Imprimir c
    li $v0, 1
    move $a0, $t2
    syscall

    # Imprimir ")"
    li $v0, 11
    li $a0, 41          # ASCII de ')'
    syscall

    # Imprimir "-"
    li $v0, 11
    li $a0, 45          # ASCII de '-'
    syscall

    # Imprimir "("
    li $v0, 11
    li $a0, 40          # '('
    syscall

    # Imprimir d
    li $v0, 1
    move $a0, $t3
    syscall

    # Imprimir "-"
    li $v0, 11
    li $a0, 45          # '-'
    syscall

    # Imprimir e
    li $v0, 1
    move $a0, $t4
    syscall

    # Imprimir ")"
    li $v0, 11
    li $a0, 41          # ')'
    syscall

    # Imprimir ")" final
    li $v0, 11
    li $a0, 41          # ')'
    syscall

    # Imprimir " = "
    li $v0, 4
    la $a0, eqStr
    syscall

    # Imprimir el resultado
    li $v0, 1
    move $a0, $t8
    syscall

    # Imprimir salto de línea
    li $v0, 4
    la $a0, newline
    syscall

    # Salir del programa
    li $v0, 10
    syscall
