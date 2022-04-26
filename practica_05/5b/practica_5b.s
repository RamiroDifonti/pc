

size=4

    .data

matrix: .space 200           #Reservamos 120 bytes para la matriz
titulo: .asciiz "Introduzca opcion. <1> Iterativa <2> Recursiva <0> Salir: "
msgx: .asciiz "Introduzca el valor de x: "
msgn: .asciiz "Introduzca el valor de n: "
resultado: .asciiz "Resultado de la llamada de la funcion: "
tabla: .asciiz "Tabla de resultados:\n"
salto_l: .asciiz "\n"
espacio: .asciiz " "


# #include <iostream>
# #include <cmath>
# #include <vector>
# double fi(int n,double x){

# int i{0},j{1},fx{0},fn{0};
# if(n==0)
#     return 0.5;
# if(n==1)
#     return 1;
# if(n==2)
#     return x*0.5;
# for(int k{2};k<n;k++){
#     fx=i+j;
#     ++fx;
#     i=j;
#     j=fx;
# }

# i=0,j=1;
# for(int k{2};k<n;k++){
#     fn=i+j;
#     i=j;
#     j=fn;
# }

# return (pow(0.5,fn)*pow(x,fx));
# }
# double fr(int n,double x){
  
#   if(n==0)
#     return 0.5;
#   else if(n==1)
#     return 1;
#   else
#     return fr(n-1,x)* fr(n-2,x)* x;

# }
# std::vector<double> b;
# int main(){

# int a,n;
# double x,resultado{1};
# std::cout<<"Introduzca opcion. <1> Iterativa <2> Recursiva <0> Salir: ";
# std::cin >> a;
# if(a==1){

#   std::cout<<"Introduzca el valor de n: ";
#   std::cin>> n;
#   std::cout<<"Introduzca el valor de x: ";
#   std::cin>> x;
#   std::cout<< fi(n,x)<<"\n";
#   b.push_back(n);
#   b.push_back(x);
#   b.push_back(fi(n,x));
#   main();
# }else if(a==2){
#   std::cout<<"Introduzca el valor de n: ";
#   std::cin>> n;
#   std::cout<<"Introduzca el valor de x: ";
#   std::cin>> x;
  
#   std::cout<<fr(n,x)<<"\n";
#   b.push_back(n);
#   b.push_back(x);
#   b.push_back(fr(n,x));
#   main();

# }else

#   for(int j=0,i=0;j<b.size()/3;j++){
#       std::cout<< b[i]<<" ";
#       i++;
#       std::cout<< b[i]<<" ";
#       i++;
#       std::cout<< b[i]<<"\n";
#       i++;
#   }
#   return 0;
# }

#Sobreescribimos los registros, por eso hay varias variables con los mismos registros
#Hay muchos registros que no utilizo en c++, pero si que utilizo en el .s, entonces por eso no tienen una referencia registro-variable.

#Registros---------Variables
#
#    $a0            n
#    $f12           x,resultado 
#    $t0            a,j
#    $t1            i
#    $t2            k
#    $f6            x
#    $t3            fx
#    $t4            fn


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

  mul.d $f0,$f0,$f12          #Aqui multiplico la constante, que corresponde al trozo de la funcion "*x", por el registro $f0, que es el numero que devuelve mi funcion

  j acabado                   #Un salto a acabado

  truecero:
 
    li.d $f6,0.5              #Cargo el registro temporal f5 con 0
    mul.d $f0,$f0,$f6         #Multiplico 0,5 (ya que a0 es 0) por el registro $f0, que es el numero que devuelve mi funcion
    
    j acabado                 #Un salto a acabado

  acabado:
    
	  lw	$ra, 0($sp)           #Vuelvo sobre mis pasos cargando en $ra donde guarde anteriormente el registro $ra en $sp
	  lw	$a0, 4($sp)           #Cargo $a0, con el valor que tenía antes de restarle en el n-1 o en el n-2
    addiu	$sp, $sp, 8         #Hago un pop a la pila
	  jr	$ra                   #Salto al registro $ra
    
