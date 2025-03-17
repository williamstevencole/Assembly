.data
	Vector: .space 40


	Sms_0:.asciiz "Bienvenido al menu!!!\n"
	Sms_Menu:.asciiz "\n 1) Fibonacci\n 2) Cubos de Nicomaco\n 3) Sucesion de potencia\n 4) Salir \nIngrese una opcion: "
	Sms_Dash:.asciiz "\n\n========================================================================================================================================================\n"
	Sms_Comma:.asciiz " + "
	Sms_I:.asciiz " = "

	Sms_FiboCantidad:.asciiz "\nIngrese la cantidad de numeros de fibonacci que desea generar: "
  	Sms_Fibo:.asciiz "\nLos numeros de fibonacci generados son los siguientes: "
	Sms_sumaFibo:.asciiz "\nLa suma de los numeros generados es la siguiente: "

	Sms_NicoCantidad:.asciiz "\nIngrese la cantidad de cubos de Nicomaco que desea generar: "
	Sms_Nico:.asciiz "\nLos cubos de Nicomaco generados son los siguientes: "
	Sms_sumaNico:.asciiz "\nLa suma de los cubos generados es la siguiente: "
	Sms_Cubo:.asciiz "^3 = "

	Sms_Op1:.asciiz "\nEsta es opcion 1\n"
	Sms_Op2:.asciiz "\nEsta es opcion 2\n"
	Sms_Op3:.asciiz "\nEsta es opcion 3\n"
	Sms_Op4:.asciiz "\nEsta es opcion 4\n"
.text
.globl main

main:
	#inicializaciones de variables
	li $t0, 0
	la $t1, Vector

	li $v0, 4
	la $a0, Sms_Dash
	syscall

	li $v0, 4
	la $a0, Sms_0
	syscall

	li $v0, 4
	la $a0, Sms_Menu
	syscall

	li $v0,5
	syscall
	move $t0,$v0

	beq $t0, 1, opcion1
	beq $t0, 2, opcion2
	beq $t0, 3, opcion3
	beq $t0, 4, salir

	j main


#================================================================================================================================================================
#Opcion 1: Fibonacci
opcion1:
	li $t0, 0
	la $t1, Vector

	li $v0, 4
	la $a0, Sms_FiboCantidad
	syscall

	li $v0, 5
	syscall
	move $t2, $v0

	j fibonacci

fibonacci:
	beq $t0, $t2, fiboImprimir
	beq $t0, 0, fiboBase0
	beq $t0, 1, fiboBase1
	bge $t0, 2, fiboInduccion

fiboBase0:
	li $t3, 0
	sw $t3, 0($t1)

	addi $t1, $t1, 4
	add $t0, $t0, 1

	j fibonacci

fiboBase1:
	li $t3, 1
	sw $t3, 0($t1)

	addi $t1, $t1, 4
	add $t0, $t0, 1

	j fibonacci

fiboInduccion:
	subi $t1, $t1, 4
	lw $t3, 0($t1)

	subi $t1, $t1, 4
	lw $t4, 0($t1)

	add $t3, $t3, $t4

	addi $t1, $t1, 8
	sw $t3, 0($t1)

	addi $t1, $t1, 4
	add $t0, $t0, 1

	j fibonacci

fiboImprimir:
	li $t0, 0
	la $t1, Vector
	move $t4, $zero
	move $t3, $zero

	li $v0, 4
	la $a0, Sms_Fibo
	syscall

	j fiboFor

fiboFor:
	bge $t0, $t2, fiboFin

	lw $t3, 0($t1)
	add $t4, $t4, $t3

	li $v0, 1
	move $a0, $t3
	syscall

	addi $t1, $t1, 4
	addi $t0, $t0, 1

	beq $t0, $t2, fiboFor
	li $v0, 4
	la $a0, Sms_Comma
	syscall

	j fiboFor

fiboFin:
	li $v0, 4
	la $a0, Sms_sumaFibo
	syscall

	li $v0, 1
	move $a0, $t4
	syscall

	j main





#================================================================================================================================================================
#Opcion 2: Cubos de Nicomaco

#VARIABLES A UTIlIZAR:
#t0: contador de cubos
#t1: direccion de memoria
#t2: cantidad de cubos a generar


#t3: sumar numeros
#t4: contador interno de numeros a sumar para cada cubo
#t5: numeros impares

#proceso a seguir:
# t2 es la cantidad a generar, si t4 es igual a t2, se imprime la suma de los cubos
# si t4 es menor a t2, se sigue sumando los cubos

#El proceso de los cubos sera el siguiente:
#Para cada t4, digamos para t4=1 solo se sumara t5=1, despues se sumara t5=t5+2 
#y se pasara al siguiente cubo, sumando a t4++ y t0++

#PAra el sigueinte, ya tendremos que t4 sera igual a 2, y se sumara t5, y  despues t5=5, y asi sucesivamente

opcion2:

	li $t4, 1
	li $t5, 1

    li $v0, 4
	la $a0, Sms_NicoCantidad
	syscall

	li $v0, 5
	syscall
	move $t2, $v0

	j nico


#================================================================================================================================================================
opcion3:
	li $v0, 4
	la $a0, Sms_Op3
	syscall                   # Imprime "Esta es opcion 3"
	j main

salir:
    li $v0, 4
    la $a0, Sms_Op4         # Usamos Sms_Op3 para "Esta es opcion 3" (o puedes agregar otro mensaje para salir)
    syscall

    li $v0, 10              # Finaliza el programa
    syscall
