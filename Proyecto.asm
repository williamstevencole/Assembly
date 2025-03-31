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
    
    Sms_ErrorPlazo: .asciiz "Error: el prestamo no puede exceder de 240 meses o 20 años.\n"
    Sms_ErrorInteres: .asciiz "Error: el interes no puede ser negativo.\n"
    Sms_ErrorMonto: .asciiz "Error: el monto del prestamo no puede ser negativo.\n"
    Sms_ErrorFormato: .asciiz "Error: el formato del plazo no es correcto.\n"
    Sms_ErrorNombre: .asciiz "Error: el nombre no puede estar vacío.\n"

    Porcentaje: .asciiz "%"
    Espacio: .asciiz " "
 
    MesesStr: .asciiz "Meses"
    AnosStr:  .asciiz "Años"
    SalirStr: .asciiz "Salir"
 
    # Cadenas para imprimir la información recopilada
    info_header:  .asciiz "\nInformación recopilada:\n"
    info_name:    .asciiz "Nombre: "
    info_plazo:   .asciiz "Plazo: "
    info_interes: .asciiz "Interes: "
    info_monto:   .asciiz "Monto del prestamo: "
    info_cuota:   .asciiz "Cuota: "
 
    hashtags:   .asciiz "\n########################################################################################################################################################\n"
    headerTablaLempiras: .asciiz "\t\t\t\t\t\t\tTabla de amortizacion en Lempiras"
    headerTablaDolares:  .asciiz "\t\t\t\t\t\t\tTabla de amortizacion en Dolares"
    ColumnasTabla: .asciiz "\tMes\t|\tCuota\t\t|\t\tInteres\t\t\t\t|\t\tAmortizacion\t\t|\tSaldo\t\t"
 
    # Para la fila 0, definimos dos cadenas:
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
 
    dollar_rate: .float 25.59 #Valor del dolar actual al 19 de marzo del 2025 a las 10:18:50 PM   
 
    lempiras: .asciiz ".LPS"
    dolares:  .asciiz ".USD"
 
.text
.globl main
 
main:
    # Inicializacion
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
nombre_input:
    li $v0, 4
    la $a0, Sms_1
    syscall

    li $v0, 8            
    la $a0, Nombre       
    li $a1, 80           
    syscall

    lb $t7, Nombre      # Revisar el primer carácter
    beqz $t7, error_nombre
    j nombre_ok
error_nombre:
    li $v0, 4
    la $a0, Sms_ErrorNombre
    syscall
    j nombre_input
nombre_ok:
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

    j loop_format

exit_prog:
    li $v0, 10
    syscall

# Si el formato es "Meses", continuar con la entrada del plazo en meses
plazoMeses:
    li $v0, 4
    la $a0, Sms_3
    syscall

    li $v0, 5
    syscall
    move $t6, $v0       # Guardar el plazo ingresado (en meses) en $t6
    move $s4, $v0       # Guardar el valor original en $s4

    # Si el plazo es mayor a 240 meses, mostrar error
    bgt $t6, 240, error_plazo_mes
    li $s3, 0           # Flag = 0: plazo ingresado en meses
    j loop_interes

error_plazo_mes:
    li $v0, 4
    la $a0, Sms_ErrorPlazo
    syscall
    j plazoMeses

# Si el formato es "Años", continuar con la entrada del plazo en años
plazoAnios:
    li $v0, 4
    la $a0, Sms_3
    syscall

    li $v0, 5
    syscall
    move $s4, $v0       # Guardar el valor original (en años) en $s4
    move $t6, $v0       # Guardar el plazo ingresado en $t6
    # Si el plazo es mayor a 20 años, mostrar error
    bgt $t6, 20, error_plazo_anios

    li $s3, 1           # Flag = 1: plazo ingresado en años
    li $s0, 12         # Cargar 12 en $s0
    mul $t6, $t6, $s0   # Convertir el plazo a meses
    j loop_interes

error_plazo_anios:
    li $v0, 4
    la $a0, Sms_ErrorPlazo
    syscall
    j plazoAnios

# Bucle para pedir el interés del préstamo
loop_interes:
    li $v0, 4
    la $a0, Sms_4         # "Ingrese el interes del prestamo en decimal: "
    syscall

    li $v0, 6             # Leer float
    syscall
    mov.s $f2, $f0        # Guardar el interés en $f2

    # Verificar si el interés es negativo
    li $at, 0 # Inicializar $at a 0
    mtc1 $at, $f6  # Cargar 0.0 en $f6
    cvt.s.w $f6, $f6      # f6 = 0.0
    c.lt.s $f2, $f6       # Comparar si f2 < 0
    bc1t error_interes

    j continue_interest_ok
error_interes:
    li $v0, 4
    la $a0, Sms_ErrorInteres
    syscall
    j loop_interes
