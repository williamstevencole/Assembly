.data
	Vector: .space 40 #10 int y un int pesa 4 bytes
	Length: .word 0 #Inicia
	Size: .word 10 #Cant
	
	Sms_0:.asciiz "Bienvenido a Arreglo de Fabrizio!!!\n"
	Sms_1:.asciiz "Digite la Cantidad: "
	Sms_2:.asciiz "Digite el Número de Entrada: "
	Sms_3:.asciiz "La Sumatoria de los Números de Entrada es: "
	Sms_:.asciiz ", "
	Sms_I:.asciiz " = "
.text 
.globl main

main:	
	#Inicializaciones
	li $t0,0 #Indice
	la $t1,Vector

	#Impresion de Mensaje de Bienvenida
	li $v0,4
	la $a0,Sms_0
	syscall
	
	#Lectura de Cantidad de Números
	li $v0,4
	la $a0,Sms_1
	syscall
	li $v0,5
	syscall
	move $t2,$v0# Cantidad de Elementos del Arreglo
	
	for:
		bge $t0,$t2,imprimir #if (t0>=t2) Imprimir para salir del Ciclo
		bge $t0,3,general
		
			li $t3,1
			sw $t3,0($t1) #Insertamos dentro del Arreglo
			addi $t1,$t1,4 #Nos desplazamos a la sig posición del Arreglo en 4 Bytes
			add $t0,$t0,1
		j for
		general:
			subi $t1,$t1,4
			lw $t3,0($t1)
			
			subi $t1,$t1,8
			lw $t4,0($t1)
			
			add $t3,$t3,$t4
			addi $t1,$t1,12
			
			sw $t3,0($t1) #Insertamos dentro del Arreglo
			addi $t1,$t1,4 #Nos desplazamos a la sig posición del Arreglo en 4 Bytes
			add $t0,$t0,1
		
		j for
		
	imprimir:
		#Inicializaciones
		li $t0,0 #Indice
		la $t1,	Vector
		move $t4,$zero
	foreach:
		bge $t0,$t2,fin
		lw  $t3,0($t1) #Insertamos dentro del Arreglo
		
		add $t4, $t4, $t3
		
		li $v0,1
		move $a0,$t3
		syscall
		
		addi $t1,$t1,4 #Nos desplazamos a la sig posición del Arreglo en 4 Bytes
		add $t0,$t0,1
		
		beq $t0,$t2,foreach
		
		li $v0,4
		la $a0,Sms_
		syscall
		
		j foreach
	fin:
		li $v0,4
		la $a0,Sms_I
		syscall
		li $v0,1
		move $a0,$t4
		syscall