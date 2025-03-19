.data
    Interes:      .space 80       # Arreglo para el interés del préstamo 
    Amortizacion: .space 80       # Arreglo para la amortización del préstamo
    Saldo:        .space 80       # Arreglo para el saldo del préstamo

    Nombre:       .space 80       # Variable para el nombre del beneficiario
    FormatoPlazo: .space 80       # Variable para el formato del plazo del préstamo    
    Plazo:        .space 80       # Variable para el plazo del préstamo

    Sms_0: .asciiz "Bienvenido a la amortizacion de prestamos!!!!!\n"
    Sms_1: .asciiz "Introduzca el nombre del beneficiario: "
    Sms_2: .asciiz "El plazo del prestamo es en Meses o Años? "
    Sms_3: .asciiz "Ingrese el plazo del prestamo: "
    Sms_4: .asciiz "Ingrese el interes del prestamo en decimal: "
    Sms_5: .asciiz "Ingrese el saldo del prestamo: "
    Sms_6: .asciiz "La tasa de interes es Mensual o Anual? "  # Si se usa en otro código

    MesesStr: .asciiz "Meses"
    AnosStr:  .asciiz "Años"
    SalirStr: .asciiz "Salir"

    # Cadenas para imprimir la información recopilada
    info_header:  .asciiz "\nInformación recopilada:\n"
    info_name:    .asciiz "Nombre: "
    info_plazo:   .asciiz "Plazo (meses): "
    info_interes: .asciiz "Interes: "
    info_monto:   .asciiz "Monto del prestamo: "

    new_line: .asciiz "\n"

.text
.globl main

main:
    # Inicializaciones de variables reservadas para arreglos:
	li   $t0, 0         # contador de elementos en arreglo de Interes
	la   $t1, Interes   # base del arreglo de Intereses

	li   $t2, 0         # contador de elementos en arreglo de Amortizacion
	la   $t3, Amortizacion   # base del arreglo de Amortizaciones

	li   $t4, 0         # contador de elementos en arreglo de Saldo
	la   $t5, Saldo     # base del arreglo de Saldo

    # Imprimir mensaje de bienvenida
    li $v0, 4
    la $a0, Sms_0
    syscall

    # Pedir el nombre del beneficiario
    li $v0, 4
    la $a0, Sms_1
    syscall

    li $v0, 8            
    la $a0, Nombre       
    li $a1, 80           
    syscall

    # Convertir el nombre a Title Case
    la $a0, Nombre   
    jal upper_case

# Bucle para pedir el formato del plazo
loop_format:
    li $v0, 4
    la $a0, Sms_2
    syscall

    li $v0, 8
    la $a0, FormatoPlazo
    li $a1, 80
    syscall

    la $a0, FormatoPlazo
    jal upper_case

    la $a0, FormatoPlazo
    jal remove_newline

    # Comparar con "Meses"
    la $a0, FormatoPlazo   
    la $a1, MesesStr       
    jal strcmp             
    beq $v0, $zero, plazoMeses  # Si son iguales, $v0 == 0

    # Comparar con "Años"
    la $a0, FormatoPlazo
    la $a1, AnosStr
    jal strcmp
    beq $v0, $zero, plazoAnios   # Si son iguales, $v0 == 0

    # Comparar con "Salir"
    la $a0, FormatoPlazo
    la $a1, SalirStr
    jal strcmp
    beq $v0, $zero, exit_prog    # Si son iguales, salir

    # Si no coincide con ninguna, repetir la solicitud
    j loop_format

exit_prog:
    li $v0, 10
    syscall

plazoMeses:
    li $v0, 4
    la $a0, Sms_3
    syscall

    li $v0, 5
    syscall
    move $t6, $v0   # Guardar el plazo ingresado (en meses) en $t6
    j continue_program1

plazoAnios:
    li $v0, 4
    la $a0, Sms_3
    syscall

    li $v0, 5
    syscall
    move $t6, $v0   # Guardar el plazo ingresado (en años) en $t6
    li $s0, 12     # Cargar 12 en $s0
    mul $t6, $t6, $s0   # Convertir el plazo a meses
    j continue_program1

