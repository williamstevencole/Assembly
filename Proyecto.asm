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
    Sms_6: .asciiz "La tasa de interes es Mensual o Anual? "

    MesesStr: .asciiz "Meses"
    AnosStr:  .asciiz "Años"
    SalirStr: .asciiz "Salir"

    # Cadenas para imprimir la información recopilada
    info_header:  .asciiz "\nInformación recopilada:\n"
    info_name:    .asciiz "Nombre: "
    info_plazo:   .asciiz "Plazo (meses): "
    info_interes: .asciiz "Interes: "
    info_monto:   .asciiz "Monto del prestamo: "
    info_cuota:   .asciiz "Cuota: "

    hashtags:   .asciiz "\n######################################################################################################################\n"
    headerTablaLempiras: .asciiz "\t\t\t\t\tTabla de amortizacion en Lempiras"
    ColumnasTabla: .asciiz "\tMes\t|\tCuota\t\t|\tInteres\t\t|\tAmortizacion\t\t|\tSaldo\t"
    
    # Para la fila 0, definimos dos cadenas:
    row0_rest:   .asciiz "\t|\t\t\t|\t\t\t|\t\t\t\t|\t"   
    row0_prefix: .asciiz "\t"
    
    tableDiv:    .asciiz "\n----------------------------------------------------------------------------------------------------------------------\n" 
    
    mes_suffix: .asciiz "\t|"

    cuota_prefix: .asciiz "\t"
    cuota_suffix: .asciiz "\t|"
    
    interes_prefix: .asciiz "\t"
    interes_suffix: .asciiz "\t\t|"
    
    amortizacion_prefix:  .asciiz "\t"
    amortizacion_suffix:  .asciiz "\t|"
    
    saldo_prefix:  .asciiz "\t"
    saldo_suffix:  .asciiz "\t|"
    
    
    
    
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

    j print_info

print_info:
    li $v0, 4
    la $a0, info_header
    syscall

    li $v0, 4
    la $a0, info_name
    syscall
    li $v0, 4
    la $a0, Nombre
    syscall

    li $v0, 4
    la $a0, info_plazo
    syscall
    li $v0, 1
    move $a0, $t6
    syscall
    li $v0, 4
    la $a0, new_line
    syscall

    li $v0, 4
    la $a0, info_interes
    syscall
    li $v0, 2
    mov.s $f12, $f2
    syscall
    li $v0, 4
    la $a0, new_line
    syscall

    li $v0, 4
    la $a0, info_monto
    syscall
    li $v0, 2
    mov.s $f12, $f4
    syscall
    li $v0, 4
    la $a0, new_line
    syscall

    # Inicializar el contador de meses para el ciclo de tabla en $s0
    li $s0, 0        
    # Guardar el monto del préstamo en el arreglo de Saldo
    s.s $f4, 0($t5)
    addi $t5, $t5, 4  # Incrementar el puntero del arreglo de Saldo
    addi $t4, $t4, 1  # Incrementar el contador de elementos en el arreglo de Saldo

    j generarTablaLempiras

generarTablaLempiras:
    # Si el contador de meses ($s0) es mayor o igual al plazo ($t6), saltar a induccionLempiras
    bge $s0, $t6, induccionLempiras

    # Si el contador de meses es igual a 0, ir a mes0Lempiras  
    beq $s0, $zero, mes0Lempiras  

    j calcularCuotaLempiras

mes0Lempiras:
    li $v0, 4
    la $a0, hashtags
    syscall

    li $v0, 4
    la $a0, headerTablaLempiras
    syscall

    li $v0, 4
    la $a0, hashtags
    syscall

    li $v0, 4
    la $a0, ColumnasTabla
    syscall

    li $v0, 4
    la $a0, tableDiv
    syscall

    li $v0, 4
    la $a0, row0_prefix
    syscall
    
    # Imprimir el contador de meses (columna Mes)
    li $v0, 1
    move $a0, $s0
    syscall

    # Imprimir el resto de la fila (campos vacíos, luego monto)
    li $v0, 4
    la $a0, row0_rest
    syscall

    # Imprimir el monto del préstamo en la columna "Saldo"
    li $v0, 2
    mov.s $f12, $f4      
    syscall

    #Imprimir el divisor de la tabla
    li $v0, 4
    la $a0, tableDiv
    syscall

    addi $s0, $s0, 1    # Incrementar el contador de meses para salir del ciclo
    j calcularCuotaLempiras

