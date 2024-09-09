.data
prompt:    .asciiz "Ingrese la cantidad de números de la serie Fibonacci que desea generar:\n"  # Solicita la cantidad de números
newline:   .asciiz "\n"           # Salto de línea para formateo
fibo_msg:  .asciiz "La serie Fibonacci es:\n"  # Mensaje que indica la serie
sum_msg:   .asciiz "\nLa suma de la serie es: " # Mensaje que indica la suma de la serie

.text
.globl main

main:
    # Solicitar al usuario cuántos números de la serie Fibonacci desea generar
    la $a0, prompt       # Cargar mensaje en $a0
    li $v0, 4            # Código para imprimir cadena
    syscall

    li $v0, 5            # Código para leer un entero (número de términos)
    syscall
    move $t0, $v0        # Guardar la cantidad ingresada en $t0

    # Imprimir el mensaje de la serie Fibonacci
    la $a0, fibo_msg
    li $v0, 4
    syscall

    # Inicializar valores de la serie Fibonacci
    li $t1, 0           # F0 = 0 (primer término)
    li $t2, 1           # F1 = 1 (segundo término)
    li $t3, 0           # Suma de la serie (inicialmente 0)
    move $t4, $t0       # Guardar el número total de términos en $t4

    # Verificar si la cantidad es mayor a 0, si es así imprimir el primer número (F0)
    bgtz $t4, print_f0  # Si $t4 > 0, imprimir el primer número (0)
    j end_program       # Si no, terminar el programa

print_f0:
    # Imprimir el primer número de la serie (0)
    li $a0, 0           # Primer número de la serie es 0
    li $v0, 1           # Código para imprimir entero
    syscall

    # Agregar F0 (0) a la suma
    add $t3, $t3, $t1   # t3 = t3 + F0 (0)

    # Imprimir el segundo número si la cantidad es mayor a 1
    li $a0, 1           # Segundo número de la serie es 1
    bgtz $t0, print_f1  # Si $t0 > 1, imprimir el segundo número

print_f1:
    # Imprimir el segundo número de la serie (1)
    la $a0, newline     # Salto de línea entre los números
    li $v0, 4
    syscall

    move $a0, $t2       # Pasar el segundo número de la serie (1) para imprimir
    li $v0, 1           # Código para imprimir entero
    syscall

    # Agregar F1 (1) a la suma
    add $t3, $t3, $t2   # t3 = t3 + F1 (1)

    # Inicializar contador para los siguientes términos
    li $t5, 2           # Iniciar el contador de términos en 2 (ya se imprimieron 0 y 1)

    # Bucle para generar y mostrar la serie Fibonacci
fib_loop:
    # Verificar si se han generado suficientes términos
    bge $t5, $t0, print_sum  # Si el contador llega a $t0, saltar a imprimir la suma

    # Calcular el siguiente término de la serie (F_n = F_(n-1) + F_(n-2))
    add $t6, $t1, $t2   # t6 = F_(n-1) + F_(n-2)

    # Imprimir el siguiente número de la serie
    la $a0, newline     # Salto de línea entre los números
    li $v0, 4
    syscall

    move $a0, $t6       # Pasar el siguiente número para imprimir
    li $v0, 1
    syscall

    # Agregar el siguiente término a la suma
    add $t3, $t3, $t6   # t3 = t3 + F_n

    # Actualizar valores para la siguiente iteración
    move $t1, $t2       # F_(n-2) = F_(n-1)
    move $t2, $t6       # F_(n-1) = F_n
    addi $t5, $t5, 1    # Incrementar contador

    j fib_loop          # Repetir el ciclo

print_sum:
    # Imprimir el mensaje de la suma
    la $a0, sum_msg
    li $v0, 4
    syscall

    # Imprimir la suma de la serie
    move $a0, $t3       # Pasar la suma para imprimir
    li $v0, 1
    syscall

end_program:
    # Finalizar el programa
    li $v0, 10          # Código para terminar el programa
    syscall
