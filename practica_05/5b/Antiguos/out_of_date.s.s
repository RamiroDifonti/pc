

size=4

    .data

matrix: .space 120
titulo: .asciiz "Introduzca opcion. <1> Iterativa <2> Recursiva <0> Salir: "
msgx: .asciiz "Introduzca el valor de x: "
msgn: .asciiz "Introduzca el valor de n: "
resultado: .asciiz "Resultado de la llamada de la funcion: "
tabla: .asciiz "Tabla de resultados:\n"
salto_l: .asciiz "\n"
espacio: .asciiz " "


    .text



fr:
  
  addiu	$sp, $sp, -8          #Hago un push al puntero de la pila
	sw	$ra, 0($sp)             #En la posicion 0 de la pila guardo el "camino a casa", es decir el registro destino ($ra)/
	sw	$a0, 4($sp)             #En la posicion 4 de la pila guardo el valor que uso para la n
  beq $a0, $zero, truecero    #si n==0 ir a truecero
  beq $a0, 1, acabado         #si n==1 ir a acabado, ya que como el valor que devolveria 1 sería 1, y multiplicar 1 por x te da x, simplifico el codigo borrando esa parte.
  
  addi $a0,$a0,-1             #Primer trozo de funcion "f(n-1,x)"
  jal fr


  addi $a0,$a0,-1             #Segundo trozo de funcion "f(n-2,x)"

  jal fr
  addiu $t8,$t8,1
  mul.s $f0,$f0,$f12          #Aqui multiplico la constante, que corresponde al trozo de la funcion "*x", por el registro $f1, que es el numero que devuelve mi funcion

  j acabado                   #Un salto a acabado

  truecero:
  #  addiu $t8,$t8,1
    li.s $f6,0.5              #Cargo el registro temporal f5 con 0
    mul.s $f0,$f0,$f6         #Multiplico 0,5 (ya que a0 es 0) por el registro $f1, que es el numero que devuelve mi funcion
    j acabado                 #Un salto a acabado

  acabado:
    
	  lw	$ra, 0($sp)           #Vuelvo sobre mis pasos cargando en $ra donde guarde anteriormente el registro $ra en $sp
	  lw	$a0, 4($sp)           #Cargo $a0, con el valor que tenía antes de restarle en el n-1 o en el n-2
    addiu	$sp, $sp, 8         #Hago un pop a la pila
	  jr	$ra                   #Salto al registro $ra
    
fi:

  li.s $f8, 0.5               #$f8 = 0.5, el return cuando la funcion es 0

  bne $a0,$zero,no_cero       #Las siguientes lineas corresponden a los if en el bucle fi de c++, para comprobar si es 0,1 o 2:

    li.s $f0,0.5              #if(n==0)
    jr $ra                    #    return 0.5;                 
  no_cero:

  bne $a0,1,no_uno            #if(n==1)
    li.s $f0,1.0              #    return 1;
    jr $ra
  no_uno:

  bne $a0,2,no_dos      
    mul.s $f0,$f12,$f8        #if(n==2)
    jr $ra                    #    return x*0.5;
  no_dos:

  li $t0, 1                   #El registro $t0 hace referencia a la j, por eso la cargo con 1
  li $t1, 0                   #El registro $t1 hace referencia a la i, por eso la cargo con 0
  li $t2, 2                   #El registro $t2 hace referencia a la itinerancia del for k, por eso la cargo con 2
  li.s $f4, 1.0               #El registro $f4 lo utilizo para elevar el 0.5 a fn
  li.s $f6, 1.0               #El registro $f5 lo utilizo para elevar el x a fx

  for:                        #Con este for hago una sucesion de fibonnacci modificada para n numeros, que a cada itinerancia se le suma +1, esto lo hago para saber a que tengo que elevar el x

  bge $t2,$a0,fin_for         #for(int k{2};k<n;k++){
    add $t3,$t1,$t0           #El registro $t3 es la variable fx   ///  fx=i+j;
    addiu $t3,$t3,1           #++fx;
    move $t1,$t0              #i=j;
    move $t0,$t3              #j=fx;
    addiu $t2,$t2,1           #k++
    j for  

  fin_for:

  li $t0, 1                   #Reseteo las variables de i,j,k para el siguiente for  ////   i=0,j=1;
  li $t1, 0
  li $t2, 2

  for2:                       #En este for hago una sucesion de fibonnacci para n numeros.

  bge $t2,$a0,fin_for2        #for(int k{2};k<n;k++){
    add $t4,$t1,$t0           #El registro $t4 es la variable fn   ///  fn=i+j;
    move $t1,$t0              #i=j;
    move $t0,$t4              #j=fn;
    addiu $t2,$t2,1           #k++
    j for2

  fin_for2:

  li $t0, 0                   #Ahora el registro $t0 lo utilizo como variable de itinerancia, que inicio a 0

  #Las siguientes lineas corresponden a: return (pow(0.5,fn)*pow(x,fx));
  #Pero como no existe en mips una instrucción pow, lo hago con unos bucles for, que multiplico en este caso fn, y fx veces mis variables $f4 y $f5.

  for_fx:

  bge $t0,$t3,fin_for_fx

    mul.s $f4,$f4,$f12        #Multiplico x (en el programa en c++) un total de fx veces, y lo guardo en $f4. El resto del for es un simple for.
    addiu $t0,$t0,1
    j for_fx

  fin_for_fx:

  li $t0, 0                   #Reseteo mi variable de itinerancia a 0

  for_fn:

  bge $t0,$t4,fin_for_fn

    mul.s $f6,$f6,$f8        #Multiplico $f8(que es 0.5) un total de fn veces, y lo guardo en $f6. El resto del for es un simple for.
    addiu $t0,$t0,1
    j for_fn

  fin_for_fn:
  mul.s $f0,$f4,$f6          #Multiplico el registro $f4 y $f6, que corresponde al paso final antes del return en c++, y lo guardo en $f0, preparando el registro para la devolucion de la funcion
  
  jr $ra                     #Salto al registro

