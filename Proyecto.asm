.data
    Interes:      .space 80       # Arreglo para el inter�s del pr�stamo 
    Amortizacion: .space 80       # Arreglo para la amortizaci�n del pr�stamo
    Saldo:        .space 80       # Arreglo para el saldo del pr�stamo
 
    Nombre:       .space 80       # Variable para el nombre del beneficiario
    FormatoPlazo: .space 80       # Variable para el formato del plazo del pr�stamo    
    Plazo:        .space 80       # Variable para el plazo del pr�stamo
 
    Sms_0: .asciiz "\n\t# ----- Bienvenido a la amortizacion de prestamos!!!!! ----- #\n\n- Antes de empezar, necesitamos recopilar la siguiente informaci�n:\n"
    Sms_1: .asciiz "# ----- -> Introduzca el nombre del beneficiario: "
    Sms_2: .asciiz "# ----- -> El plazo del prestamo es en Meses o A?os? "
    Sms_3: .asciiz "# ----- -> Ingrese el plazo del prestamo: "
    Sms_4: .asciiz "# ----- -> Ingrese el interes del prestamo en decimal (Ejemplo: 0.10 si es 10%): "
    Sms_5: .asciiz "# ----- -> Ingrese el saldo del prestamo: "
    Sms_6: .asciiz "# ----- -> La tasa de interes es Mensual o Anual? "
    Error_plazo: .asciiz "# ----- -> ERROR: El plazo maximo es 20 a?os o 240 meses.\n# ----- -> Por favor ingrese el plazo del prestamo: "
 
    MesesStr: .asciiz "MESES"
    AnosStr:  .asciiz "A?OS"
    SalirStr: .asciiz "SALIR"
 
    # Cadenas para imprimir la informaci�n recopilada
    info_header:  .asciiz "\n# ----- Informaci�n recopilada:\n"
    info_name:    .asciiz "#\t---> Nombre: \t\t\t"
    info_plazo:   .asciiz "#\t---> Plazo (meses): \t\t"
    info_interes: .asciiz "#\t---> Interes: \t\t\t"
    info_monto:   .asciiz "#\t---> Monto del prestamo: \t"
    info_cuota:   .asciiz "#\t---> Cuota: \t\t\t"
 
    hashtags:   .asciiz "\n########################################################################################################################################################\n"
    headerTablaLempiras: .asciiz "\t\t\t\t\t\t\tTabla de amortizacion en Lempiras"
    headerTablaDolares:  .asciiz "\t\t\t\t\t\t\tTabla de amortizacion en Dolares"
    ColumnasTabla: .asciiz "\tMes\t|\tCuota\t\t|\t\tInteres\t\t\t\t|\t\tAmortizacion\t\t|\tSaldo\t\t"
 
    row0_rest:   .asciiz "\t|\t\t\t|\t\t\t\t\t\t|\t\t\t\t\t|\t"   
    row0_prefix: .asciiz "\t"
 
    tableDiv:    .asciiz "\n-------------------------------------------------------------------------------------------------------------------------------------------------------\n" 
 
    mes_suffix: .asciiz "\t|"
 
    cuota_prefix: .asciiz "\t"
    cuota_suffix: .asciiz "\t|"
 
    interes_prefix: .asciiz "\t\t"
    interes_suffix: .asciiz "\t\t\t|"
 
    amortizacion_prefix:  .asciiz "\t\t"
    amortizacion_suffix:  .asciiz "\t\t|"
 
    saldo_prefix:  .asciiz "\t"
    saldo_suffix:  .asciiz "\t"
 
    new_line: .asciiz "\n"
 
    dollar_rate: .float 25.59   
 
    lempiras: .asciiz "L."
    dolares:  .asciiz "$"

    # Variables para sumatorias
    SumaCuotaLPS: .float 0.0
    SumaInteresLPS: .float 0.0
    SumaAmortizacionLPS: .float 0.0
    SumaSaldoLPS: .float 0.0
    SumaCuotaUSD: .float 0.0
    SumaInteresUSD: .float 0.0
    SumaAmortizacionUSD: .float 0.0
    SumaSaldoUSD: .float 0.0

    # Mensajes para sumatorias
    suma_cuota_lps: .asciiz "\n\n\t-----> Suma total de cuotas en Lempiras: \t\t"
    suma_interes_lps: .asciiz "\n\t-----> Suma total de intereses en Lempiras: \t\t"
    suma_amort_lps: .asciiz "\n\t-----> Suma total de amortizaci�n en Lempiras: \t\t"
    suma_saldo_lps: .asciiz "\n\t-----> Suma total de saldos en Lempiras: \t\t"
    suma_cuota_usd: .asciiz "\n\n\t-----> Suma total de cuotas en D�lares: \t\t"
    suma_interes_usd: .asciiz "\n\t-----> Suma total de intereses en D�lares: \t\t"
    suma_amort_usd: .asciiz "\n\t-----> Suma total de amortizaci�n en D�lares: \t\t"
    suma_saldo_usd: .asciiz "\n\t-----> Suma total de saldos en D�lares: \t\t"
    prompt_reinicio: .asciiz "\n\n#-----> ?Desea realizar otro c�lculo? (SI/NO): "
    buffer_input: .space 80
    str_si: .asciiz "SI"
    str_no: .asciiz "NO"
 
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
 
    # Imprimir mensaje de bienvenida (SOLO UNA VEZ)
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
    # Limpiar buffer antes de cada lectura
    la $a0, FormatoPlazo
    jal clear_buffer

    li $v0, 4
    la $a0, Sms_2
    syscall

    li $v0, 8
    la $a0, FormatoPlazo
    li $a1, 80
    syscall

    # Convertir a may�sculas y eliminar newline
    la $a0, FormatoPlazo
    jal upper_case
    jal remove_newline

    # Validaci�n flexible de opciones
    la $a0, FormatoPlazo
    lb $t7, 0($a0)
    
    # Verificar si es MESES (acepta "MES", "MESES", etc.)
    beq $t7, 'M', check_mes
    
    # Verificar si es A?OS (acepta "A?O", "A?OS", "ANO", "ANIO", etc.)
    beq $t7, 'A', check_anio
    
    # Verificar si es SALIR
    beq $t7, 'S', check_salir
    
    # Si no es ninguna opci�n v�lida, repetir
    j loop_format

