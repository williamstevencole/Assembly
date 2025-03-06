.data

	Sms_1:.asciiz "Programa de practica\n Ingrese la cantidad de fibonacci que desea calcular: "
	Sms_2:.asciiz "El fibonacci de: "
	Sms_3:.asciiz " es: \n" 
	Sms_4:.asciiz "\n"
.text
.globl main

main:
	li $v0, 4	#Mensaje de bienvenida"
	la $a0, Sms_1
	syscall
	
	li $v0, 5	#Pide cant"
	syscall
	move $t0, $v0
	
	li $v0, 4	#El fibonacci de: "
	la $a0, Sms_2
	syscall
	
	li $v0, 1	#Imprime cant"
	move $a0, $t0
	syscall
	
	li $v0, 4	#es: "
	la $a0, Sms_3
	syscall

	#inicializa f1=0, f2=1
	li $t1, 0	
	li $t2, 1
	
	#inicializa i = 1
	li $t4, 0 

for:
	li $v0, 4
	la $a0, Sms_4
	syscall
	
	li $v0, 1	
	move $a0, $t1	#imprime fn-2
	syscall
	
	add $t3, $t2, $t1	#fn = fn-1 + fn-2
	
	move $t1, $t2	#fn2 = fn1
	move $t2, $t3	#fn1 = fn
	
	addi $t4, $t4, 1	#i++
	blt $t4, $t0, for	#recursividad
			
	
	
	
	
	
	
	
	