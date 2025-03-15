.data 
    Vector:    .space 160
    Sms_0:     .asciiz "Bienvenido a fibonacci en arreglo"
    Sms_1:     .asciiz "Ingrese la cantidad de numeros de fibonacci que desea generar: "
    Sms_nl:    .asciiz "\n"
    Sms_coma:  .asciiz ", "
    Sms_resultado: .asciiz "Los numeros de fibonacci generados son: "
    Sms_suma:  .asciiz "La suma de los numeros generados es la siguiente: "
.text

.globl main

main:
    li $t0, 0
	la $t1, Vector

	li $v0, 4
	la $a0, Sms_0
	syscall

	li $v0, 4
	la $a0, Sms_nl
	syscall

	li $v0, 4
	la $a0, Sms_1
	syscall

	li $v0, 5
	syscall
	move $t2, $v0

	j fibonacci

	#Variables:
	# $t0: contador
	# $t1: direccion de memoria del vector
	# $t2: cantidad de numeros a generar

fibonacci:
	beq $t0, $t2, reset
	beq $t0, 0, base0
	beq $t0, 1, base1
	bge $t0, 2, induccion

base0:
	li $t3, 0
	sw $t3, 0($t1)

	add $t5, $t5, $t3

	addi $t1, $t1, 4
	add $t0, $t0, 1

	j fibonacci

base1:
	li $t3, 1
	sw $t3, 0($t1)

	add $t5, $t5, $t3

	addi $t1, $t1, 4
	add $t0, $t0, 1

	j fibonacci

induccion:
	subi $t1, $t1, 4
	lw $t3, 0($t1)

	subi $t1, $t1, 4
	lw $t4, 0($t1)

	add $t3, $t3, $t4

	addi $t1, $t1, 8
	sw $t3, 0($t1)

	add $t5, $t5, $t3

	addi $t1, $t1, 4
	add $t0, $t0, 1

	j fibonacci

reset:
	li $t0, 0
	la $t1, Vector

	li $v0, 4
	la $a0, Sms_nl
	syscall

	li $v0, 4
	la $a0, Sms_resultado
	syscall

	j imprimir

imprimir:
	

	lw $t3, 0($t1)

	li $v0, 1
	move $a0, $t3
	syscall

	addi $t1, $t1, 4
	add $t0, $t0, 1
	beq $t0, $t2, fin
	
	li $v0, 4
	la $a0, Sms_coma
	syscall

	j imprimir

fin:

	li $v0, 4
	la $a0, Sms_nl
	syscall

	li $v0, 4
	la $a0, Sms_suma
	syscall

	li $v0, 4
	la $a0, Sms_nl
	syscall

	li $v0, 1 
	move $a0, $t5
	syscall

	#salir del programa
	li $v0, 10
	syscall


