############################################################
# SECCIÓN DE DATOS
############################################################
.data
	Vector: .space 40            # Reserva 40 bytes (10 enteros de 4 bytes cada uno)
	Length: .word 0              # No se utiliza directamente en este ejemplo
	Size:   .word 10             # No se utiliza directamente en este ejemplo
	
	Sms_0: .asciiz "Bienvenido a NUMEROS DE LUCAS EN ARREGLO!!!\n"
	Sms_1: .asciiz "Digite la Cantidad: "
	Sms_2: .asciiz "Digite el Número de Entrada: "
	Sms_3: .asciiz "La Sumatoria de los Números de Entrada es: "
	Sms_:  .asciiz ", "
	Sms_I: .asciiz " = "

############################################################
# SECCIÓN DE CÓDIGO
############################################################
.text 
.globl main

############################################################
# main
# Lee la cantidad de elementos a generar, llena el arreglo
# con la sucesión de Lucas y luego los imprime.
############################################################
main:
	li $t0,0                  # $t0 = índice del arreglo (inicializado en 0)
	la $t1,Vector             # $t1 apunta al inicio del arreglo

	li $v0,4                  # Código de syscall para imprimir cadena
	la $a0,Sms_0              # Imprimir mensaje de bienvenida
	syscall
	
	li $v0,4
	la $a0,Sms_1              # Solicita la cantidad al usuario
	syscall

	li $v0,5                  # Leer entero desde consola
	syscall
	move $t2,$v0              # $t2 = cantidad de elementos solicitados

############################################################
# for
# Llena el arreglo con los Números de Lucas:
#  - L(0) = 2
#  - L(1) = 1
#  - L(n) = L(n-1) + L(n-2) para n >= 2
############################################################
for:
	bge $t0,$t2,imprimir      # Si t0 >= t2, salta a imprimir
	bge $t0,2,general         # Si t0 >= 2, salta a la parte general de cálculo

	beq $t0,0,base0          # Si t0 == 0, salta a base0 (L(0)=2)

	# Caso t0 == 1
	li $t3,1                 # L(1) = 1
	sw $t3,0($t1)            # Almacena en la posición actual del arreglo
	addi $t1,$t1,4           # Avanza 4 bytes (siguiente posición)
	add $t0,$t0,1            # Incrementa índice
	j for                    # Repite

############################################################
# base0
# Caso base para t0 == 0
############################################################
base0:
	li $t3,2                 # L(0) = 2
	sw $t3,0($t1)            # Almacena en la posición actual del arreglo
	addi $t1,$t1,4           # Avanza 4 bytes
	add $t0,$t0,1            # Incrementa índice
	j for                    # Repite

############################################################
# general
# Cálculo de L(n) = L(n-1) + L(n-2) para n >= 2
############################################################
general:
	subi $t1,$t1,4           # Retrocede 4 bytes para apuntar a L(n-1)
	lw $t3,0($t1)            # Carga L(n-1) en $t3

	subi $t1,$t1,4           # Retrocede 4 bytes más para apuntar a L(n-2)
	lw $t4,0($t1)            # Carga L(n-2) en $t4

	add $t3,$t3,$t4          # t3 = L(n-1) + L(n-2)
	addi $t1,$t1,8           # Avanza 8 bytes para volver a la posición libre actual
	sw $t3,0($t1)            # Guarda L(n) en la posición actual
	addi $t1,$t1,4           # Avanza 4 bytes (siguiente posición libre)
	add $t0,$t0,1            # Incrementa índice
	
	j for                    # Repite

############################################################
# imprimir
# Recorre el arreglo, imprime cada valor y calcula la sumatoria
############################################################
imprimir:
	li $t0,0                 # Reinicia índice
	la $t1,Vector            # Regresa el puntero al inicio del arreglo
	move $t4,$zero           # $t4 acumulará la sumatoria

############################################################
# foreach
# Imprime cada valor del arreglo separado por coma, 
# y evita la coma final
############################################################
foreach:
	bge $t0,$t2,fin          # Si se llegó al total, salta a fin
	lw  $t3,0($t1)           # Carga el valor actual del arreglo

	add $t4,$t4,$t3          # Acumula en la sumatoria

	li $v0,1                 # Imprimir entero
	move $a0,$t3
	syscall

	addi $t1,$t1,4           # Avanza al siguiente elemento del arreglo
	add $t0,$t0,1            # Incrementa índice

	beq $t0,$t2,foreach      # Si es el último elemento, salta a foreach (para no imprimir la coma)

	li $v0,4
	la $a0,Sms_
	syscall

	j foreach

############################################################
# fin
# Imprime " = " y luego la sumatoria final
############################################################
fin:
	li $v0,4
	la $a0,Sms_I
	syscall

	li $v0,1
	move $a0,$t4
	syscall