continue_interest_ok:
    # Si el plazo se ingresó en años (flag = 1), convertir el interés anual a mensual
    li $t0, 1
    beq $s3, $t0, convert_interest
    j loop_monto
convert_interest:
    li $t0, 12
    mtc1 $t0, $f8
    cvt.s.w $f8, $f8
    div.s $f2, $f2, $f8    # Por ejemplo, 0.12/12 = 0.01


loop_monto:
    li $v0, 4
    la $a0, Sms_5         # "Ingrese el saldo del prestamo: "
    syscall

    li $v0, 6             # Leer float
    syscall
    mov.s $f4, $f0        # Guardar el monto en $f4

    li $at, 0
    mtc1 $at, $f6
    cvt.s.w $f6, $f6      # f6 = 0.0
    
    c.lt.s $f4, $f6       # Si monto < 0.0
    bc1t error_monto
   
    j print_info
error_monto:
    li $v0, 4
    la $a0, Sms_ErrorMonto
    syscall
    j loop_monto

 
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
    move $a0, $s4
    syscall
    
    li $t0, 0
    beq $s3, $t0, print_meses

    li $v0, 4
    la $a0, Espacio
    syscall

    li $v0, 4
    la $a0, AnosStr
    syscall
    
    j print_plazo_end

print_meses:
    li $v0, 4
    la $a0, Espacio
    syscall

    li $v0, 4
    la $a0, MesesStr
    syscall

print_plazo_end:
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
    la $a0, Porcentaje
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
    la $a0, lempiras
    syscall
    li $v0, 4
    la $a0, new_line
    syscall

    li $s0, 0        

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
 
    #Imprimir moneda
    li $v0, 4
    la $a0, lempiras
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
    # Verificar si ya se alcanzó o superó el plazo
    bgt $s0, $t6, generarTablaDolares
 
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
 
    li $v0, 2
    mov.s $f12, $f14      # Imprime la cuota (calculada en f14)
    syscall

    #Imprimir moneda
    li $v0, 4
    la $a0, lempiras
    syscall
 
    li $v0, 4
    la $a0, cuota_suffix
    syscall
 
    # Calcular interés:
    # Obtener el saldo actual almacenado en el arreglo (último valor guardado):
    sub $t7, $t5, 4       # $t7 apunta al último saldo almacenado
    l.s $f22, 0($t7)      # f22 = saldo actual
 
    # Calcular interés = tasa * saldo
    mul.s $f16, $f2, $f22
 
    # Imprimir la columna "Interes"
    li $v0, 4
    la $a0, interes_prefix
    syscall
 
    li $v0, 2
    mov.s $f12, $f16
    syscall

     #Imprimir moneda
    li $v0, 4
    la $a0, lempiras
    syscall
 
    li $v0, 4
    la $a0, interes_suffix
    syscall
 
    # Calcular amortización = cuota - interés
    sub.s $f18, $f14, $f16
 
    # Imprimir la columna "Amortizacion"
    li $v0, 4
    la $a0, amortizacion_prefix
    syscall
 
    li $v0, 2
    mov.s $f12, $f18
    syscall

    #Imprimir moneda
    li $v0, 4
    la $a0, lempiras
    syscall
 
    li $v0, 4
    la $a0, amortizacion_suffix
    syscall
 
    # Calcular saldo = saldo - amortización
    sub.s $f22, $f22, $f18
 
    # Imprimir la columna "Saldo"
    li $v0, 4
    la $a0, saldo_prefix
    syscall
 
    li $v0, 2
    mov.s $f12, $f22
    syscall

    #Imprimir moneda
    li $v0, 4
    la $a0, lempiras
    syscall
 
    li $v0, 4
    la $a0, saldo_suffix
    syscall
 
    # Guardar todos los valores en los arreglos
    s.s $f14, 0($t3)   # Guardar la cuota en el arreglo de Amortizacion
    addi $t3, $t3, 4   # Incrementar el puntero del arreglo de Amortizacion
    addi $t2, $t2, 1   # Incrementar el contador de elementos en el arreglo de Amortizacion
 
    s.s $f16, 0($t1)   # Guardar el interés en el arreglo de Interes
    addi $t1, $t1, 4   # Incrementar el puntero del arreglo de Interes
    addi $t0, $t0, 1   # Incrementar el contador de elementos en el arreglo de Interes
 
    s.s $f22, 0($t5)   # Guardar el nuevo saldo en el arreglo de Saldo
    addi $t5, $t5, 4   # Incrementar el puntero del arreglo de Saldo
    addi $t4, $t4, 1   # Incrementar el contador de elementos en el arreglo de Saldo
 
    # Imprimir el divisor de la tabla
    li $v0, 4
    la $a0, tableDiv
    syscall
 
    # Imprimir salto de línea
    li $v0, 4
    la $a0, new_line
    syscall
 
    # Incrementar contador de meses y repetir
    addi $s0, $s0, 1
    j induccionLempiras
 
