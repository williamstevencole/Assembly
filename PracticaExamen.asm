.data
	
	Vector:.space 40 #Espacio para un arreglo de 10 numeros

	Sms_0:.asciiz "Bienvenido a mi practica de examen!!!\nEn este programa intentare hacer fibonacci, numeros de lucas y numeros primos"
	Sms_Menu:.asciiz "\nBienvenido al menu!!! \n1)Fibonacci\n2)Numeros de Lucas\n3)numeros primos\n4)Salir\nIngrese la opcion deseada: "
	Sms_Error:.asciiz "Ingreso una opcion  no valida!!! Intente de nuevo\n\n"
	
	Sms_Div:.asciiz "================================================================"
	
	Sms_Fibo:.asciiz "Ingrese la cantidad de numeros de fibonacci uqe desea generar!: "
.text
.globl main

main:

	#Inicializaciones
	la $t0, Vector #inicializar vector
	li $t1, 0  #inicializar contador del arreglo
	
	li $v0, 4
	la $a0, Sms_0
	syscall
	
	li $v0, 4
	la $a0, Sms_Menu
	syscall
	
	li $v0, 5
	syscall
	move $t2, $v0
	
	beq $t0, 1, fibo
	beq $t0, 2, fibo
	beq $t0, 3, fibo
	beq $t0, 4, salir
	
	jal OpcionEquivocada
	
fibo:
	li $v0, 4
	la $a0, Sms_Fibo
	syscall
	
	li $v0, 5
	syscall
	move $t2, $v0
	
	li $v0, 4
	la $a0, Sms_Fibo
	syscall
	

salir:
	li $v0, 10
	syscall


OpcionEquivocada:
	li $v0, 4
	la $a0, Sms_Error
	syscall
	
	li $v0, 4
	la $a0, Sms_Div
	syscall
	
	jr $ra
	
	
	
