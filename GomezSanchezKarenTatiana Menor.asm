.data
prompt1: .asciiz "Ingrese el primer número:"  # Mensaje para solicitar el primer número al usuario
prompt2: .asciiz "Ingrese el segundo número:" # Mensaje para solicitar el segundo número al usuario
prompt3: .asciiz "Ingrese el tercer número:"  # Mensaje para solicitar el tercer número al usuario
result:  .asciiz "El número menor es:"        # Mensaje para mostrar el resultado (el menor número)

.text
.globl main  # Define el punto de entrada del programa

main:
    # Imprimir mensaje solicitando el primer número
    li $v0, 4              # Llamada al sistema para imprimir una cadena (código 4)
    la $a0, prompt1         # Carga la dirección del mensaje "Ingrese el primer número" en $a0
    syscall                 # Realiza la impresión del mensaje
    
    # Leer el primer número desde la entrada
    li $v0, 5              # Llamada al sistema para leer un entero (código 5)
    syscall                 # Realiza la lectura desde la entrada estándar
    move $t0, $v0           # Almacena el número leído en el registro $t0
    
    # Imprimir mensaje solicitando el segundo número
    li $v0, 4              # Llamada al sistema para imprimir una cadena (código 4)
    la $a0, prompt2         # Carga la dirección del mensaje "Ingrese el segundo número" en $a0
    syscall                 # Realiza la impresión del mensaje
    
    # Leer el segundo número desde la entrada
    li $v0, 5              # Llamada al sistema para leer un entero (código 5)
    syscall                 # Realiza la lectura desde la entrada estándar
    move $t1, $v0           # Almacena el número leído en el registro $t1
    
    # Imprimir mensaje solicitando el tercer número
    li $v0, 4              # Llamada al sistema para imprimir una cadena (código 4)
    la $a0, prompt3         # Carga la dirección del mensaje "Ingrese el tercer número" en $a0
    syscall                 # Realiza la impresión del mensaje
    
    # Leer el tercer número desde la entrada
    li $v0, 5              # Llamada al sistema para leer un entero (código 5)
    syscall                 # Realiza la lectura desde la entrada estándar
    move $t2, $v0           # Almacena el número leído en el registro $t2

    # Encontrar el número menor entre los tres
    move $t3, $t0           # Asume que el primer número ($t0) es el menor y lo guarda en $t3
    bge $t1, $t3, check_t1  # Si $t1 es mayor o igual a $t3, salta a la etiqueta check_t1
    move $t3, $t1           # Si $t1 es menor que $t3, actualiza $t3 con el valor de $t1
    
check_t1:
    bge $t2, $t3, check_t2  # Si $t2 es mayor o igual a $t3, salta a la etiqueta check_t2
    move $t3, $t2           # Si $t2 es menor que $t3, actualiza $t3 con el valor de $t2
    
check_t2:
    # Imprimir el resultado
    li $v0, 4              # Llamada al sistema para imprimir una cadena (código 4)
    la $a0, result          # Carga la dirección del mensaje "El número menor es:" en $a0
    syscall                 # Imprime el mensaje

    li $v0, 1              # Llamada al sistema para imprimir un entero (código 1)
    move $a0, $t3           # Carga el valor del menor número en $a0 para su impresión
    syscall                 # Imprime el valor del número menor

    # Salir del programa
    li $v0, 10             # Llamada al sistema para finalizar el programa (código 10)
    syscall                 # Termina la ejecución
