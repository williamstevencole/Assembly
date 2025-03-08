.data
msgPedirCantidad:   .asciiz "\n¿Cuántos números primos desea mostrar?: "
msgErrorCero:       .asciiz "\n[ERROR] No se puede dividir entre CERO.\n"
msgSaltoLinea:      .asciiz "\n"

.text
.globl main

main:
 	
    #Pedir numeros primos
    li  $v0, 4                  
    la  $a0, msgPedirCantidad
    syscall

    li  $v0, 5                  
    syscall
    move $s0, $v0               
    
    #Inicializar "variables"
    li   $s1, 0    # $s1 = count de primos encontrados
    li   $s2, 2    # $s2 = candidate (arrancamos buscando desde 2)

    # Bucle principal (outerLoop) Se repetirá hasta que hayamos impreso $s0 primos
outerLoop:
    # Si count == cantidad deseada, salimos
    bge  $s1, $s0, fin

    # Revisar si $s2 (candidate) es primo
    # Haremos un "for divisor = 2 hasta candidate-1"
    # Si encontramos un divisor exacto, no es primo.
    # Si no, es primo.
    li   $t0, 1       # $t0 será "isPrime" (1=sí, 0=no); asumimos de entrada que sí
    li   $t1, 2       # $t1 = divisor inicial

innerLoop:
    # Si $t1 >= $s2, ya no tenemos más divisores que probar
    bge  $t1, $s2, verificarResultado

    # Evitar dividir entre 0 (por precaución). Si $t1==0 => error
    beq  $t1, $zero, errorDivisionCero

    # Hacemos la división candidate / divisor
    move $a2, $s2    # numerador
    move $a3, $t1    # denominador
    div  $a2, $a3

    mfhi $t2         # $t2 = residuo
    # Si residuo == 0 => no es primo; ponemos $t0=0 y saltamos
    beq  $t2, $zero, notPrime

    addi $t1, $t1, 1
    j innerLoop

notPrime:
    li   $t0, 0   

verificarResultado:
    # Si $t0 sigue valiendo 1 => es primo
    beq  $t0, $zero, siguienteCandidate

    # Imprimir candidate
    li  $v0, 1
    move $a0, $s2
    syscall

    # Imprimir espacio (o salto)
    li  $v0, 4
    la  $a0, msgSaltoLinea
    syscall

    # Contador de primos ++
    addi $s1, $s1, 1

siguienteCandidate:
    addi $s2, $s2, 1
    j outerLoop


# 3) Fin del programa
fin:
    # Salimos con syscall = 10
    li  $v0, 10
    syscall

# 4) Manejo de error division por cero
errorDivisionCero:
    li  $v0, 4
    la  $a0, msgErrorCero
    syscall

    # Tras mostrar el error, regresar a main para pedir todo de nuevo
    j main