check_mes:
    lb $t7, 1($a0)
    beq $t7, 'E', valid_mes  # Para "MES" o "MESES"
    j loop_format

valid_mes:
    j plazoMeses

check_anio:
    lb $t7, 1($a0)
    beq $t7, 'N', check_anio_continuation  # Para "ANO" o "ANIO"
    beq $t7, '?', valid_anio               # Para "A?O" (con ?)
    j loop_format

check_anio_continuation:
    lb $t7, 2($a0)
    beq $t7, 'O', valid_anio   # Para "ANO"
    beq $t7, 'I', valid_anio   # Para "ANIO"
    j loop_format

valid_anio:
    j plazoAnios

check_salir:
    la $a0, FormatoPlazo
    la $a1, SalirStr
    jal strcmp
    beq $v0, $zero, exit_prog
    j loop_format
 
exit_prog:
    li $v0, 10
    syscall
 
plazoMeses:
    li $v0, 4
    la $a0, Sms_3
    syscall

plazoMeses_input:
    li $v0, 5
    syscall
    move $t6, $v0   # Guardar el plazo ingresado (en meses) en $t6

    # Validar que no exceda 240 meses
    bgt $t6, 240, plazoMeses_error
    j continue_program1

plazoMeses_error:
    li $v0, 4
    la $a0, Error_plazo
    syscall
    j plazoMeses_input
 
plazoAnios:
    li $v0, 4
    la $a0, Sms_3
    syscall

plazoAnios_input:
    li $v0, 5
    syscall
    move $t6, $v0   # Guardar el plazo ingresado (en a?os) en $t6

    # Validar que no exceda 20 a?os
    bgt $t6, 20, plazoAnios_error
    li $s0, 12     # Cargar 12 en $s0
    mul $t6, $t6, $s0   # Convertir el plazo a meses
    j continue_program1

plazoAnios_error:
    li $v0, 4
    la $a0, Error_plazo
    syscall
    j plazoAnios_input
 