fi:

  li.d $f8, 0.5               #$f8 = 0.5, el return cuando la funcion es 0

  bne $a0,$zero,no_cero       #Las siguientes lineas corresponden a los if en el bucle fi de c++, para comprobar si es 0,1 o 2:

    li.d $f0,0.5              #if(n==0)
    jr $ra                    #    return 0.5;                 
  no_cero:

  bne $a0,1,no_uno            #if(n==1)
    li.d $f0,1.0              #    return 1;
    jr $ra
  no_uno:

  bne $a0,2,no_dos      
    mul.d $f0,$f12,$f8        #if(n==2)
    jr $ra                    #    return x*0.5;
  no_dos:

  li $t0, 1                   #El registro $t0 hace referencia a la j, por eso la cargo con 1
  li $t1, 0                   #El registro $t1 hace referencia a la i, por eso la cargo con 0
  li $t2, 2                   #El registro $t2 hace referencia a la itinerancia del for k, por eso la cargo con 2
  li.d $f4, 1.0               #El registro $f4 lo utilizo para elevar el 0.5 a fn
  li.d $f6, 1.0               #El registro $f5 lo utilizo para elevar el x a fx

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

    mul.d $f4,$f4,$f12        #Multiplico x (en el programa en c++) un total de fx veces, y lo guardo en $f4. El resto del for es un simple for.
    addiu $t0,$t0,1
    j for_fx

  fin_for_fx:

  li $t0, 0                   #Reseteo mi variable de itinerancia a 0

  for_fn:

  bge $t0,$t4,fin_for_fn

    mul.d $f6,$f6,$f8        #Multiplico $f8(que es 0.5) un total de fn veces, y lo guardo en $f6. El resto del for es un simple for.
    addiu $t0,$t0,1
    j for_fn

  fin_for_fn:
  mul.d $f0,$f4,$f6          #Multiplico el registro $f4 y $f6, que corresponde al paso final antes del return en c++, y lo guardo en $f0, preparando el registro para la devolucion de la funcion
  jr $ra                     #Salto al registro

