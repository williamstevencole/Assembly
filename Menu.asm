.data
	Vector: .space 40

	#Mensajes generales
	Sms_0:.asciiz "Bienvenido al menu!!!\n"
	Sms_Menu:.asciiz "\n 1) Fibonacci\n 2) Cubos de Nicomaco\n 3) Sucesion de potencia\n 4) Salir \nIngrese una opcion: "
	Sms_Dash:.asciiz "\n\n========================================================================================================================================================\n"
	Sms_Comma:.asciiz " + "
	Sms_I:.asciiz " = "

	#Fibonacci
	Sms_FiboCantidad:.asciiz "\nIngrese la cantidad de numeros de fibonacci que desea generar: "
  	Sms_Fibo:.asciiz "\nLos numeros de fibonacci generados son los siguientes: "
	Sms_sumaFibo:.asciiz "\nLa suma de los numeros generados es la siguiente: "

	#Nicomaco
	Sms_NicoCantidad:.asciiz "\nIngrese la cantidad de cubos de Nicomaco que desea generar: "
	Sms_Nico:.asciiz "\nLos cubos de Nicomaco generados son los siguientes: "
	Sms_sumaNico:.asciiz "\nLa suma de los cubos generados es la siguiente: "
	Sms_Cubo:.asciiz "^3 = "
	Sms_nl:.asciiz "\n"

	#4*2^(-n)

	#Opciones
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

	#Acceso rapido a diferentes opciones en el menu
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
opcion2:
    li   $v0, 4 
    la   $a0, Sms_NicoCantidad
    syscall

    li   $v0, 5
    syscall
    move $t2, $v0           # t2 = cantidad de cubos a generar

    # Inicializar:
    li   $t0, 1            # t0 = contador global de cubos; primer cubo es n=1
    la   $t1, Vector       # t1 = puntero al arreglo
	li   $t3, 1            # t3 = suma de cubos
	li   $t4, 0            # t4 = contador de numeros sumados por cada uno de los cubos
    li   $t5, 1            # t5 = primer impar (1)
	li   $t6, 0            # t6 = suma de los cubos generados

	j Nicomaco


#Variables
#t0: Numero de elementos en arreglo
#t1: Vector
#t2: CAntidad de elementos pedido por usuario
#t3: Sumas
#t4: contador de numeros sumados por cada uno de los cubos
#t5: NUmeros impares (Se suman de dos en dos)

#t6: Suma de los cubos generados para imprimirlos posteriormente

Nicomaco:
	# Generar cubo de Nicomaco
	bgt $t0, $t2, NicomacoImprimir
	j NicoNextNumber

#Setear variables para siguiente cubo
NicoNextNumber:
	li $t3, 0
	li $t4, 0

	#Imprimir new line
	li $v0, 4
	la $a0, Sms_nl
	syscall

	#IMprimri el cubo actual
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 4
	la $a0, Sms_Cubo
	syscall

	j NicoSuma


#Sumar t3 y t5 hasta que t4 sea mayor que t0
NicoSuma:
	beq $t4, $t0, NicoAppend #Cuando la cantidad de cubos es igual a la pedida por usuario se vuelve a Nicomaco
	

	#Se hace la suma
	add $t3, $t3, $t5

	#Imprimir el numero a sumar
	li $v0, 1
	move $a0, $t5
	syscall

		
	add $t4, $t4, 1
	add $t5, $t5, 2

	#Cuando la cantidad de cubos es igual a la pedida por usuario se vuelve a Nicomaco
	beq $t4, $t0, NicoAppend 

	#Imprimir el signo de suma
	li $v0, 4
	la $a0, Sms_Comma
	syscall

	j NicoSuma


#Cuando t4 sea igual a t0, guardar el cubo en el arreglo
#y volver a Nicomaco
NicoAppend:
	# IMprimir =
	li $v0, 4
	la $a0, Sms_I
	syscall

	#Imprimir t3 
	li $v0, 1
	move $a0, $t3
	syscall

	add $t6, $t6, $t3

	#Guardar el cubo en el arreglo
	sw $t3, 0($t1)
	addi $t1, $t1, 4
	add $t0, $t0, 1

	li $t4, 0

	j Nicomaco

#Imprimir los cubos generados
NicomacoImprimir:
	#Reiniciar las variables para imprimir
	li $t0, 0
	la $t1, Vector

	#imprimir salto de linea:
	li $v0, 4
	la $a0, Sms_nl
	syscall

	li $v0, 4
	la $a0, Sms_Nico
	syscall

	j NicoFor


NicoFor:
	#Cuando t0 sea igual a t2, salir del ciclo
	bge $t0, $t2, NicoFin

	#Imprimir el numero
	lw $t3, 0($t1)

	#Sumar el numero al total
	add $t4, $t4, $t3

	li $v0, 1
	move $a0, $t3
	syscall

	addi $t1, $t1, 4
	addi $t0, $t0, 1

	beq $t0, $t2, NicoFor

	li $v0, 4
	la $a0, Sms_Comma
	syscall

	j NicoFor
	
NicoFin:
	li $v0, 4
	la $a0, Sms_sumaNico
	syscall

	li $v0, 1
	move $a0, $t6
	syscall

	j main




#================================================================================================================================================================
opcion3:
	li $v0, 4
	la $a0, Sms_Op3
	syscall                   # Imprime "Esta es opcion 3"
	j main



#================================================================================================================================================================
salir:
    li $v0, 4
    la $a0, Sms_Op4         # Usamos Sms_Op3 para "Esta es opcion 3" (o puedes agregar otro mensaje para salir)
    syscall

    li $v0, 10              # Finaliza el programa
    syscall