continue_program1:
    # Solicitar el inter�s del pr�stamo (float)
    li $v0, 4
    la $a0, Sms_4         # "Ingrese el interes del prestamo en decimal: "
    syscall
 
    li $v0, 6             # Leer float
    syscall
    mov.s $f2, $f0        # Guardar el inter�s en $f2

    # Si el plazo fue ingresado en a�os, dividir tasa por 12
    la $a0, FormatoPlazo
    lb $t7, 0($a0)
    beq $t7, 'A', ajustar_tasa_anual

    j continuar_sin_ajuste

ajustar_tasa_anual:
    li $t7, 12
    mtc1 $t7, $f6
    cvt.s.w $f6, $f6
    div.s $f2, $f2, $f6   # tasa = tasa_anual / 12

continuar_sin_ajuste:
    # Solicitar el monto del pr�stamo (float)
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
    # Guardar el monto del pr�stamo en el arreglo de Saldo
    s.s $f4, 0($t5)
    addi $t5, $t5, 4  # Incrementar el puntero del arreglo de Saldo
    addi $t4, $t4, 1  # Incrementar el contador de elementos en el arreglo de Saldo
 
    j generarTablaLempiras
 
generarTablaLempiras:
    # Si el contador de meses ($s0) es mayor o igual al plazo ($t6), saltar a calcularSumatoriasLempiras
    bge $s0, $t6, calcularSumatoriasLempiras
 
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
 
    # Imprimir el resto de la fila (campos vac�os, luego monto)
    li $v0, 4
    la $a0, row0_rest
    syscall
 
    # Imprimir s�mbolo y monto en la columna "Saldo"
    li $v0, 4
    la $a0, lempiras
    syscall
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
    mul.s $f10, $f2, $f8    # Numerador: i * (1+i)^n --> $f10
    sub.s $f12, $f8, $f0    # Denominador: (1+i)^n - 1 --> $f12
    div.s $f10, $f10, $f12  # Fracci�n = [i*(1+i)^n] / [(1+i)^n - 1]
    mul.s $f14, $f4, $f10   # Cuota = M * Fracci�n, resultado en $f14
 
    mfc1 $s1, $f14         # Almacenar la cuota en $s1
 
    j induccionLempiras
 
 
induccionLempiras:
    # Verificar si ya se alcanz� o super� el plazo
    bgt $s0, $t6, calcularSumatoriasLempiras
 
    # Imprimir la fila del mes (para la columna "Mes" y el resto)
    li $v0, 4
    la $a0, row0_prefix    # Imprime la parte fija antes del contador de mes
    syscall
 
    # Imprimir el contador de meses (columna "Mes")
    li $v0, 1
    move $a0, $s0
    syscall
 
    # Imprimir el sufijo de la columna Mes (por ejemplo, tabulador/divisor)
    li $v0, 4
    la $a0, mes_suffix
    syscall
 
    # Imprimir la columna "Cuota"
    li $v0, 4
    la $a0, cuota_prefix
    syscall
 
    li $v0, 4
    la $a0, lempiras
    syscall
    li $v0, 2
    mov.s $f12, $f14      # Imprime la cuota (calculada en f14)
    syscall
 
    li $v0, 4
    la $a0, cuota_suffix
    syscall
 
    # Calcular inter�s:
    sub $t7, $t5, 4       # $t7 apunta al �ltimo saldo almacenado
    l.s $f22, 0($t7)      # f22 = saldo actual
 
    mul.s $f16, $f2, $f22  # inter�s = tasa * saldo
 
    # Imprimir la columna "Interes"
    li $v0, 4
    la $a0, interes_prefix
    syscall
 
    li $v0, 4
    la $a0, lempiras
    syscall
    li $v0, 2
    mov.s $f12, $f16
    syscall
 
    li $v0, 4
    la $a0, interes_suffix
    syscall
 
    # Calcular amortizaci�n = cuota - inter�s
    sub.s $f18, $f14, $f16
 
    # Imprimir la columna "Amortizacion"
    li $v0, 4
    la $a0, amortizacion_prefix
    syscall
 
    li $v0, 4
    la $a0, lempiras
    syscall
    li $v0, 2
    mov.s $f12, $f18
    syscall
 
    li $v0, 4
    la $a0, amortizacion_suffix
    syscall
 
    # Calcular saldo = saldo - amortizaci�n
    sub.s $f22, $f22, $f18
 
    # Imprimir la columna "Saldo"
    li $v0, 4
    la $a0, saldo_prefix
    syscall
 
    li $v0, 4
    la $a0, lempiras
    syscall
    li $v0, 2
    mov.s $f12, $f22
    syscall
 
    li $v0, 4
    la $a0, saldo_suffix
    syscall
 
    # Guardar todos los valores en los arreglos
    s.s $f14, 0($t3)   # Guardar la cuota en el arreglo de Amortizacion
    addi $t3, $t3, 4   # Incrementar el puntero del arreglo de Amortizacion
    addi $t2, $t2, 1   # Incrementar el contador de elementos en el arreglo de Amortizacion
 
    s.s $f16, 0($t1)   # Guardar el inter�s en el arreglo de Interes
    addi $t1, $t1, 4   # Incrementar el puntero del arreglo de Interes
    addi $t0, $t0, 1   # Incrementar el contador de elementos en el arreglo de Interes
 
    s.s $f22, 0($t5)   # Guardar el nuevo saldo en el arreglo de Saldo
    addi $t5, $t5, 4   # Incrementar el puntero del arreglo de Saldo
    addi $t4, $t4, 1   # Incrementar el contador de elementos en el arreglo de Saldo
 
    # Imprimir el divisor de la tabla
    li $v0, 4
    la $a0, tableDiv
    syscall
 
    # Imprimir salto de l�nea
    li $v0, 4
    la $a0, new_line
    syscall
 
    # Incrementar contador de meses y repetir
    addi $s0, $s0, 1
    j induccionLempiras

