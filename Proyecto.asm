.data
    .align 2 
    Interes:      .space 960       # Arreglo para el interés del préstamo 
    Amortizacion: .space 960       # Arreglo para la amortización del préstamo
    Saldo:        .space 960       # Arreglo para el saldo del préstamo
 
    Nombre:       .space 80       # Variable para el nombre del beneficiario
    FormatoPlazo: .space 80       # Variable para el formato del plazo del préstamo    
    Plazo:        .space 80       # Variable para el plazo del préstamo

    zero:.float 0.0
    one:.float 1.0
    hundred: .float 100.0

    menu_header: .asciiz "\t\t\t\t\t\t\t\tMenu de Amortizacion de Prestamos\t\t\t\t\t\t"
    Sms_Menu: .asciiz "\n\nEste es el menu: \n1. Calculo de amortización\n2. Cambiar moneda de tabla \n3. Salir\nIngrese la opcion deseada: "
    Sms_0: .asciiz "Bienvenido a la amortizacion de prestamos!!!!!\n"
    Sms_1: .asciiz "\n- Introduzca el nombre del beneficiario: "
    Sms_2: .asciiz "\n- El plazo del prestamo es en Meses o Años? "
    Sms_3: .asciiz "\n- Ingrese el plazo del prestamo: "
    Sms_4: .asciiz "\n- Ingrese el interes del prestamo en decimal: "
    Sms_5: .asciiz "\n- Ingrese el saldo del prestamo: "
    Sms_6: .asciiz "\n- La tasa de interes es Mensual o Anual? "
    
    Sms_7: .asciiz "La suma de todas las cuotas es: "
    Sms_8: .asciiz "La suma de todos los intereses es: "
    Sms_9: .asciiz "La suma de todas las amortizaciones es: "
    Sms_10: .asciiz "El saldo final es: "

    Sms_11: .asciiz "\n(El interes valido para el plazo de 0 a 12 meses es de 25% (0.25) a 40% (0.40))"
    Sms_12: .asciiz "\n(El interes valido para el plazo de 12 a 24 meses es de 15% (0.15) a 30% (0.30) )"
    Sms_13: .asciiz "\n(El interes valido para el plazo de 24 a 240 meses es de 10% (0.10) a 25% (0.25) )"
    
    Sms_ErrorMenu:, .asciiz "\nError: Opcion no valida. Intente de nuevo\n"
    Sms_ErrorPlazo: .asciiz "Error: el prestamo no puede exceder de 240 meses o 20 años.\n"
    Sms_ErrorInteresNegativo: .asciiz "Error: el interes no puede ser negativo.\n"
    Sms_ErrorInteres: .asciiz "\nError: el interes no es valido para el plazo ingresado. Intente de nuevo\n"
    Sms_ErrorMonto: .asciiz "Error: el monto del prestamo no puede ser negativo.\n"
    Sms_ErrorFormato: .asciiz "Error: el formato del plazo no es correcto.\n"
    Sms_ErrorNombre: .asciiz "Error: el nombre no puede estar vacío.\n"

    Sms_Monedas: .asciiz "\n#########################################\n         Opcion de monedas!\n#########################################\nSeleccione la moneda para la tabla 2 de amortización:\n1. Dolares\n2. Euros\n3. Libras Esterlinas\n4. Francos Suizos\n5. Dolares Australianos\n6. Volver al menu principal\nIngrese la opción deseada: "

    Porcentaje: .asciiz "%"
    Espacio: .asciiz " "
 
    MesesStr: .asciiz "Meses"
    AnosStr:  .asciiz "Años"
    SalirStr: .asciiz "Salir"
 
    # Cadenas para imprimir la información recopilada
    input_header: .asciiz "\t\t\t\t\t\t\tRecopilación de información del prestamo\t\t\t\t\t\t"
    info_header:  .asciiz "\t\t\t\t\t\t\tInformación recopilada\t\t\t\t\t\t\t"
    info_name:    .asciiz "Nombre: "
    info_plazo:   .asciiz "Plazo: "
    info_interes: .asciiz "Interes: "
    info_monto:   .asciiz "Monto del prestamo: "
    info_cuota:   .asciiz "Cuota: "
 
    hashtags:   .asciiz "\n########################################################################################################################################################\n"
    headerTablaLempiras: .asciiz "\t\t\t\t\t\t\tTabla de amortizacion en Lempiras"
    headerTablaDolares:  .asciiz "\t\t\t\t\t\t\tTabla de amortizacion en "
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
 
    dollar_rate: .float 25.5775   # 1 Dólar = 25.58 LPS 30-03-2025
    euro_rate:   .float 27.7209   # 1 Euro = 27.73 LPS 30-03-2025
    libra_rate:  .float 33.1599   # 1 Libra Esterlina = 33.17 LPS 30-03-2025
    franco_rate: .float 29.1001   # 1 Franco Suizo = 29.11 LPS 30-03-2025
    aud_rate:    .float 16.0921   # 1 Dólar Australiano = 16.0921 LPS 30-03-2025

    lempiras: .asciiz ".LPS"
    dolares:  .asciiz "$"
    euro:   .asciiz "€"
    libra:  .asciiz "£"
    franco: .asciiz "CHF"
    aud:    .asciiz "A$"

    dolaresString: .asciiz "Dolares"
    eurosString:   .asciiz "Euros"
    librasString:  .asciiz "Libras Esterlinas"
    francosString: .asciiz "Franco Suizo"
    audString:     .asciiz "Dolares Australianos"

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

    # Establecer moneda por defecto: Dólares
    l.s   $f20, dollar_rate   
    mfc1  $s5, $f20           # Guarda factor de dolares en $s5
    la    $s6, dolares        # Guarda $ en $s6
    la    $s7, dolaresString  # Guarda nombre de la moneda en $s7

    j menu

