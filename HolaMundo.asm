.data
	Sms_0:.asciiz "Bienvenido s aorganizacion de computadoras\n"
	Sms_1:.asciiz "Digite un Numero Entero\n"
	Sms_2:.asciiz "Digite otro numero entero\n"
	Sms_3:.asciiz "El resultado de: "
	Sms_4:.asciiz " + "
	Sms_5:.asciiz " es: "
	

.text
.globl main

main:
	#li $v0, 1 -> imrpime int
	#li $v0, 2 -> imrpime float
	#li $v0, 3 -> imrpime double
	#li $v0, 4 -> imrpime string

	#li $v0, 5 -> lee int
	#li $v0, 6 -> lee float
	#li $v0, 7 -> lee double
	#li $v0, 8 -> lee string


	#move $a0, $tn -> se pasa como 'argumento de la funcion de print el numero que se quiere imprimir' 
	
	
	
	

	#BIenvenido a organizacion de computadoras
   	li $v0, 4 #imprimir texto
   	la $a0, Sms_0
   	syscall
   	
   	li $v0, 4 #Imprimir texto
   	la $a0, Sms_1
   	syscall
   	
   	li $v0, 5
   	syscall 
   	move $t0,$v0
   	
   	li $v0, 4 #Imprimir texto
   	la $a0, Sms_2
   	syscall
   	
   	li $v0, 5
   	syscall 
   	move $t1,$v0
   	
   	
   	
   	#El resultado de n1 + n2:
   	li $v0, 4 #Imprimir texto
   	la $a0, Sms_3
   	syscall
   	
   	#Imprime numero 1
   	li $v0, 1
   	move $a0, $t0
   	syscall
   	
   	li $v0, 4 #Imprimir texto
   	la $a0, Sms_4
   	syscall
   	
   	#Imprime numero 2
   	li $v0, 1
   	move $a0, $t1
   	syscall
   	
   	li $v0, 4 #Imprimir texto
   	la $a0, Sms_5
   	syscall
   	
   	
   	
   	#sumar numeros y agregar
   	add $t2,$t1,$t0
   	
   	li $v0, 4 #Imprimir texto
   	la $a0, Sms_5
   	syscall
   	
   	li $v0, 1
   	move $a0, $t2
   	syscall
   	
	
	
   	
   	
   	
   	
   	
   	
   	
   	
   	