calcularSumatoriasLempiras:
    # Reiniciar punteros
    la $t1, Interes
    la $t3, Amortizacion
    la $t5, Saldo

    # Inicializar acumuladores a cero
    mtc1 $zero, $f20
    cvt.s.w $f20, $f20  # SumaInteresLPS
    mtc1 $zero, $f21
    cvt.s.w $f21, $f21  # SumaCuotaLPS
    mtc1 $zero, $f22
    cvt.s.w $f22, $f22  # SumaAmortizacionLPS
    mtc1 $zero, $f23
    cvt.s.w $f23, $f23  # SumaSaldoLPS

    # Sumar intereses
    li $t7, 0
sum_interes_loop:
    bge $t7, $t0, end_sum_interes
    l.s $f12, 0($t1)
    add.s $f20, $f20, $f12
    addi $t1, $t1, 4
    addi $t7, $t7, 1
    j sum_interes_loop
end_sum_interes:
    s.s $f20, SumaInteresLPS

    # Sumar cuotas (que son iguales a amortizaciones en este caso)
    li $t7, 0
sum_amort_loop:
    bge $t7, $t2, end_sum_amort
    l.s $f12, 0($t3)
    add.s $f21, $f21, $f12
    addi $t3, $t3, 4
    addi $t7, $t7, 1
    j sum_amort_loop
end_sum_amort:
    s.s $f21, SumaCuotaLPS
    s.s $f21, SumaAmortizacionLPS

    # Sumar saldos
    li $t7, 0
sum_saldo_loop:
    bge $t7, $t4, end_sum_saldo
    l.s $f12, 0($t5)
    add.s $f22, $f22, $f12
    addi $t5, $t5, 4
    addi $t7, $t7, 1
    j sum_saldo_loop
end_sum_saldo:
    s.s $f22, SumaSaldoLPS

    # Imprimir sumatorias
    li $v0, 4
    la $a0, suma_cuota_lps
    syscall
    li $v0, 4
    la $a0, lempiras
    syscall
    li $v0, 2
    l.s $f12, SumaCuotaLPS
    syscall

    li $v0, 4
    la $a0, suma_interes_lps
    syscall
    li $v0, 4
    la $a0, lempiras
    syscall
    li $v0, 2
    l.s $f12, SumaInteresLPS
    syscall

    li $v0, 4
    la $a0, suma_amort_lps
    syscall
    li $v0, 4
    la $a0, lempiras
    syscall
    li $v0, 2
    l.s $f12, SumaAmortizacionLPS
    syscall

    li $v0, 4
    la $a0, suma_saldo_lps
    syscall
    li $v0, 4
    la $a0, lempiras
    syscall
    li $v0, 2
    l.s $f12, SumaSaldoLPS
    syscall

    j generarTablaDolares
 