menu:
    li $v0, 4
    la $a0, hashtags
    syscall

    li $v0, 4
    la $a0, menu_header
    syscall

    li $v0, 4
    la $a0, hashtags
    syscall

    li $v0, 4
    la $a0, Sms_Menu
    syscall

    li $v0, 5
    syscall
    move $s2, $v0

    beq $s2, 1, resetArreglos
    beq $s2, 2, opcion2menu # por mientras
    beq $s2, 3, exit_prog 

    j menuMismatch

menuMismatch:
    li $v0, 4
    la $a0, Sms_ErrorMenu
    syscall

    j menu

opcion2menu:
    #imprimir diferntes monedas"
    li $v0, 4
    la $a0, Sms_Monedas
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    li $t1, 1
    beq $t0, $t1, opcion_dolares
    li $t1, 2
    beq $t0, $t1, opcion_euros
    li $t1, 3
    beq $t0, $t1, opcion_libras
    li $t1, 4
    beq $t0, $t1, opcion_francos
    li $t1, 5
    beq $t0, $t1, opcion_aud
    li $t1, 6
    beq $t0, $t1, menu 

    j opcion2menuMismatch          # Si la opción no es válida, reimprimir menú

opcion_dolares:
    l.s   $f20, dollar_rate   # Factor para Dólar
    mfc1  $s5, $f20            
    la    $s6, dolares        # Símbolo "$"
    la    $s7, dolaresString   # Nombre de la moneda
    
    j menu

opcion_euros:
    l.s   $f20, euro_rate      # Factor para Euro
    mfc1  $s5, $f20
    la    $s6, euro            # Símbolo "€"
    la    $s7, eurosString      # Nombre de la moneda

    j menu

opcion_libras:
    l.s   $f20, libra_rate     # Factor para Libra Esterlina
    mfc1  $s5, $f20
    la    $s6, libra           # Símbolo "£"
    la    $s7, librasString     # Nombre de la moneda

    j menu

opcion_francos:
    l.s   $f20, franco_rate    # Factor para Franco Suizo
    mfc1  $s5, $f20
    la    $s6, franco          # Símbolo "CHF"
    la    $s7, francosString   # Nombre de la moneda

    j menu

opcion_aud:
    l.s   $f20, aud_rate       # Factor para Dólar Australiano
    mfc1  $s5, $f20
    la    $s6, aud             # Símbolo "A$"
    la    $s7, audString       # Nombre de la moneda

    j menu

opcion2menuMismatch:
    li $v0, 4
    la $a0, Sms_ErrorMenu
    syscall

    j opcion2menu


