size = 4

    .data

matrix: .space 400
nrows:  .word 0
ncols:  .word 0
titulo: .asciiz "Practica 4. Matrices. Intercambio de filas y/o columnas\n"
msg1:   .asciiz "Introduzca opcion. <1> Intercambia filas, <2> Intercambia columnas, <0> Salir: "
msgfil1: .asciiz "Introduzca dos enteros con las filas que se deben intercambiar [0-"
msgcol1: .asciiz "Introduzca dos enteros con las columnas que se deben intercambiar [0-"
charfin: .asciiz "]:\n"
espacio: .asciiz " "
r_carro: .asciiz "\n"
tam_fil: .asciiz "Introduzca el numero de filas: "
tam_col: .asciiz "Introduzca el numero de columnas: "
msg2: .asciiz "Introduzca un numero de la matriz: "
no_memo: .asciiz "Introduzca una cantidad de columnas y filas que no pasen la memoria máxima(400).\n\n"
msg_error: .asciiz "Error, el numero que estas introduciendo es incorrecto, por favor, introduzca valores que no sobrepase los limites.\n"
msg_error2: .asciiz "Introduzca un valor que sea 0 , 1 o 2.\n"
n_invalido: .asciiz "La matriz no puede tener 0 columnas o menor, ni 0 filas o menor.\n"
#Antes de nada, remarcar que en todo el programa repito el uso de muchos registros (para no tener que utilizar muchos registros), entonces pueden haber cargas de registros con 0,
# basicamente para evitar errores, ya que como el código se repite hasta que introduzcas cero, hay registros que necesito que empiecen devuelta en 0.


##include <iostream>

#const int size=4;
#int main();  //Declaro antes el main para que me deje saltar

#void no_mem(){
#  std::cout<<"Introduzca una cantidad de columnas y filas que no pasen la memoria máxima(400).\n\n";
#  main();    
#}
#void err(){
#  std::cout<<"La matriz no puede tener 0 columnas o menor, ni 0 filas o menor.\n";
#  main();
#}
#int main(){
#
#    int cols{0}, fils{0},mem{0},n{0};
#    std::cout<<"Practica 4. Matrices. Intercambio de filas y/o columnas\n";
#    std::cout<<"Introduzca el numero de filas: ";
#    std::cin>>fils;
#    if(fils<=0)
#      err();
#    std::cout<<"Introduzca el numero de columnas: ";
#    std::cin>>cols;
#    if(cols<=0)
#      err();
#    mem=cols*fils*size;
#    if(mem>400)
#      no_mem();
#    mem-=size;
#    int matriz[fils][cols];
#    for(int i{0};i<fils;i++)                           //Esto lo hice distinto que en el codigo .s, ya que programe primero el .s, y para rellenar una matriz en c++ la forma mas fácil es esta
#      for(int j{0};j<cols;j++){
#        std::cout<<"Introduzca un numero de la matriz: ";
#        std::cin>>n;
#        matriz[i][j]=n;
#      }
#    while(true){
#      std::cout<<"Practica 4. Matrices. Intercambio de filas y/o columnas\n";
#      for(int i{0};i<fils;i++){
#        for(int j{0};j<cols;j++)
#          std::cout<<matriz[i][j]<<" ";
#        std::cout<<"\n";
#      }
#      int selector{-1};
#      
#      std::cout<<"Introduzca opcion. <1> Intercambia filas, <2> Intercambia columnas, <0> Salir: ";
#      while(selector != 0 && selector != 1 && selector !=2){
#        std::cin>>selector;
#        int n1{0},n2{0},cambio{0};
#        switch(selector){
#            case 0:
#              exit(EXIT_SUCCESS);
#            case 1:
#              
#              std::cout<<"Introduzca dos enteros con las filas que se deben intercambiar [0-"<<fils-1<<"]:\n";
#              std::cin>>n1;
#              std::cin>>n2;  
#              while(n1<0 || n1>= fils || n2<0 || n2>= fils){
#                std::cout<<"Error, el numero que estas introduciendo es incorrecto, por favor, introduzca valores que no sobrepase los limites.\nIntroduzca dos enteros con las filas que se deben intercambiar [0-"<<fils-1<<"]:\n";
#                std::cin>>n1;
#                std::cin>>n2;    
#              }
#              for(int i{0};i<cols;i++){
#                cambio=matriz[n1][i];
#                matriz[n1][i]=matriz[n2][i];
#                matriz[n2][i]=cambio;
#              }
#              break;
#            case 2:
#              std::cout<<"Introduzca dos enteros con las columnas que se deben intercambiar [0-"<<cols-1<<"]:\n";
#              std::cin>>n1;
#              std::cin>>n2;  
#              while(n1<0 || n1>= cols || n2<0 || n2>= cols){
#                std::cout<<"Error, el numero que estas introduciendo es incorrecto, por favor, introduzca valores que no sobrepase los limites.\nIntroduzca dos enteros con las columnas que se deben intercambiar [0-"<<cols-1<<"]:\n";
#                std::cin>>n1;
#                std::cin>>n2;    
#              }
#              for(int i{0};i<fils;i++){
#                cambio=matriz[i][n1];
#                matriz[i][n1]=matriz[i][n2];
#                matriz[i][n2]=cambio;
#              }
#              break;
#            default:
#              std::cout<<"Introduzca un valor que sea 0 , 1 o 2.\n";
#              std::cout<<"Introduzca opcion. <1> Intercambia filas, <2> Intercambia columnas, <0> Salir: ";
#              break;
#       }
#      }
#    }
#}