generarTablaDolares:
    li   $t0, 0         # Reinicia contador de Interés
    la   $t1, Interes   # Reinicia puntero de Interés
 
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
 
    # Poner dollar_rate en f20 (asegúrate de haberlo definido en .data)
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
 
    # Convertir el monto inicial a dólares y mostrarlo:
    div.s $f12, $f4, $f20
    li $v0, 2
    syscall

    li $v0, 4
    la $a0, dolares
    syscall
 
    li $v0, 4
    la $a0, tableDiv
    syscall
 
    addi $s0, $s0, 1    # Incrementar el contador de meses
    addi $t5, $t5, 4    # Avanza el puntero de Saldo para la siguiente fila
    j induccionDolares
 
induccionDolares:
    bgt $s0, $t6, exit_prog   # Si se han procesado todos los meses, termina
 
    # Cargar dollar_rate en $f20
    l.s $f20, dollar_rate
 
    # Imprimir la fila del mes:
    li $v0, 4
    la $a0, row0_prefix
    syscall
 
    li $v0, 1
    move $a0, $s0         # Imprime el número del mes
    syscall
 
    li $v0, 4
    la $a0, mes_suffix
    syscall
 
    # Columna "Cuota": Cargar la cuota en lempiras desde el arreglo y convertir a dólares.
    li $v0, 4
    la $a0, cuota_prefix
    syscall
 
    l.s $f14, 0($t3)      # Cargar cuota (en lempiras) para este mes desde el arreglo
    div.s $f15, $f14, $f20  # Convertir a dólares: f15 = cuota / dollar_rate
    # Imprimir cuota en dólares
    li $v0, 2
    mov.s $f12, $f15
    syscall
    #Imprimir moneda (en dólares)
    li $v0, 4
    la $a0, dolares
    syscall
 
    li $v0, 4
    la $a0, cuota_suffix
    syscall
 
    # Columna "Interes": Cargar interés (en lempiras) desde el arreglo y convertir a dólares.
    li $v0, 4
    la $a0, interes_prefix
    syscall
 
    l.s $f16, 0($t1)      # Cargar interés en lempiras para este mes
    div.s $f15, $f16, $f20  # Convertir a dólares: f15 = interés / dollar_rate
    # Imprimir interés en dólares
    li $v0, 2
    mov.s $f12, $f15
    syscall
    #Imprimir moneda (en dólares)
    li $v0, 4
    la $a0, dolares
    syscall
 
    li $v0, 4
    la $a0, interes_suffix
    syscall
 
    # Columna "Amortizacion": Cargar amortización (en lempiras) desde el arreglo y convertir a dólares.
    li $v0, 4
    la $a0, amortizacion_prefix
    syscall
 
    # Para calcular amortización en dólares, suponemos que se almacena en el arreglo o se puede calcular:
    # Si amortización se calcula como cuota - interés en lempiras, entonces:
    l.s $f14, 0($t3)      # cuota en lempiras
    l.s $f16, 0($t1)      # interés en lempiras
    sub.s $f18, $f14, $f16   # amortización en lempiras
    div.s $f15, $f18, $f20   # convertir a dólares
    # Imprimir amortización en dólares
    li $v0, 2
    mov.s $f12, $f15
    syscall
    #Imprimir moneda (en dólares)
    li $v0, 4
    la $a0, dolares
    syscall
 
    li $v0, 4
    la $a0, amortizacion_suffix
    syscall
 
    # Columna "Saldo": Cargar saldo (en lempiras) desde el arreglo y convertir a dólares.
    li $v0, 4
    la $a0, saldo_prefix
    syscall
 
    l.s $f22, 0($t5)      # Cargar saldo en lempiras para este mes
    div.s $f15, $f22, $f20   # Convertir a dólares: f15 = saldo / dollar_rate
    # Imprimir saldo en dólares
    li $v0, 2
    mov.s $f12, $f15
    syscall
    #Imprimir moneda (en dólares)
    li $v0, 4
    la $a0, dolares
    syscall
    
 
    li $v0, 4
    la $a0, saldo_suffix
    syscall
 
    # Imprimir el divisor y salto de línea
    li $v0, 4
    la $a0, tableDiv
    syscall
    li $v0, 4
    la $a0, new_line
    syscall
 
    # Incrementar los punteros de cada arreglo para pasar al siguiente mes
    addi $t3, $t3, 4   # Siguiente cuota
    addi $t1, $t1, 4   # Siguiente interés
    addi $t5, $t5, 4   # Siguiente saldo
 
    addi $s0, $s0, 1   # Incrementar contador de meses
    j induccionDolares
 
 
 
 
 
 
 
 
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