main:
    
    li.s $f1,1.0
    li $v0,4
    la $a0,titulo
    syscall
    li $v0,5
    syscall
    move $t0, $v0

    
    
    beq $t0, 1, uno_true
    beq $t0, 2, dos_true
    beq $t0, 0, fin

    uno_true:

      li $v0,4
      la $a0,msgn
      syscall
      li $v0,5
      syscall
      move $t1,$v0

      li $v0,4
      la $a0,msgx
      syscall
      li $v0,6
      syscall
      mov.s $f4,$f0

      bge $t9,120, lleno

      sw $t1, matrix($t9)
      addiu $t9,$t9,4
      swc1 $f4,matrix($t9)
      addiu $t9,$t9,4

      lleno:

      move $a0,$t1
      mov.s $f12,$f4

      jal fi

      li $v0,4
      la $a0,resultado
      syscall

      bge $t9,120, lleno2

      swc1 $f0, matrix($t9)
      addiu $t9,$t9,4

      lleno2:

      li $v0,2
      mov.s $f12,$f0
      syscall

      li $v0,4
      la $a0,salto_l
      syscall
 
      j main

    dos_true:

      li $v0,4
      la $a0,msgn
      syscall
      li $v0,5
      syscall
      move $t1,$v0
    
      li $v0,4
      la $a0,msgx
      syscall
      li $v0,6
      syscall
      mov.s $f4,$f0

      bge $t9,120, lleno3

      sw $t1, matrix($t9)
      addiu $t9,$t9,4
      swc1 $f4,matrix($t9)
      addiu $t9,$t9,4
      
      lleno3:

      move $a0,$t1
      mov.s $f12,$f4
      li.s $f0, 1.0
      
      jal fr

      li $v0,4
      la $a0,resultado
      syscall

      bge $t9,120, lleno4

      swc1 $f0, matrix($t9)
      addiu $t9,$t9,4

      lleno4:

      li $v0,2
      mov.s $f12,$f0
      syscall

      li $v0,4
      la $a0,salto_l
      syscall
     
      j main
      
    fin:

    li $v0,4
    la $a0, tabla
    syscall
    li $t0,0
    la $t1, matrix
    for_matriz:

      beq $t0,$t9,fin_for_matriz

      li $v0,1
      lw $t2,matrix($t0)
      move $a0, $t2
      syscall
      addiu $t0,$t0,4

      li $v0,4
      la $a0,espacio
      syscall

      li $v0,2
      lwc1 $f16,matrix($t0)
      mov.s $f12, $f16
      syscall
      addiu $t0,$t0,4

      li $v0,4
      la $a0,espacio
      syscall

      li $v0,2
      lwc1 $f16,matrix($t0)
      mov.s $f12, $f16
      syscall
      addiu $t0,$t0,4

      li $v0,4
      la $a0,salto_l
      syscall

      j for_matriz

    fin_for_matriz:

    li $v0,10
    syscall