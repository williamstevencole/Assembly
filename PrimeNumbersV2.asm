.data

	Vector:.space 400
	ten:.float 10.0
	
	Sms_0:.asciiz "Bienvenido al programa de numeros primos!\nEste es un programa para practicar previo a mi examen de Organizacion de Computadoras\n\n Ingrese la cantidad de numeros primos que desea calcular: "
	Comma:.asciiz ", "
	NewLine:.asciiz "\n"
	
	End:.asciiz "\n\nCon esto me considero listo para mi examen con codigo de Assembly a mano :D"
.text

.globl main

main:

	#Inicializaciones
	la $t0, Vector
	li $t1, 0
	
	li $s0, 0 #Cantidad de numeros primos encontrados
	li $t3, 2 #Primer numero primo a evaluar
	li $t4, 2 #Divisor del numero primo
	li $t5, 1 #Bandera de si es primo o no
	
	
	li $v0, 4
	la $a0, Sms_0
	syscall
	
	li $v0, 5
	syscall
	move $t2, $v0 #Cantidad de numeros
	
	j loopPrimos
	
	
loopPrimos:
	li $t5, 1 #Se asume que es primo siempre para cada candidato
	li $t4, 2 #El primer divisor siempre sera 2
	
	#Si el contador s0 ya alcanzo la cantidad ingresada, se imprime el arreglo.
	bge $s0, $t2, printPrimos
	
	j divLoop

divLoop:
	#Se verifica si el divisor ya es igual que el candidato a numeroPrimo
	bge $t4, $t3, verificarPrimo
	
	#hacer proceso de division
	div $t3, $t4
	mfhi $t6
	beq $t6, $zero, noEsPrimo
	
	add $t4, $t4, 1 
	j divLoop
	

noEsPrimo:
	#Este numero no es un numero primo
	li $t5, 0 
	
	#Se pasa con el siguiente candidato y se vuelve al loop
	add $t3, $t3, 1 
	j loopPrimos
		

verificarPrimo:
	
	sw $t3, 0($t0)
	addi $t0, $t0, 4
	add $t1, $t1, 1
	
	add $t3, $t3, 1 
	
	add $s0, $s0, 1
			
	j loopPrimos
		
	
printPrimos:
	la $t0, Vector
	li $t1, 0 #Contador del arreglo
	
	li $s2, 0 
	
	j printLoop

printLoop:
	lw $t6, 0($t0)
	
	#Se imprime el numeor primo
	li $v0, 1 
	move $a0, $t6
	syscall
	
	addi $t0, $t0, 4
	add $t1, $t1, 1
	
	add $s2, $s2, 1
	
	beq $s2, $t2, printDiv
	
	li $v0, 4 
	la $a0, Comma
	syscall
	
	j printLoop
	
printDiv:

	li $v0, 4
	la $a0, NewLine
	syscall
	
	la $t0, Vector
	li $t1, 0 #Contador del arreglo
	
	l.s $f2, ten
	
	li $s2, 0 
	
	j printDivLoop
	
printDivLoop:
	lw $t6, 0($t0)
	mtc1 $t6, $f1
	cvt.s.w $f1, $f1
	
	div.s $f1, $f1, $f2
	
	li $v0, 2
	mov.s $f12, $f1
	syscall
	
	addi $t0, $t0, 4
	add $t1, $t1, 1
	
	add $s2, $s2, 1
	
	beq $s2, $t2, end
	
	li $v0, 4 
	la $a0, Comma
	syscall
	
	j printDivLoop
	
	
	
end: 

	li $v0, 4
	la $a0, End
	syscall
	
	
	li $v0, 10
	syscall
	
	
	
	

	
	
	
	
	
	
	
	
	
	
