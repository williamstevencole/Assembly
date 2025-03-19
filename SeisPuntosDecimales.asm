.data
    prompt:      .asciiz "Ingrese un numero: "
    dot_string:  .asciiz "."
    newline:     .asciiz "\n"
    zero_string: .asciiz "0"
.text
.globl main

main:
    # Mostrar mensaje para ingresar un número
    li $v0, 4
    la $a0, prompt
    syscall

    # Leer número float (syscall 6)
    li $v0, 6
    syscall             # Número leído en $f0

    # Mover el número a $f12 (convención para la rutina)
    mov.s $f12, $f0

    # Llamar a la rutina que imprime el float con 6 decimales
    jal print_float_fixed6

    li $v0, 10
    syscall

##############################################
# print_float_fixed6:
#   Entrada: float en $f12.
#   Salida: imprime el float con EXACTAMENTE 6 decimales (sin redondear, solo truncando).
##############################################
print_float_fixed6:
    # Multiplicar el valor por 1e6
    li   $t0, 1000000          # 1,000,000 como entero
    mtc1 $t0, $f0             # Mover a $f0
    cvt.s.w $f0, $f0          # Convertir a float; ahora $f0 = 1e6
    mul.s $f2, $f12, $f0      # $f2 = valor * 1e6

    # Truncar el valor en $f2 (sin redondeo)
    trunc.w.s $f2, $f2        # $f2 ahora contiene la parte entera del número escalado
    mfc1 $t1, $f2             # $t1 = entero de (valor * 1e6)

    # Dividir $t1 entre 1e6 para separar parte entera y parte fraccionaria
    li   $t2, 1000000
    div $t1, $t2              # Cociente en LO, residuo en HI
    mflo $t3                 # $t3 = parte_entera
    mfhi $t4                 # $t4 = parte_fraccionaria

    # Imprimir la parte entera
    li $v0, 1
    move $a0, $t3
    syscall

    # Imprimir el punto decimal
    li $v0, 4
    la $a0, dot_string
    syscall

    # Ahora, queremos imprimir la parte fraccionaria con EXACTAMENTE 6 dígitos.
    # Primero, contamos la cantidad de dígitos reales en $t4.
    move $t5, $t4            # Copia de la parte fraccionaria
    li   $t6, 0              # Contador de dígitos
count_loop:
    beqz $t5, done_count
    li   $t7, 10
    div  $t5, $t7
    mflo $t5
    addi $t6, $t6, 1
    j count_loop
done_count:
    # Si $t4 es 0, forzamos que tenga 1 dígito.
    blez $t6, set_one
    j fill_leading
set_one:
    li $t6, 1
fill_leading:
    li   $t7, 6              # Queremos 6 dígitos en total
    sub  $t7, $t7, $t6       # $t7 = número de ceros a imprimir
print_zeros:
    blez $t7, print_remainder
    li   $v0, 4
    la   $a0, zero_string
    syscall
    addi $t7, $t7, -1
    j print_zeros
print_remainder:
    # Imprimir la parte fraccionaria real
    li $v0, 1
    move $a0, $t4
    syscall

    jr $ra
