#Manejo de division cero
.data
	msgPedirNumerador: .asciiz "- Digite el numerador: "
	msgPedirDenominador: .asciiz "- Digite el demominador: "
	msgMostrarCociente: .asciiz "\nEl cociente entero es: "
	msgMostrarResiduo: .asciiz "\nEl residuo es: "
	msgErrorDivisionCero: .asciiz "\nAVISO: NO SE PUEDE DIVIDIR ENTRE CERO\n\n"
.text
.globl main
main:
	li $v0, 4       
    	la $a0, msgPedirNumerador  
    	syscall
    	li $v0, 5       # Leer byneradir
    	syscall
    	move $t0, $v0   
    	# $t0 = numerador
    	
    	li $v0, 4       
    	la $a0, msgPedirDenominador
    	syscall
    	li $v0, 5       # Leer byneradir
    	syscall
    	move $t1, $v0   # $t0 = denominador
    	
    	# Manejo de casos
    	beq $t1, 0, errorDivisionCero
    	 
    	# Proceso de sacar modulo
    	div $t2, $t0, $t1
    	j mostrarResultado
    	
mostrarResultado:
    	# Mostrar cociente
    	li $v0, 4       
    	la $a0, msgMostrarCociente
    	syscall
    		
    	li $v0, 1     
    	move $a0, $t2
    	syscall
    	
    	# Calcular Residuo
    	mul $t2, $t2, $t1
    	sub $t0, $t0, $t2
    	
    	# Mostrar residuo
    	li $v0, 4       
    	la $a0, msgMostrarResiduo
    	syscall
    	
    	li $v0, 1     
    	move $a0, $t0
    	syscall
    		
# No se puede dividir entre cero, devuelve a main
errorDivisionCero:
    	li $v0, 4       
    	la $a0, msgErrorDivisionCero
    	syscall
    	j main
    		
    	li $v0, 10
    	syscall