resetArreglos:
    # Reiniciar los arreglos
    li   $t0, 0         # contador de elementos en arreglo de Interes
    la   $t1, Interes   # base del arreglo de Intereses

    li   $t2, 0         # contador de elementos en arreglo de Amortizacion
    la   $t3, Amortizacion   # base del arreglo de Amortizaciones

    li   $t4, 0         # contador de elementos en arreglo de Saldo
    la   $t5, Saldo     # base del arreglo de Saldo

    # Reiniciar variables
    li $s3, 0           # Flag para indicar el formato del plazo (0 = Meses, 1 = Años)
    li $s4, 0           # Variable para almacenar el plazo original (en meses o años)
    li $s0, 0           # Contador de meses (inicializado a 0)
    li $s1, 0           # Variable para almacenar la cuota

    l.s $f24, zero        # Reiniciar sumatoria de cuotas
    l.s $f26, zero        # Reiniciar sumatoria de intereses
    l.s $f28, zero       # Reiniciar sumatoria de amortizaciones
    l.s $f30, zero       # Reiniciar sumatoria de saldos
    
    j nombre_input


# Pedir el nombre del beneficiario 
nombre_input:
    li $v0, 4
    la $a0, hashtags
    syscall

    li $v0, 4
    la $a0, input_header
    syscall

    li $v0, 4
    la $a0, hashtags
    syscall

    li $v0, 4
    la $a0, Sms_1
    syscall

    li $v0, 8            
    la $a0, Nombre       
    li $a1, 80           
    syscall

    # Revisar si el nombre está vacío
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
# Bucle para pedir el interés del préstamo
loop_interes:
    # Determinar el rango de interés según el plazo en meses
    li $t9, 12
    blt $t6, $t9, interes_rango_corto
    li $t9, 25
    blt $t6, $t9, interes_rango_medio
    j interes_rango_largo

interes_rango_corto:
    li $v0, 4
    la $a0, Sms_11
    syscall

    li $t8, 25
    mtc1 $t8, $f10
    cvt.s.w $f10, $f10
    l.s $f1, hundred
    div.s $f10, $f10, $f1   # f10 = 0.25

    li $t8, 40
    mtc1 $t8, $f12
    cvt.s.w $f12, $f12
    div.s $f12, $f12, $f1   # f12 = 0.40

    j pedir_interes

interes_rango_medio:
    li $v0, 4
    la $a0, Sms_12
    syscall

    li $t8, 15
    mtc1 $t8, $f10
    cvt.s.w $f10, $f10
    l.s $f1, hundred
    div.s $f10, $f10, $f1   # f10 = 0.15

    li $t8, 30
    mtc1 $t8, $f12
    cvt.s.w $f12, $f12
    div.s $f12, $f12, $f1   # f12 = 0.30

    j pedir_interes

interes_rango_largo:
    li $v0, 4
    la $a0, Sms_13
    syscall

    li $t8, 10
    mtc1 $t8, $f10
    cvt.s.w $f10, $f10
    l.s $f1, hundred
    div.s $f10, $f10, $f1   # f10 = 0.10

    li $t8, 25
    mtc1 $t8, $f12
    cvt.s.w $f12, $f12
    div.s $f12, $f12, $f1   # f12 = 0.25

    j pedir_interes

# Aquí empieza el ciclo que valida que el interés esté en el rango
pedir_interes:
    li $v0, 4
    la $a0, Sms_4         # "Ingrese el interes del prestamo en decimal: "
    syscall

    li $v0, 6             # Leer float
    syscall
    mov.s $f2, $f0        # Guardar el interés en $f2

    # Verificar si el interés es negativo
    li $at, 0
    mtc1 $at, $f6
    cvt.s.w $f6, $f6
    c.lt.s $f2, $f6
    bc1t error_interesNegativo

    # Verificar si está dentro del rango permitido
    c.lt.s $f2, $f10      # interés < mínimo
    bc1t error_interes

    c.lt.s $f12, $f2      # interés > máximo
    bc1t error_interes

    j continue_interest_ok

error_interesNegativo:
    li $v0, 4
    la $a0, Sms_ErrorInteresNegativo
    syscall
    j pedir_interes

