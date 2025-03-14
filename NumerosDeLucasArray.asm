.data
	Vector: .space 40           
	Length: .word 0              
	Size:   .word 10             
	
	Sms_0: .asciiz "Bienvenido a NUMEROS DE LUCAS EN ARREGLO!!!\n"
	Sms_1: .asciiz "Digite la Cantidad: "
	Sms_2: .asciiz "Digite el Número de Entrada: "
	Sms_3: .asciiz "La Sumatoria de los Números de Entrada es: "
	Sms_:  .asciiz ", "
	Sms_I: .asciiz " = "

.text 
.globl main

main:
	li $t0,0                  
	la $t1,Vector            

	li $v0,4                 
	la $a0,Sms_0              
	syscall
	
	li $v0,4
	la $a0,Sms_1              
	syscall

	li $v0,5                 
	syscall
	move $t2,$v0              

for:
	bge $t0,$t2,imprimir      # Si t0 >= t2, salta a imprimir
	bge $t0,2,general         # Si t0 >= 2, salta a la parte general de cálculo

	beq $t0,0,base0          # Si t0 == 0, salta a base0 (L(0)=2)

	# Caso t0 == 1
	li $t3,1                 # L(1) = 1
	sw $t3,0($t1)            
	addi $t1,$t1,4           
	add $t0,$t0,1           
	j for                   


base0:
	li $t3,2                 # L(0) = 2
	sw $t3,0($t1)            
	addi $t1,$t1,4           # Avanza 4 bytes
	add $t0,$t0,1            # Incrementa índice
	j for                    

# Cálculo de L(n) = L(n-1) + L(n-2) para n >= 2
general:
	subi $t1,$t1,4           # Retrocede 4 bytes para apuntar a L(n-1)
	lw $t3,0($t1)            

	subi $t1,$t1,4           # Retrocede 4 bytes más para apuntar a L(n-2)
	lw $t4,0($t1)            #

	add $t3,$t3,$t4          # t3 = L(n-1) + L(n-2)
	addi $t1,$t1,8           # Avanza 8 bytes para volver a la posición libre actual
	sw $t3,0($t1)            # Guarda L(n) en la posición actual
	addi $t1,$t1,4           # Avanza 4 bytes (siguiente posición libre)
	add $t0,$t0,1            # Incrementa índice
	
	j for                    # Repite


imprimir:
	li $t0,0                 
	la $t1,Vector           
	move $t4,$zero          


foreach:
	bge $t0,$t2,fin          # Si se llegó al total, salta a fin
	lw  $t3,0($t1)           

	add $t4,$t4,$t3          

	li $v0,1                 
	move $a0,$t3
	syscall

	addi $t1,$t1,4           
	add $t0,$t0,1            

	beq $t0,$t2,foreach      # Si es el último elemento, salta a foreach (para no imprimir la coma)

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

