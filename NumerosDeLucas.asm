.data 
    Sms_0: .asciiz "Bienvenidos a las Vacas de Narayana!!!\n"
    Sms_1: .asciiz "Digite la Cantidad a Generar: "
    Sms_2: .asciiz "Los primeros "
    Sms_3: .asciiz " valores de las Vacas de Narayana son: "
    Sms_4: .asciiz "\n"
.text 
.globl main

main:
    li $v0, 4         
    la $a0, Sms_0
    syscall
	
    li $v0, 4          # solicitar cant
    la $a0, Sms_1
    syscall
	
    li $v0, 5          # cant
    syscall
    move $t0, $v0      
	
    li $v0, 4          
    la $a0, Sms_2
    syscall
	
    li $v0, 1
    move $a0, $t0     # print cant
    syscall
	
    li $v0, 4
    la $a0, Sms_3
    syscall

    
    li $t1, 1         # v(n-3)
    li $t2, 1         # v(n-2)
    li $t3, 1         # v(n-1)
    li $t4, 1         # Contador (inicia en 1)

for:
    li $v0, 4         # \n
    la $a0, Sms_4
    syscall
	
    li $v0, 1         # Imprimir el valor actual (v(n-3))
    move $a0, $t1
    syscall
	
    add $t5, $t3, $t1   # v(n)= v(n-1) + v(n-3)
	
    move $t1, $t2      # v(n-3) <- v(n-2)
    move $t2, $t3      # v(n-2) <- v(n-1)
    move $t3, $t5      # v(n-1) <- nuevo término
	
    add $t4, $t4, 1    # i++
    blt $t4, $t0, for  # i<cant
    	