#Para evitar complicaciones, sobreeescribo registros, por eso un registro puede tener varios valores

#REGISTROS-------VARIABLES
#   $s0             cols
#   $s1             fils
#   $t0             mem,i,selector   
#   $t1             i 
#   $t5             j          
#   $t6             n1         
#   $t7             n2
#   $t8             memfil             
    .text


no_mem:

  li $v0,4                      #En las siguientes 3 lineas imprimo en pantalla la cadena no_mem
  la $a0,no_memo
  syscall
  j main
inv_num:
  li $v0,4                      #En las siguientes 3 lineas imprimo en pantalla la cadena n_invalido
  la $a0,n_invalido
  syscall
main:
    li $v0,4                      #En las siguientes 3 lineas imprimo en pantalla la cadena titulo
    la $a0,titulo
    syscall

    li $v0,4                      #En las siguientes 3 lineas imprimo en pantalla la cadena tam_fil
    la $a0,tam_fil
    syscall
    li $v0,5                      #Guardo un valor que introduzca el usuario en nrows (numero de columnas)
    syscall
    ble $v0,$zero,inv_num         #En las dos lineas siguientes compruebo si el numero de filas introducido es <=0 
    sw $v0,nrows

    li $v0,4                      #En las siguientes 3 lineas imprimo en pantalla la cadena tam_col
    la $a0,tam_col
    syscall
    li $v0,5                      #Guardo un valor que introduzca el usuario en ncols (numero de filas)
    syscall
    ble $v0,$zero,inv_num         #En las dos lineas siguientes compruebo si el numero de columnas introducido es <=0 
    sw $v0,ncols

    lw $s0, ncols                 #Cargo s0, y s1 con el ncols, y el nrows, ya que los utilizo mucho en el programa
    lw $s1, nrows

    mul $t0,$s0,$s1               #En las siguientes dos lineas calculo cuanta memoria ocuparia si ponemos x filas y x columnas
    mul $t0,$t0,size    

    bgt $t0,400,no_mem            #Compruebo si no sobrepasa la memoria que le asigne que es 400

    li $t1,0                      #Cargo mi itinerancia del for a 0
    sub $t0,$t0,size              #Le resto size a lo que sería la memoria maxima, esto es así porque si no se me sobrepasaria por un valor cuando este escribiendo valores de la matriz
    
    for_matrix:
    
    bgt $t1,$t0,fin_for_matrix    #Compruebo si mi itinerancia es igual a la memoria maxima, si es asi salta a fin_for_matrix

    li $v0,4                      #Muestro por pantalla la cadena de texto msg2
    la $a0,msg2
    syscall

    li $v0,5                      #Hago que el usuario introduzca un valor, y lo guardo en la posición de la matriz de $t1, que $t1 va incrementando en cada itinerancia con size, es decir, en este caso, 0 4 8 12 16..., para que vaya avanzando la memoria de donde metes los valores de matriz
    syscall                       #Esto corresponde en el for que hay en c++, donde guardo los valores de n en la matriz[i][j]
    sw $v0,matrix($t1)
    addi $t1,$t1,size

    j for_matrix

    fin_for_matrix:


    la $t3,matrix                 #Este registro va a ser el registro que usemos para imprimir la matriz, y modificarla
    do:
      li $v0, 4                   #Cargo y muestro por pantalla el titulo del programa
      la $a0, titulo
      syscall

      li $t1, 0                   #Este registro lo utilizaremos luego para restarle al registro $t3(la matriz) la memoria que le sumamos, así la podemos imprimir infinitamente

      #Utilizo un for dentro de un for para imprimir las columas y filas, lo único que hago es contar el n_cols hasta llegar a 3 y luego pongo un retorno de carro

      li $t0, 0                   #Cargamos el registro que usaremos para la i con 0 para evitar errores
      for_i:

        bge $t0, $s1, fin_for_i     #Bucle para cambiar de filas mientras las leo
        li $t5,0                  #Cargo el registro $t5 con 0, ya que este registro es la j

        for_j:

          bge $t5, $s0, fin_for_j   #Bucle para mostrar cada elemento de la fila
          lw $t4,0($t3)           #Cargo el registro $t4 con el numero de la matriz

          li $v0, 1               #En las siguientes 3 lineas cargo el registro v0 para leer enteros, luego muevo t4 a a0 (que es el numero de la matriz) y lo muestro por la pantalla
          move $a0,$t4       
          syscall

          addu $t1,$t1,size       #Le sumo a $t1 size para luego restarlo a t3, al final del bucle for, esto es así porque quiero resetear la memoria de la matriz.
          addu $t3,$t3,size       #Le sumo a $t3 size (que es el n de bytes que ocupa cada numero), para que vaya avanzando los numeros

          li $v0, 4               #Cargo un espacio y lo muestro por pantalla
          la $a0, espacio   
          syscall

          addi $t5,1              #++j
          j for_j

        fin_for_j:

          li $v0, 4               #Cargo un retorno de carro y lo muestro por pantalla
          la $a0, r_carro
          syscall

        addi $t0,$t0,1            #Un simple i++
        j for_i

      fin_for_i:

      sub $t3,$t3,$t1             #Como dije anteriormente, aqui resto al registro de la matriz(t3), el numero que estaba utilizando para calcular cuanta memoria le habia sumado inicialmente. 
      
      error:

      li $v0, 4                   #Muestro por pantalla la cadena de caracteres msg1
      la $a0, msg1
      syscall

      li $v0, 5                   #Guardo el valor que introduce el usuario en el registro t0, para saber que quiere hacer, si cambiar filas, columnas o salir
      syscall
      move $t0,$v0

      beq $t0, $zero,fin_do       #Si el usuario introduce 0, que salga del programa, si es un 1 que cambie filas y si es un 2 que cambie columnas.
      beq $t0, 1,filas
      beq $t0, 2,colus
      
      li $v0, 4                   #Muestro por pantalla la cadena de caracteres msg_error2, esto salta si el numero introducido no es ni 0 ni 1 ni 2
      la $a0, msg_error2
      syscall
      
      j error


        bucle1:                   #Este muestra un error si los numeros no son válidos.

          li $v0, 4                 #Muestro por pantalla la cadena msg_error
          la $a0, msg_error
          syscall
        
        filas:

          li $v0, 4                 #Muestro por pantalla la cadena msgfil1
          la $a0, msgfil1
          syscall

          sub $t1, $s1,1            #Muestro por pantalla lo que sería el límite para escoger un numero, el sub de $s1-1 es porque va de 0 hasta el n anterior, $s1 es nrwos. 
          li $v0, 1
          move $a0, $t1
          syscall

          li $v0, 4                 #Muestro por pantalla la cadena charfin(los 2 caracteres que faltan al final de la linea).
          la $a0, charfin
          syscall

          li $v0, 5                 #Cargo los registros $t6, y $t7 con la respuesta del usuario
          syscall
          blt $v0,$zero,bucle1      #En las dos lineas siguientes compruebo si el numero introducido es <0 o >nrows
          bge $v0,$s1,bucle1
          move $t6, $v0             #Muevo el registro v0 a t6 para guardar el valor introducido
          li $v0, 5
          syscall
          bge $v0,$s1,bucle1        #En las dos lineas siguientes compruebo si el numero introducido es <0 o >nrows
          blt $v0,$zero,bucle1
          move $t7, $v0             #Muevo el registro v0 a t7 para guardar el valor introducido
        
          mul $t8, $s0,size          #Esta multiplicacion lo que calcula es la diferencia de bytes entre filas de los numeros
          mul $t6,$t6,$t8           #Multiplico los registros t6 y t7 por t8(que es la diferencia de bytes entre filas), para obtener el inicio y el limite
          mul $t7,$t7,$t8

          li $t4,0                  #Inicializo la itinerancia del for a 0

          for_fil:
            bge $t4,$s0,fin_for_fil #Hago un bucle for de 0 hasta $s0, que es el numero de columnas, ya que si queremos cambiar 2 filas no necesitamos mas itineraciones

            add $t1,$t3,$t6     #Guardo en $t1 la suma de $t3(la matriz) y $t6, y le hago un load word, esto es para que mas tarde le cargue este valor en la matriz
            lw $t1,0($t1)
            add $t2,$t3,$t7     #Guardo en $t2 la suma de $t3(la matriz) y $t7, y le hago un load word, esto es para que mas tarde le cargue este valor en la matriz
            lw $t2,0($t2)

            add $t3,$t3,$t7     #Le sumo a $t3(la matriz) el registro $t7, para ubicar la posicion de la matriz donde queremos poner el valor cambiado en este caso $t1
            sw $t1,0($t3)       #Cargo el valor de $t1 en la posicion 0 de $t3 (realmente no es la posicion 0, ya que en la linea de arriba le sume ya lo que se tenia que desplazar)
            sub $t3,$t3,$t7     #Le resto a $t3 el valor de $t7, para ubicarnos en la posicion 0 de la matriz
  
            add $t3,$t3,$t6     #Le sumo a $t3(la matriz) el registro $t6, para ubicar la posicion de la matriz donde queremos poner el valor cambiado en este caso $t0
            sw $t2,0($t3)       #Cargo el valor de $t1 en la posicion 0 de $t3 (realmente no es la posicion 0, ya que en la linea de arriba le sume ya lo que se tenia que desplazar)       
            sub $t3,$t3,$t6     #Le resto a $t3 el valor de $t6, para ubicarnos en la posicion 0 de la matriz

            addi $t6,$t6,size   #Le sumo a $t6 y a $t7 el valor de size, que es 4, para que en la siguiente itinerancia del for se desplace todo a la derecha e intercambie esos valores
            addi $t7,$t7,size
            addi $t4,$t4,1      #Es un simple ++i, para que avance el for
            j for_fil

        fin_for_fil:
        j do

      bucle2:                   #Este bucle comprueba si los numeros introducidos son válidos.

        li $v0, 4                 #Muestro por pantalla la cadena msg_error
        la $a0, msg_error
        syscall

      colus:

        li $v0, 4                 #Muestro por pantalla la cadena msg_col1
        la $a0, msgcol1
        syscall
        
        sub $t1, $s0,1            #Muestro por pantalla lo que sería el límite para escoger un numero, el sub de $s0-1 es porque va de 0 hasta el n anterior, $s0 es ncols. 
        move $a0, $t1
        li $v0, 1
        move $a0, $t1
        syscall

        li $v0, 4                 #Muestro por pantalla la cadena charfin(los 2 caracteres que faltan al final de la linea).
        la $a0, charfin
        syscall

        li $v0, 5                 #Cargo los registros $t6, y $t7 con la respuesta del usuario
        syscall
        bge $v0,$s0,bucle2        #En las dos lineas siguientes compruebo si el numero introducido es <0 o >ncols
        blt $v0,$zero,bucle2
        move $t6, $v0             #Muevo el registro v0 a t6 para guardar el valor introducido
        li $v0, 5
        syscall
        bge $v0,$s0,bucle2        #En las dos lineas siguientes compruebo si el numero introducido es <0 o >ncols
        blt $v0,$zero,bucle2
        move $t7, $v0             #Muevo el registro v0 a t7 para guardar el valor introducido

        mul $t8, $s0,size          #Esta multiplicacion lo que calcula es la diferencia de bytes entre filas de los numeros
        mul $t6,$t6,size          #Multiplico los registros t6 y t7 por t8(que es la diferencia de bytes entre filas), para obtener el inicio y el limite
        mul $t7,$t7,size

        li $t4,0                  #Cargo el registro t4 con 0, porque es el registro que uso para hacer el bucle for      

        for_col:
            bge $t4,$s1,fin_for_col #Hago un bucle for de 0 hasta $s0, que es el numero de columnas, ya que si queremos cambiar 2 filas no necesitamos mas itineraciones 
            
            add $t1,$t3,$t6     #Guardo en $t1 la suma de $t3(la matriz) y $t6, y le hago un load word, esto es para que mas tarde le cargue este valor en la matriz
            lw $t1,0($t1)
            
            add $t2,$t3,$t7     #Guardo en $t2 la suma de $t3(la matriz) y $t7, y le hago un load word, esto es para que mas tarde le cargue este valor en la matriz
            lw $t2,0($t2)
            
            add $t3,$t3,$t7     #Le sumo a $t3(la matriz) el registro $t7, para ubicar la posicion de la matriz donde queremos poner el valor cambiado en este caso $t1
            sw $t1,0($t3)       #Cargo el valor de $t1 en la posicion 0 de $t3 (realmente no es la posicion 0, ya que en la linea de arriba le sume ya lo que se tenia que desplazar)
            sub $t3,$t3,$t7     #Le resto a $t3 el valor de $t7, para ubicarnos en la posicion 0 de la matriz
  
            add $t3,$t3,$t6     #Le sumo a $t3(la matriz) el registro $t6, para ubicar la posicion de la matriz donde queremos poner el valor cambiado en este caso $t0
            sw $t2,0($t3)       #Cargo el valor de $t1 en la posicion 0 de $t3 (realmente no es la posicion 0, ya que en la linea de arriba le sume ya lo que se tenia que desplazar)       
            sub $t3,$t3,$t6     #Le resto a $t3 el valor de $t6, para ubicarnos en la posicion 0 de la matriz
            addu $t3,$t3,$t8

            addi $t4,$t4,1      #Es un simple ++i, para que avance el for
            j for_col

        fin_for_col:
        mul $t0,$t8,$s1         #En estas dos líneas lo que hago es resetear la memoria de la matriz, restandole t8*s1, que seria (ncols*size)*nfils 
        sub $t3,$t3,$t0
        j do
      
    fin_do:
    li $v0, 10
    syscall