.data
    Vector:     .space 40       # Espacio para 10 int (4 bytes c/u)
    Length:     .word 0         # No se está usando directamente
    Size:       .word 10        # Tamaño máximo
    Sms_0:      .asciiz "Bienvenido a Arreglo de Fabricio!!!\n"
    Sms_1:      .asciiz "Digite la Cantidad: "
    Sms_2:      .asciiz "Digite el Número de Entrada: "
    Sms_3:      .asciiz "La Sumatoria de los Números de Entrada es: "
    Sms_:       .asciiz "\n"

.text
.globl main

main:
    ##################################################
    #   1) Saludo inicial
    ##################################################
    li   $v0,4            # Imprimir string
    la   $a0,Sms_0
    syscall

    ##################################################
    #   2) Lectura de la cantidad de números a ingresar
    ##################################################
    li   $v0,4            # Imprimir string
    la   $a0,Sms_1
    syscall

    li   $v0,5            # Leer entero
    syscall
    move $t2,$v0          # En $t2 guardamos la cantidad solicitada
    
    ##################################################
    #   3) Lectura de valores dentro del array
    ##################################################
    li   $t0,0            # $t0 = 0 (índice)
    la   $t1,Vector       # $t1 apunta al inicio del array

for:                      # Ciclo para leer todos los valores
    bge  $t0,$t2,imprimir # Si t0 >= t2, ya se ingresaron todos → ir a imprimir

    # Mensaje "Digite el Número de Entrada:"
    li   $v0,4
    la   $a0,Sms_2
    syscall

    # Leer número y guardarlo en el array
    li   $v0,5
    syscall
    move $t3,$v0
    sw   $t3,0($t1)

    # Incrementar índice y posición de memoria del vector
    addi $t1,$t1,4
    addi $t0,$t0,1

    j    for

    ##################################################
    #   4) Rutina para imprimir los valores del array
    ##################################################
imprimir:
    # Reiniciamos $t0 y $t1
    li   $t0,0
    la   $t1,Vector

print_loop:
    beq  $t0,$t2,fin      # Si $t0 == $t2, acabamos de imprimir todos

    lw   $t3,0($t1)       # Cargamos el valor del array en $t3

    li   $v0,1            # Llamada para imprimir entero
    move $a0,$t3
    syscall

    # Imprimir un salto de línea o espacio
    li   $v0,4
    la   $a0,Sms_
    syscall

    # Avanzar al siguiente elemento
    addi $t1,$t1,4
    addi $t0,$t0,1

    j    print_loop

fin:
    # Salida limpia del programa
    li   $v0,10           # syscall = 10 => Exit
    syscall

