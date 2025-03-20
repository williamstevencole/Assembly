.data
NumerosPrimos:           .space 80        
NumerosPrimosEntre10:    .space 80

msgBienvenida:      .asciiz "Bienvenido a arreglo de numeros primos!!!"
msgPedirCantidad:   .asciiz "\n¿Cuántos números primos desea mostrar?: "
msgNormalPrimos:    .asciiz "\nNúmeros primos normales:\n"
msgDivPrimos:       .asciiz "\nNúmeros primos / 10:\n"
msgErrorCero:       .asciiz "\nNo se puede dividir entre CERO.\n"
msgSaltoLinea:      .asciiz ", "      
nl:                 .asciiz "\n"  
bye:		    .asciiz "Adios!!!!"
  
ten:                .float 10.0      # Constante 10.0 para la división

.text
.globl main

main:
    # Inicializacion
    la   $t7, NumerosPrimos           
    la   $t8, NumerosPrimosEntre10    
    
    li   $v0, 4
    la   $a0, msgBienvenida
    syscall

    # Pedir cantidad
    li   $v0, 4
    la   $a0, msgPedirCantidad
    syscall

    li   $v0, 5
    syscall
    move $s0, $v0                # $s0 = cantidad solicitada
    
    li   $s1, 0    # Contador de primos encontrados
    li   $s2, 2    # Candidato actual

findPrimos:
    bge  $s1, $s0, printPrimos    # Si ya se encontraron todos, saltar a imprimir

    li   $t4, 1      # primer candidato primo 
    li   $t5, 2      # Divisor inicial

checkDivisor:
    bge  $t5, $s2, checkResult    # Si divisor >= candidato, terminar verificación
    beq  $t5, $zero, errorDivisionCero  # Precaución
    move $a2, $s2    # Numerador: candidato
    move $a3, $t5    # Denominador: divisor
    div  $a2, $a3
    mfhi $t6       # $t6 = residuo
    beq  $t6, $zero, markNotPrime  # Si residuo es 0, no es primo
    addi $t5, $t5, 1
    j    checkDivisor

markNotPrime:
    li   $t4, 0

checkResult:
    beq  $t4, $zero, nextCandidate  # Si no es primo, ir al siguiente candidato

    sw   $s2, 0($t7)
    addi $t7, $t7, 4
    addi $s1, $s1, 1

nextCandidate:
    addi $s2, $s2, 1
    j    findPrimos

printPrimos:
    li   $v0, 4
    la   $a0, msgNormalPrimos
    syscall

    la   $t7, NumerosPrimos
    li   $t0, 0      

printLoop:
    bge  $t0, $s0, prepareDiv   # Si ya se imprimieron todos, saltar a la conversión
    lw   $a0, 0($t7)             # Cargar número primo
    li   $v0, 1
    syscall
    
    addi $t7, $t7, 4
    addi $t0, $t0, 1
    
    blt  $t0, $s0, printComma1  
    j    printLoop

printComma1:
    li   $v0, 4
    la   $a0, msgSaltoLinea
    syscall
    j    printLoop

prepareDiv:
    # Imprimir salto de línea y mensaje para primos divididos entre 10
    li   $v0, 4
    la   $a0, nl
    syscall
    li   $v0, 4
    la   $a0, msgDivPrimos
    syscall

    la   $t7, NumerosPrimos          
    la   $t8, NumerosPrimosEntre10    
    li   $t1, 0                       

divLoop:
    bge  $t1, $s0, printDiv         # Si ya se procesaron todos, saltar a imprimir
    
    lw   $t0, 0($t7)                # Cargar número primo (entero)
    mtc1 $t0, $f0                   # Mover a registro float
    cvt.s.w $f0, $f0                # Convertir a float
    lwc1 $f2, ten                  # Cargar 10.0
    div.s $f4, $f0, $f2            # $f4 = número / 10.0
    swc1 $f4, 0($t8)               # Almacenar resultado en NumerosPrimosEntre10
    addi $t7, $t7, 4
    addi $t8, $t8, 4
    addi $t1, $t1, 1
    j    divLoop

printDiv:
    la   $t8, NumerosPrimosEntre10  
    li   $t1, 0                      

printFloatLoop:
    bge  $t1, $s0, exit # Si ya se imprimieron todos, terminar
    
    lwc1 $f4, 0($t8)                # Cargar número float
    mov.s $f12, $f4                 # Preparar para syscall (float)
    li   $v0, 2
    syscall
    
    addi $t8, $t8, 4
    addi $t1, $t1, 1
    blt  $t1, $s0, printComma2       # Si no es el último, imprimir separador
    j    printFloatLoop

printComma2:
    li   $v0, 4
    la   $a0, msgSaltoLinea
    syscall
    j    printFloatLoop

exit:
    li $v0,4
    la $a0, bye
    syscall
    
    li $v0, 10
    syscall

errorDivisionCero:
    li   $v0, 4
    la   $a0, msgErrorCero
    syscall
    j    main
