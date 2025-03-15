.data
Vector:      .space 80

Sms_dash:      .asciiz "\n========================================================================================================================================================\n"
Sms_Menu:     .asciiz "\nMENU:\n1) Nicomaco\n2) Sucesion 4 x 2^-n\n3) Salir\nOpcion: "
Sms_Error:    .asciiz "Opcion invalida!\n"

# -- Mensajes para Nicomaco --
Sms_0:    .asciiz "Bienvenido a LOS CUBOS DE NICOMACO EN ARREGLO!!!\n"
Sms_1:    .asciiz "Digite la Cantidad de Cubos a Generar: "
Sms_:     .asciiz ", "
Sms_I:    .asciiz " = "
Sms_pow:  .asciiz "^3 = "
Sms_plus: .asciiz " + "
Sms_nl:   .asciiz "\n"

# -- Mensajes para la sucesión 4 x 2^-n (en float) --
Sms_pot:   .asciiz "Sucesion 4 x 2^-n\n"
Sms_ask:   .asciiz "Digite la cantidad de numeros a generar: "
Sms_res:   .asciiz "\nTerminos generados:\n"

# Constantes en punto flotante
Four:     .float 4.0
Two:      .float 2.0

.text
.globl main

main:
    # Imprimir el menú
    li   $v0, 4
    la   $a0, Sms_Menu
    syscall

    # Leer opción (entero)
    li   $v0, 5
    syscall
    move $t9, $v0  # opción en t9

    # Verificar opción
    beq  $t9, 1, doNicomaco
    beq  $t9, 2, doPotencias
    beq  $t9, 3, fin_programa

    # Si no es 1,2,3 => mensaje de error y regresa
    li   $v0, 4
    la   $a0, Sms_Error
    syscall
    j    main

# Opción 1: Nicomaco
doNicomaco:
    jal ZeroVector       # Limpia Vector
    jal NicomacoRoutine  # Llama a Nicomaco
    jal printLine        # Imprime "==="
    j   main

# Opción 2: 4 x 2^-n (float)
doPotencias:
    jal ZeroVector        # Limpia Vector
    jal PotenciasRoutine  # Llama a potencias
    jal printLine	# Imprime "=====:
    j   main

# Opción 3: Salir
fin_programa:
    li   $v0, 10
    syscall



#Procedimiento para vaciar el vector cada vez que se ingrese 1 o 2 en menu
ZeroVector:
    li   $t0, 0
    la   $t1, Vector

zeroLoop:
    li   $t2, 20
    bge  $t0, $t2, zeroDone
    sw   $zero, 0($t1)
    addi $t1, $t1, 4
    addi $t0, $t0, 1
    j    zeroLoop

zeroDone:
    jr   $ra

#IMPRIME: ===================================================================================
printLine:
    li   $v0, 4
    la   $a0, Sms_dash
    syscall
    jr   $ra







#Procedimientos para nicomaco
NicomacoRoutine:
    li  $t0, 0
    la  $t1, Vector

    # Imprime mensaje de bienvenida
    li  $v0, 4
    la  $a0, Sms_0
    syscall

    # Solicita cantidad
    li  $v0, 4
    la  $a0, Sms_1
    syscall

    # Lee cantidad (entero)
    li  $v0, 5
    syscall
    move $t2, $v0

    # Primer impar
    li  $t5, 1

Nico_for:
    bge  $t0, $t2, nico_imprimir
    bge  $t0, 1, general
    beq  $t0, 0, casobase

casobase:
    # n=1 => 1^3=1
    li   $t8, 1
    li   $v0, 1
    move $a0, $t8
    syscall

    li   $v0, 4
    la   $a0, Sms_pow
    syscall

    move $t3, $t5
    addi $t5, $t5, 2

    li   $v0, 1
    move $a0, $t3
    syscall

    li   $v0, 4
    la   $a0, Sms_I
    syscall

    li   $v0, 1
    move $a0, $t3
    syscall

    li   $v0, 4
    la   $a0, Sms_nl
    syscall

    sw   $t3, 0($t1)
    addi $t1, $t1, 4
    addi $t0, $t0, 1
    j    Nico_for

general:
    # n = t0 + 1
    addi $t8, $t0, 1
    li   $v0, 1
    move $a0, $t8
    syscall

    li   $v0, 4
    la   $a0, Sms_pow
    syscall

    li   $t6, 0
    li   $t7, 0

sum_loop:
    bge  $t7, $t8, exit_sum
    bgt  $t7, $zero, print_plus

print_impar:
    li   $v0, 1
    move $a0, $t5
    syscall

    add  $t6, $t6, $t5
    addi $t5, $t5, 2
    addi $t7, $t7, 1
    j    sum_loop

print_plus:
    li   $v0, 4
    la   $a0, Sms_plus
    syscall
    j    print_impar

exit_sum:
    li   $v0, 4
    la   $a0, Sms_I
    syscall

    li   $v0, 1
    move $a0, $t6
    syscall

    li   $v0, 4
    la   $a0, Sms_nl
    syscall

    sw   $t6, 0($t1)
    addi $t1, $t1, 4
    addi $t0, $t0, 1
    j    Nico_for

nico_imprimir:
    li   $t0, 0
    la   $t1, Vector
    move $t4, $zero

Nico_foreach:
    bge  $t0, $t2, nico_fin
    lw   $t3, 0($t1)
    add  $t4, $t4, $t3

    li   $v0, 1
    move $a0, $t3
    syscall

    addi $t1, $t1, 4
    addi $t0, $t0, 1

    beq  $t0, $t2, Nico_foreach
    li   $v0, 4
    la   $a0, Sms_
    syscall

    j    Nico_foreach

nico_fin:
    li   $v0, 4
    la   $a0, Sms_I
    syscall

    li   $v0, 1
    move $a0, $t4
    syscall

    jr   $ra














#Procedimientos para potencias
PotenciasRoutine:
    li   $v0, 4
    la   $a0, Sms_pot
    syscall

    # Pide cantidad
    li   $v0, 4
    la   $a0, Sms_ask
    syscall

    # Lee cantidad (entero)
    li   $v0, 5
    syscall
    move $t2, $v0

    # Aviso
    li   $v0, 4
    la   $a0, Sms_res
    syscall

    # Carga 4.0 y 2.0 en registros de FP
    la   $a0, Four
    lwc1 $f0, 0($a0)  # f0 = 4.0
    la   $a0, Two
    lwc1 $f2, 0($a0)  # f2 = 2.0

    li   $t0, 0
    la   $t1, Vector

PotLoop:
    bge  $t0, $t2, PotFin

    # Imprimir float actual (f0)
    li   $v0, 2        
    mov.s $f12, $f0
    syscall

    # Guardar en Vector como float
    swc1 $f0, 0($t1)
    addi $t1, $t1, 4
    addi $t0, $t0, 1

    # Evitar la coma tras el último
    beq  $t0, $t2, skipComa

    # Imprimir ", "
    li   $v0, 4
    la   $a0, Sms_
    syscall

skipComa:
    # Siguiente termino => f0 = f0 / 2.0
    div.s $f0, $f0, $f2
    j    PotLoop

PotFin:
    # Salto de linea
    li   $v0, 4
    la   $a0, Sms_nl
    syscall

    # Regresamos al menú
    jr   $ra