generarTablaDolares:
    li   $t0, 0         # Reinicia contador de Inter�s
    la   $t1, Interes   # Reinicia puntero de Inter�s
 
    li   $t2, 0         # Reinicia contador de Amortizacion
    la   $t3, Amortizacion # Reinicia puntero de Amortizacion
 
    li   $t4, 0         # Reinicia contador de Saldo
    la   $t5, Saldo     # Reinicia puntero de Saldo
 
    li $s0, 0 
 
    li $v0, 4
    la $a0, hashtags
    syscall
 
    li $v0, 4
    la $a0, headerTablaDolares 
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
 
    # Poner dollar_rate en f20
    l.s $f20, dollar_rate
 
    # Imprimir la fila 0 
    li $v0, 4
    la $a0, row0_prefix
    syscall
 
    li $v0, 1
    move $a0, $s0
    syscall
 
    li $v0, 4
    la $a0, row0_rest
    syscall
 
    # Convertir el monto inicial a d�lares y mostrarlo:
    li $v0, 4
    la $a0, dolares
    syscall
    div.s $f12, $f4, $f20
    li $v0, 2
    syscall
 
    li $v0, 4
    la $a0, tableDiv
    syscall
 
    addi $s0, $s0, 1    # Incrementar el contador de meses
    addi $t5, $t5, 4    # Avanza el puntero de Saldo para la siguiente fila
    j induccionDolares
 
induccionDolares:
    bgt $s0, $t6, calcularSumatoriasDolares   # Si se han procesado todos los meses, calcular sumatorias
 
    # Cargar dollar_rate en $f20
    l.s $f20, dollar_rate
 
    # Imprimir la fila del mes:
    li $v0, 4
    la $a0, row0_prefix
    syscall
 
    li $v0, 1
    move $a0, $s0         # Imprime el n�mero del mes
    syscall
 
    li $v0, 4
    la $a0, mes_suffix
    syscall
 
    # Columna "Cuota": Cargar la cuota en lempiras desde el arreglo y convertir a d�lares.
    li $v0, 4
    la $a0, cuota_prefix
    syscall
 
    li $v0, 4
    la $a0, dolares
    syscall
    l.s $f14, 0($t3)      # Cargar cuota (en lempiras) para este mes desde el arreglo
    div.s $f15, $f14, $f20  # Convertir a d�lares: f15 = cuota / dollar_rate
    li $v0, 2
    mov.s $f12, $f15
    syscall
 
    li $v0, 4
    la $a0, cuota_suffix
    syscall
 
    # Columna "Interes": Cargar inter�s (en lempiras) desde el arreglo y convertir a d�lares.
    li $v0, 4
    la $a0, interes_prefix
    syscall
 
    li $v0, 4
    la $a0, dolares
    syscall
    l.s $f16, 0($t1)      # Cargar inter�s en lempiras para este mes
    div.s $f15, $f16, $f20  # Convertir a d�lares: f15 = inter�s / dollar_rate
    li $v0, 2
    mov.s $f12, $f15
    syscall
 
    li $v0, 4
    la $a0, interes_suffix
    syscall
 
    # Columna "Amortizacion": Cargar amortizaci�n (en lempiras) desde el arreglo y convertir a d�lares.
    li $v0, 4
    la $a0, amortizacion_prefix
    syscall
 
    li $v0, 4
    la $a0, dolares
    syscall
    l.s $f14, 0($t3)      # cuota en lempiras
    l.s $f16, 0($t1)      # inter�s en lempiras
    sub.s $f18, $f14, $f16   # amortizaci�n en lempiras
    div.s $f15, $f18, $f20   # convertir a d�lares
    li $v0, 2
    mov.s $f12, $f15
    syscall
 
    li $v0, 4
    la $a0, amortizacion_suffix
    syscall
 
    # Columna "Saldo": Cargar saldo (en lempiras) desde el arreglo y convertir a d�lares.
    li $v0, 4
    la $a0, saldo_prefix
    syscall
 
    li $v0, 4
    la $a0, dolares
    syscall
    l.s $f22, 0($t5)      # Cargar saldo en lempiras para este mes
    div.s $f15, $f22, $f20   # Convertir a d�lares: f15 = saldo / dollar_rate
    li $v0, 2
    mov.s $f12, $f15
    syscall
 
    li $v0, 4
    la $a0, saldo_suffix
    syscall
 
    # Imprimir el divisor y salto de l�nea
    li $v0, 4
    la $a0, tableDiv
    syscall
    li $v0, 4
    la $a0, new_line
    syscall
 
    # Incrementar los punteros de cada arreglo para pasar al siguiente mes
    addi $t3, $t3, 4   # Siguiente cuota
    addi $t1, $t1, 4   # Siguiente inter�s
    addi $t5, $t5, 4   # Siguiente saldo
 
    addi $s0, $s0, 1   # Incrementar contador de meses
    j induccionDolares

