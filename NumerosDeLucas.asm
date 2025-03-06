.data 
	Sms_0:.asciiz "Bienvenidos a Numeros de Lucas!!!\n"
	Sms_1:.asciiz "Digite la Cantidad a Generar: "
	Sms_2:.asciiz "Los primeros "
	Sms_3:.asciiz " Numeros de Lucas Son: "
	Sms_4:.asciiz "\n"
.text 
.globl main

main:
	li $v0, 4 #Imprimir Texto
	la $a0, Sms_0
	syscall
	
	li $v0, 4 #Imprimir Texto
	la $a0, Sms_1
	syscall
	
	li $v0, 5 #Leer um Numero Entero
	syscall
	move $t0, $v0
	
	li $t1, 2
	li $t2, 1
	li $t4, 1

	li $v0, 4 #Imprimir Texto
	la $a0, Sms_2 #Los Primeros
	syscall
	
	li $v0, 1
	move $a0, $t0 #Cant
	syscall
	
	li $v0, 4 #Imprimir Texto
	la $a0, Sms_3 # Numeros de Lucas Son:
	syscall
	
for:
	li $v0, 4 #Imprimir Texto
	la $a0, Sms_4 #Salto de Linea
	syscall
	
	add $t3, $t2, $t1
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	move $t1, $t2
	move $t2, $t3
 	
 	add $t4, $t4, 1
 	blt $t4, $t0, for