calcularCuotaLempiras: 
    # Calcular la cuota usando la fórmula:
    #      [(i * (1+i)^n)]
    # C = M * ---------------  
    #      [(1+i)^n - 1]
    #
    # M = monto (en $f4)
    # i = tasa (en $f2)
    # n = número de meses (almacenado en $t6 como entero)

    li   $at, 0x3F800000    # 1.0 en IEEE 754
    mtc1 $at, $f0           # $f0 = 1.0
    mtc1 $at, $f8           # $f8 = 1.0  (acumulador para (1+i)^n)
    
    add.s $f10, $f0, $f2    # $f10 = 1.0 + i

    move $t7, $t6           # $t7 = n
power_loop:
    blez $t7, power_done   # Si n<=0, salir del ciclo
    mul.s $f8, $f8, $f10    # $f8 = $f8 * (1+i)
    addi $t7, $t7, -1       # Decrementar contador
    j power_loop
power_done:
    # Ahora $f8 contiene (1+i)^n
    mul.s $f10, $f2, $f8    # Numerador: i * (1+i)^n --> $f10
    sub.s $f12, $f8, $f0    # Denominador: (1+i)^n - 1 --> $f12
    div.s $f10, $f10, $f12  # Fracción = [i*(1+i)^n] / [(1+i)^n - 1]
    mul.s $f14, $f4, $f10   # Cuota = M * Fracción, resultado en $f14

    mfc1 $s1, $f14         # Almacenar la cuota en $s1

    j induccionLempiras

induccionLempiras:
    # Si el contador de meses ($s0) es mayor o igual al plazo ($t6), saltar a exit_prog
    bge $s0, $t6, exit_prog

    #tabulacion para hacer que el contador este alineado con el label de mes 
    li $v0, 4
    la $a0, row0_prefix   
    syscall
    
    # Imprimir el contador de meses (columna Mes)
    li $v0, 1
    move $a0, $s0
    syscall

    # Imprimir el resto de la fila (campos vacíos, luego monto)
    li $v0, 4
    la $a0, mes_suffix
    syscall

    #imprimir tabulacion previo de cuota
    li $v0, 4
    la $a0, cuota_prefix
    syscall
    
    #Imprimir cuota
    li $v0, 2
    mov.s $f12, $f14
    syscall

    #imprimir tabulacion y divisor de columna
    li $v0, 4
    la $a0, cuota_suffix
    syscall


    #Calcular interes
    #Ver valor actual en el arreglo de Saldo
    l.s $f22, 0($t5)
    #multiplicar s2 * interes ingresado por el usuario
    mul.s $f16, $f2, $f22

    #imprimir tabulacion previo de interes
    li $v0, 4
    la $a0, interes_prefix
    syscall

    #Imprimir interes
    li $v0, 2
    mov.s $f12, $f16
    syscall

    #imprimir tabulacion y divisor de columna
    li $v0, 4
    la $a0, interes_suffix
    syscall




    li $v0, 4
    la $a0, new_line
    syscall

    li $v0, 10
    syscall























#-------------------------------------------
# Rutina upper_case: Convierte un string a Title Case.
upper_case:
    li   $t6, 1          # Flag = 1 (primer carácter de una palabra)
upper_loop:
    lb   $t7, 0($a0)
    beqz $t7, end_upper
    li   $t8, 32
    beq  $t7, $t8, space_case
    beq  $t6, 1, process_first_letter
    li   $t8, 'A'
    li   $t9, 'Z'
    blt  $t7, $t8, no_change
    bgt  $t7, $t9, no_change
    addi $t7, $t7, 32
    sb   $t7, 0($a0)
    j    update_ptr
process_first_letter:
    li   $t8, 'a'
    li   $t9, 'z'
    blt  $t7, $t8, no_change_first
    bgt  $t7, $t9, no_change_first
    addi $t7, $t7, -32
    sb   $t7, 0($a0)
no_change_first:
    li   $t6, 0
    j    update_ptr
no_change:
    j    update_ptr
space_case:
    li   $t6, 1
update_ptr:
    addi $a0, $a0, 1
    j    upper_loop
end_upper:
    jr $ra













#-------------------------------------------
# Rutina remove_newline: Elimina el carácter '\n' (ASCII 10)
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
    jr $ra

#-------------------------------------------
# Rutina strcmp: Compara dos strings.
strcmp:
strcmp_loop:
    lb $t6, 0($a0)
    lb $t7, 0($a1)
    bne $t6, $t7, strcmp_not_equal
    beqz $t6, strcmp_equal
    addi $a0, $a0, 1
    addi $a1, $a1, 1
    j strcmp_loop
strcmp_not_equal:
    li $v0, 1
    jr $ra
strcmp_equal:
    li $v0, 0
    jr $ra