calcularSumatoriasDolares:
    # Convertir sumatorias de Lempiras a D�lares
    l.s $f20, SumaCuotaLPS
    l.s $f21, SumaInteresLPS
    l.s $f22, SumaAmortizacionLPS
    l.s $f23, SumaSaldoLPS
    l.s $f24, dollar_rate

    div.s $f20, $f20, $f24  # SumaCuotaUSD
    div.s $f21, $f21, $f24  # SumaInteresUSD
    div.s $f22, $f22, $f24  # SumaAmortizacionUSD
    div.s $f23, $f23, $f24  # SumaSaldoUSD

    s.s $f20, SumaCuotaUSD
    s.s $f21, SumaInteresUSD
    s.s $f22, SumaAmortizacionUSD
    s.s $f23, SumaSaldoUSD

    # Imprimir sumatorias en d�lares
    li $v0, 4
    la $a0, suma_cuota_usd
    syscall
    li $v0, 4
    la $a0, dolares
    syscall
    li $v0, 2
    l.s $f12, SumaCuotaUSD
    syscall

    li $v0, 4
    la $a0, suma_interes_usd
    syscall
    li $v0, 4
    la $a0, dolares
    syscall
    li $v0, 2
    l.s $f12, SumaInteresUSD
    syscall

    li $v0, 4
    la $a0, suma_amort_usd
    syscall
    li $v0, 4
    la $a0, dolares
    syscall
    li $v0, 2
    l.s $f12, SumaAmortizacionUSD
    syscall

    li $v0, 4
    la $a0, suma_saldo_usd
    syscall
    li $v0, 4
    la $a0, dolares
    syscall
    li $v0, 2
    l.s $f12, SumaSaldoUSD
    syscall

    j preguntar_reinicio

preguntar_reinicio:
    li $v0, 4
    la $a0, prompt_reinicio
    syscall

    li $v0, 8
    la $a0, buffer_input
    li $a1, 80
    syscall

    # Procesar respuesta
    la $a0, buffer_input
    jal upper_case
    jal remove_newline

    # Comparar con "SI"
    la $a0, buffer_input
    la $a1, str_si
    jal strcmp
    beq $v0, $zero, main  # Si es "SI", reiniciar

    # Comparar con "NO"
    la $a0, buffer_input
    la $a1, str_no
    jal strcmp
    beq $v0, $zero, exit_prog  # Si es "NO", salir

    # Si no es ninguna de las dos, volver a preguntar
    j preguntar_reinicio

#-------------------------------------------
# Rutina clear_buffer: Limpia un buffer de memoria
clear_buffer:
    li $t9, 0
clear_loop:
    sb $zero, 0($a0)
    addi $a0, $a0, 1
    addi $t9, $t9, 1
    blt $t9, 80, clear_loop
    jr $ra

#-------------------------------------------
# Rutina upper_case: Convierte un string a may�sculas
upper_case:
    move $t9, $a0
upper_loop:
    lb $t7, 0($t9)
    beqz $t7, end_upper
    li $t8, 'a'
    blt $t7, $t8, not_lower
    li $t8, 'z'
    bgt $t7, $t8, not_lower
    addi $t7, $t7, -32   # Convertir a may�scula
    sb $t7, 0($t9)
not_lower:
    addi $t9, $t9, 1
    j upper_loop
end_upper:
    jr $ra
 
#-------------------------------------------
# Rutina remove_newline: Elimina el car�cter '\n' (ASCII 10)
remove_newline:
    lb $t6, 0($a0)
    beqz $t6, rn_exit
    li $t7, 10
    beq $t6, $t7, rn_replace
    addi $a0, $a0, 1
    j remove_newline
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