size = 4
.data
matriz: .space 400
n1: .word 0
n2: .word 0
msg1: .asciiz "Introduzca por favor el n de cols y el n de filas "
msg2: .asciiz "Introduzca un numero: "
.text

main:

    la $t3,matriz

    li $v0,4
    la $a0,msg1
    syscall

    li $v0,5
    syscall
    sw $v0,n1

    li $v0,5
    syscall
    sw $v0,n2

    lw $s0,n1
    lw $s1,n2
    mul $t0,$s0,$s1
    mul $t0,$t0,size
    bgt $t0,400,fin_for
    li $t1,0
    sub $t0,$t0,4
    for:
    bgt $t1,$t0,fin_for

    li $v0,4
    la $a0,msg2
    syscall
    li $v0,5
    syscall
    sw $v0,matriz($t1)
    
    addi $t1,$t1,size

    j for

    fin_for:
    

    li $v0,10
    syscall