continue_program1:
    # Solicitar el interés del préstamo (float)
    li $v0, 4
    la $a0, Sms_4         # "Ingrese el interes del prestamo en decimal: "
    syscall

    li $v0, 6             # Leer float
    syscall
    mov.s $f2, $f0        # Guardar el interés en $f2

    # Solicitar el monto del préstamo (float)
    li $v0, 4
    la $a0, Sms_5         # "Ingrese el saldo del prestamo: "
    syscall

    li $v0, 6             # Leer float
    syscall
    mov.s $f4, $f0        # Guardar el monto en $f4

    # Imprimir la información recopilada:
    jal print_info

    # Terminar el programa
    li $v0, 10
    syscall

##############################################
# print_info: Imprime la información recopilada
##############################################
print_info:
    # Imprimir encabezado
    li $v0, 4
    la $a0, info_header
    syscall

    # Imprimir Nombre:
    li $v0, 4
    la $a0, info_name
    syscall
    li $v0, 4
    la $a0, Nombre
    syscall

    # Imprimir Plazo (meses):
    li $v0, 4
    la $a0, info_plazo
    syscall
    li $v0, 1
    move $a0, $t6
    syscall
    li $v0, 4
    la $a0, new_line
    syscall

    # Imprimir Interés:
    li $v0, 4
    la $a0, info_interes
    syscall
    li $v0, 2
    mov.s $f12, $f2
    syscall
    li $v0, 4
    la $a0, new_line
    syscall

    # Imprimir Monto:
    li $v0, 4
    la $a0, info_monto
    syscall
    li $v0, 2
    mov.s $f12, $f4
    syscall
    li $v0, 4
    la $a0, new_line
    syscall

    jr $ra












#-----------------------------------------------------------------
# Rutina upper_case: Convierte un string a Title Case.
# Usa registros $t6-$t9 para temporales; $t0-$t5 quedan reservados para arreglos.
upper_case:
    li   $t6, 1          # Flag en $t6 = 1 (primer carácter de una palabra)
upper_loop:
    lb   $t7, 0($a0)     # Cargar el carácter actual en $t7
    beqz $t7, end_upper  # Si es nulo, terminamos
    li   $t8, 32         # Código ASCII para espacio
    beq  $t7, $t8, space_case  # Si es espacio, ir a space_case
    beq  $t6, 1, process_first_letter  # Si flag == 1, procesar primer carácter
    li   $t8, 'A'
    li   $t9, 'Z'
    blt  $t7, $t8, no_change
    bgt  $t7, $t9, no_change
    addi $t7, $t7, 32    # Convertir mayúscula a minúscula
    sb   $t7, 0($a0)
    j    update_ptr
process_first_letter:
    li   $t8, 'a'
    li   $t9, 'z'
    blt  $t7, $t8, no_change_first
    bgt  $t7, $t9, no_change_first
    addi $t7, $t7, -32   # Convertir minúscula a mayúscula
    sb   $t7, 0($a0)
no_change_first:
    li   $t6, 0         # Flag = 0: ya se procesó el primer carácter
    j    update_ptr
no_change:
    j    update_ptr
space_case:
    li   $t6, 1         # Al encontrar un espacio, activar la flag para la siguiente palabra
update_ptr:
    addi $a0, $a0, 1
    j    upper_loop
end_upper:
    jr   $ra

#-----------------------------------------------------------------
# Rutina remove_newline: Elimina el carácter de nueva línea ('\n', ASCII 10)
# del string, si está presente. Usa $t6 y $t7.
remove_newline:
    lb $t6, 0($a0)
    beqz $t6, rn_exit
    li $t7, 10
    beq  $t6, $t7, rn_replace
    addi $a0, $a0, 1
    j    remove_newline
rn_replace:
    sb $zero, 0($a0)
    jr $ra
rn_exit:
    jr   $ra

#-----------------------------------------------------------------
# Rutina strcmp: Compara dos strings.
# Entrada:
#   $a0: puntero al primer string.
#   $a1: puntero al segundo string.
# Salida:
#   $v0: 0 si son iguales, distinto de 0 si no.
# Usa $t6 y $t7 para temporales.
strcmp:
strcmp_loop:
    lb $t6, 0($a0)
    lb $t7, 0($a1)
    bne $t6, $t7, strcmp_not_equal
    beqz $t6, strcmp_equal   # Llegamos al fin (nulo) al mismo tiempo
    addi $a0, $a0, 1
    addi $a1, $a1, 1
    j strcmp_loop
strcmp_not_equal:
    li $v0, 1
    jr $ra
strcmp_equal:
    li $v0, 0
    jr $ra