error_interes:
    li $v0, 4
    la $a0, Sms_ErrorInteres
    syscall
    j pedir_interes


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
    j loop_monto


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
    la $a0, hashtags
    syscall

    li $v0, 4
    la $a0, info_header
    syscall

    li $v0, 4
    la $a0, hashtags
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

    #sumar a f30 (sumatoria de saldos)
    add.s $f30, $f30, $f4
 
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

    l.s $f0, one         # $f0 = 1.0 (cargado de datos)
    l.s $f8, one         # $f8 = 1.0, se usará como acumulador para (1+i)^n

    add.s $f10, $f0, $f2  # $f10 = 1.0 + i

    move $t7, $t6        # $t7 = n

power_loop:
    blez $t7, power_done   # Si n <= 0, salir del bucle
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
    bgt $s0, $t6, imprimirSumatoriasLempiras
 
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

    #sumar a f24 (sumatoria de cuotas)
    add.s $f24, $f24, $f14

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

    #sumar a f26 (sumatoria de intereses)
    add.s $f26, $f26, $f16

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

    #sumar a f28 (sumatoria de amortizaciones)
    add.s $f28, $f28, $f18

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

    #sumar a f30 (sumatoria de saldos)
    add.s $f30, $f30, $f22

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

imprimirSumatoriasLempiras:
    # Imprimir sumatorias
    li $v0, 4
    la $a0, Sms_7
    syscall
    li $v0, 2
    mov.s $f12, $f24
    syscall
    li $v0, 4
    la $a0, lempiras
    syscall

    li $v0, 4
    la $a0, new_line
    syscall

    li $v0, 4
    la $a0, Sms_8
    syscall
    li $v0, 2
    mov.s $f12, $f26
    syscall
    li $v0, 4
    la $a0, lempiras
    syscall

    li $v0, 4
    la $a0, new_line
    syscall

    li $v0, 4
    la $a0, Sms_9
    syscall
    li $v0, 2
    mov.s $f12, $f28
    syscall
    li $v0, 4
    la $a0, lempiras
    syscall

    li $v0, 4
    la $a0, new_line
    syscall

    j generarTablaDolares

 
generarTablaDolares:
    li   $t0, 0         # Reinicia contador de Interés
    la   $t1, Interes   # Reinicia puntero de Interés

    li   $t2, 0         # Reinicia contador de Amortizacion
    la   $t3, Amortizacion   # Reinicia puntero de Amortizacion

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
    move $a0, $s7       
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

    # En lugar de cargar dollar_rate, cargamos el factor almacenado en $s5:
    mtc1 $s5, $f20

    # Imprimir la fila 0 
    li $v0, 4
    la $a0, row0_prefix
    syscall

    # Imprimir el contador de meses (columna "Mes")
    li $v0, 1
    move $a0, $s0
    syscall

    li $v0, 4
    la $a0, row0_rest
    syscall

    # Convertir el monto inicial a la moneda seleccionada y mostrarlo:
    div.s $f12, $f4, $f20
    li $v0, 2
    syscall

    # Imprimir el símbolo de la moneda seleccionada
    li $v0, 4
    move $a0, $s6
    syscall

    li $v0, 4
    la $a0, tableDiv
    syscall

    addi $s0, $s0, 1    # Incrementar el contador de meses
    addi $t5, $t5, 4    # Avanza el puntero de Saldo para la siguiente fila
    j induccionDolares