main:                        #Inicio del codigo
    
    li $v0,4                 #Prepara la consola para imprimir una cadena de carácteres
    la $a0,titulo            #Imprimimos por pantalla el titulo
    syscall
    li $v0,5                 #Preparamos la consola para introducir un entero
    syscall
    move $t0, $v0            #Movemos al registro $t0 el entero que acabamos de introducir en $v0

    
    
    beq $t0, 1, uno_true    #Comparamos el registro $t0 con el valor 1 y si son iguales saltamos a la etiqueta "uno_true"
    beq $t0, 2, dos_true    #Comparamos el registro $t0 con el valor 2 y si son iguales saltamos a la etiqueta "dos_true"
    beq $t0, 0, fin         #Comparamos el registro $t0 con el valor 0 y si son iguales saltamos a la etiqueta "fin"

    uno_true:               #Etiqueta

      li $v0,4              #Mostramos por pantalla el cadena de carácteres msgn
      la $a0,msgn           
      syscall

      li $v0,5             #Leemos un entero introducido por teclado y lo guardamos en el registro $t1
      syscall
      move $t1,$v0

      li $v0,4              #Mostramos por pantalla el cadena de carácteres msgx
      la $a0,msgx
      syscall

      li $v0,7              #Leemos un float introducido por teclado y lo guardamos en el registro $f4
      syscall
      mov.d $f4,$f0         

      bge $t9,200, lleno    #Comparamos el registro utilizado para guardar los valores de la matriz con los bytes maximos permitidos,
                            #si tiene 120 bytes esta llena la matriz y salta la etiqueta lleno

      sw $t1, matrix($t9)   #Metemos el valor introducido en el registro $t1 a la matriz guardada en el registro $t9
      addiu $t9,$t9,size    #Sumamos a $t9 el valor de size que es lo que mide en bytes cada espacio de la matriz
      sdc1 $f4,matrix($t9)  #Metemos el valor introducido en el registro $f4 a la matriz guardada en $t9
      addiu $t9,$t9,size    #Sumamos a $t9 el valor de size dos veces que es lo que mide en bytes un double
      addiu $t9,$t9,size    

      lleno:                #Etiqueta

      move $a0,$t1          #Copiamos el registro $t1 en $a0
      mov.d $f12,$f4        #Copiamos el registro $f4 en $f12
 
      jal fi                #Guardo la dirección del siguiente registro de memoria en $ra y salto a la etiqueta fi con la instrucción jal

      li $v0,4              #Mostramos por pantalla el cadena de carácteres resultado
      la $a0,resultado
      syscall

      bge $t9,200, lleno2   #Comparamos el registro utilizado para guardar los valores de la matriz con los bytes maximos permitidos,
                            #si tiene 120 bytes esta llena la matriz y salta la etiqueta lleno2

      sdc1 $f0, matrix($t9) #Metemos el valor introducido en el registro $f0 a la matriz guardada en $t9
      addiu $t9,$t9,size    #Sumamos a $t9 el valor de size dos veces que es lo que mide en bytes un double
      addiu $t9,$t9,size    

      lleno2:               #Etiqueta

      li $v0,3              #Mostramos por pantalla el flotante guardado en $f12
      mov.d $f12,$f0
      syscall

      li $v0,4              #Mostramos por pantalla el cadena de carácteres salto_l
      la $a0,salto_l
      syscall
 
      j main                #Saltamos al inicio del programa en la etiqueta main con la instruccion j

    dos_true:               #Etiqueta

      li $v0,4              #Mostramos por pantalla el cadena de carácteres msgn
      la $a0,msgn
      syscall

      li $v0,5              #Leemos un entero introducido por teclado y lo guardamos en el registro $t1
      syscall
      move $t1,$v0
    
      li $v0,4              #Mostramos por pantalla el cadena de carácteres msgx
      la $a0,msgx
      syscall

      li $v0,7              #Leemos un float introducido por teclado y lo guardamos en el registro $f4
      syscall
      mov.d $f4,$f0

      bge $t9,200, lleno3   #Comparamos el registro utilizado para guardar los valores de la matriz con los bytes maximos permitidos,
                            #si tiene 120 bytes esta llena la matriz y salta la etiqueta lleno3

      sw $t1, matrix($t9)   #Metemos el valor introducido en el registro $t1 a la matriz guardada en el registro $t9
      addiu $t9,$t9,size    #Sumamos a $t9 el valor de size que es lo que mide en bytes cada espacio de la matriz
      sdc1 $f4,matrix($t9)  #Metemos el valor introducido en el registro $f4 a la matriz guardada en $t9
      addiu $t9,$t9,size    #Sumamos a $t9 el valor de size dos veces que es lo que mide en bytes un double
      addiu $t9,$t9,size    

      lleno3:               #Etiqueta

      move $a0,$t1          #Copiamos el valor del registro $t1 en $a0
      mov.d $f12,$f4        #Copiamos el valor del registro $f4 en $f12
      li.d $f0, 1.0         #Cargamos el registro $f0 con el valor 1.0
     
      jal fr                #Guardo la dirección del siguiente registro de memoria en $ra y salto a la etiqueta fr con la instrucción jal
    
      li $v0,4              #Mostramos por pantalla el cadena de carácteres msgn
      la $a0,resultado
      syscall

      bge $t9,200, lleno4   #Comparamos el registro utilizado para guardar los valores de la matriz con los bytes maximos permitidos,
                            #si tiene 120 bytes esta llena la matriz y salta la etiqueta lleno4

      sdc1 $f0, matrix($t9) #Metemos el valor introducido en el registro $f4 a la matriz guardada en $t9
      addiu $t9,$t9,size    #Sumamos a $t9 el valor de size dos veces que es lo que mide en bytes un double
      addiu $t9,$t9,size    

      lleno4:               #Etiqueta

      li $v0,3              #Mostramos por pantalla el flotante guardado en $f12
      mov.d $f12,$f0
      syscall

      li $v0,4              #Mostramos por pantalla la cadena de carácteres salto_1
      la $a0,salto_l
      syscall
     
      j main                #Saltamos a la etiqueta main
      
    fin:                    #Etiqueta

    li $v0,4                #Mostramos por pantalla la cadena de carácteres tabla
    la $a0, tabla
    syscall

    li $t0,0                 #Reseteo mi variable de itinerancia a 0    
    la $t1, matrix           #Cargamos el registro $t1 en matrix

    for_matriz:             #Etiqueta

      beq $t0,$t9,fin_for_matriz  #Comparamos $t0 con $t9 que es el registro donde se guarda la matriz y saltamos a la etiqueta.

      li $v0,1              
      lw $t2,matrix($t0)     #Cargamos en el registro $t2 el elemento de la matriz guardada en $t0 y copiamos el registro $t2 en el $a0 para mostrar por pantalla 
      move $a0, $t2
      syscall
      addiu $t0,$t0,size        #++4bytes

      li $v0,4              #Mostramos por pantalla la cadena de carácteres tabla
      la $a0,espacio
      syscall

      li $v0,3              #Cargamos en el registro $f16 el elemento de la matriz guardada en $t0 y copiamos el registro $f16 en el $f12 para mostrar por pantalla 
      ldc1 $f16,matrix($t0)
      mov.d $f12, $f16
      syscall
      addiu $t0,$t0,size     #++8bytes
      addiu $t0,$t0,size

      li $v0,4              #Mostramos por pantalla la cadena de carácteres espacio
      la $a0,espacio
      syscall

      li $v0,3              #Cargamos en el registro $f16 el elemento de la matriz guardada en $t0 y copiamos el registro $f16 en el $f12 para mostrar por pantalla 
      ldc1 $f16,matrix($t0)
      mov.d $f12, $f16
      syscall
      addiu $t0,$t0,size     #++8bytes
      addiu $t0,$t0,size

      li $v0,4              #Mostramos por pantalla la cadena de carácteres salto_1
      la $a0,salto_l
      syscall

      j for_matriz          #Saltamos a la etiqueta con la instrucción j

    fin_for_matriz:         #Etiqueta

    li $v0,10               #Fin del programa
    syscall