induccionDolares:
    bgt $s0, $t6, imprimirSumatoriasDolares   # Si se han procesado todos los meses, termina

    # Cargar el factor almacenado en $s5 en $f20:
    mtc1 $s5, $f20

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

    # Columna "Cuota": convertir la cuota almacenada en el arreglo a la moneda seleccionada.
    li $v0, 4
    la $a0, cuota_prefix
    syscall

    l.s $f14, 0($t3)      # Cargar cuota (en LPS) para este mes
    div.s $f15, $f14, $f20  # Convertir: cuota en moneda = cuota / factor
    li $v0, 2
    mov.s $f12, $f15
    syscall

    li $v0, 4
    move $a0, $s6
    syscall

    li $v0, 4
    la $a0, cuota_suffix
    syscall

    # Columna "Interes": convertir el interés del mes.
    li $v0, 4
    la $a0, interes_prefix
    syscall

    l.s $f16, 0($t1)      # Cargar interés (en LPS) para este mes
    div.s $f15, $f16, $f20  # Convertir a moneda: interés / factor
    li $v0, 2
    mov.s $f12, $f15
    syscall
    li $v0, 4
    move $a0, $s6         # Imprimir el símbolo almacenado en $s6   
    syscall
 

    li $v0, 4
    la $a0, interes_suffix
    syscall

    # Columna "Amortizacion": calcular y convertir la amortización.
    li $v0, 4
    la $a0, amortizacion_prefix
    syscall

    l.s $f14, 0($t3)      # Cuota en LPS
    l.s $f16, 0($t1)      # Interés en LPS
    sub.s $f18, $f14, $f16   # Amortización en LPS
    div.s $f15, $f18, $f20   # Convertir a moneda: amortización / factor
    li $v0, 2
    mov.s $f12, $f15
    syscall
    li $v0, 4
    move $a0, $s6         # Imprimir símbolo de moneda
    syscall

    li $v0, 4
    la $a0, amortizacion_suffix
    syscall

    # Columna "Saldo": convertir el saldo actual.
    li $v0, 4
    la $a0, saldo_prefix
    syscall

    l.s $f22, 0($t5)      # Saldo en LPS para este mes
    div.s $f15, $f22, $f20   # Convertir a moneda: saldo / factor
    li $v0, 2
    mov.s $f12, $f15
    syscall
    li $v0, 4
    move $a0, $s6         # Imprimir símbolo de moneda
    syscall

    li $v0, 4
    la $a0, saldo_suffix
    syscall

    # Guardar los valores en los arreglos:
    s.s $f14, 0($t3)      # Guardar la cuota en el arreglo de Amortizacion
    addi $t3, $t3, 4      # Incrementar puntero de Amortizacion
    addi $t2, $t2, 1      # Incrementar contador de Amortizacion

    s.s $f16, 0($t1)      # Guardar el interés en el arreglo de Interés
    addi $t1, $t1, 4
    addi $t0, $t0, 1      # Incrementar contador de Interés

    s.s $f22, 0($t5)      # Guardar el nuevo saldo en el arreglo de Saldo
    addi $t5, $t5, 4
    addi $t4, $t4, 1      # Incrementar contador de Saldo

    # Imprimir divisor y salto de línea:
    li $v0, 4
    la $a0, tableDiv
    syscall
    li $v0, 4
    la $a0, new_line
    syscall

    # Incrementar contador de meses y repetir:
    addi $s0, $s0, 1
    j induccionDolares

imprimirSumatoriasDolares:
    # Cargar el factor almacenado en $s5:
    mtc1 $s5, $f20

    # Imprimir sumatoria de cuotas
    li $v0, 4
    la $a0, Sms_7
    syscall
    div.s $f12, $f24, $f20   # Convertir a moneda: sumatoria de cuotas / factor
    li $v0, 2
    syscall
    li $v0, 4
    move $a0, $s6         # Imprimir símbolo de moneda
    syscall

    li $v0, 4
    la $a0, new_line
    syscall

    # Imprimir sumatoria de intereses
    li $v0, 4
    la $a0, Sms_8
    syscall
    div.s $f12, $f26, $f20   # Convertir a moneda: sumatoria de intereses / factor
    li $v0, 2
    syscall
    li $v0, 4
    move $a0, $s6         # Imprimir símbolo de moneda
    syscall

    li $v0, 4
    la $a0, new_line
    syscall

    # Imprimir la sumatoria de amortizaciones
    li $v0, 4
    la $a0, Sms_9
    syscall
    div.s $f12, $f28, $f20   # Convertir a moneda: sumatoria de amortizaciones / factor
    li $v0, 2
    syscall
    li $v0, 4
    move $a0, $s6         # Imprimir símbolo de moneda
    syscall

    li $v0, 4
    la $a0, new_line
    syscall

    # Imprimir la sumatoria de saldos
    li $v0, 4
    la $a0, Sms_10
    syscall
    div.s $f12, $f30, $f20   # Convertir a moneda: sumatoria de saldos / factor
    li $v0, 2
    syscall
    li $v0, 4
    move $a0, $s6         # Imprimir símbolo de moneda
    syscall
    
    li $v0, 4
    la $a0, new_line
    syscall

    j menu

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