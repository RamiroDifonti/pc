# practica 3. Principio de computadoras
# OBJETIVO: introduce el codigo necesario para reproducir el comportamiento del programa
# 
# Debes documentar debidamente el uso de los registros que has elegido y la correspondencia
# con las variables que has utilizado.

##include <iostream>
#
#using namespace std;
#
#float factorial(int i){
#  float a{1};
#  for(int j{1};j<=i;j++)
#    a*= j;
#  return(i==0 ? 1 : a);
#}
#
#int main(){
#  double error{0}, numero{0};
#  float const numero_e=2.718281828459045;
#  cout<<"Practica 3. PRINCIPIO DE COMPUTADORES\nIntroduzca el error maximo permitido: ";
#  cin >> error;
#  int i{0}, itineraciones{0};
#  do{    
#    numero+= 1/(factorial(i)); 
#    ++i;
#    ++itineraciones;
#  }
#  while((numero_e-numero)>error);
#  //numero+= 1/(factorial(i)); 
#
#  cout<<"Numero e: "<<numero;
#  cout<<"\nTerminos calculados: "<<itineraciones;
#  return 0;
#}

#REGISTRO     VARIABLE

#  $f4          comprobacion_error
#  $f5          i
#  $f6          itineraciones
#  $f7          numero
#  $f8          variable a de la funcion factorial
#  $f9          j
#  $f10         numero_final
#  $f24         Registro discriminatorio para diferenciar entre el salto fin_factorial y fin_factorial2

#  $f21         error
#  $f22         0 en punto flotante (lo reservo unicamente para hacer comprobaciones, no lo modifico)
#  $f23         1, es solo un 1 por la cantidad que se usa en el programa


#       CUESTIÓN 2:

#En los registros de $f4 hasta $f9 y el registro $f24 utilizo registros temporales porque son registros que voy a estar modificando en el transcurro del programa.
#En los registros del $f20 al $f23, son registros donde declaro una vez un valor y no lo modifico más, entonces por eso uso registros salvados.
#Tambien utilizo en el codigo el registro $f12, que lo utilizo basicamente para enviar el numero flotante y que se escriba en pantalla.

#       CUESTIÓN 3:

#Para que el calculo del numero e sea de doble precisión, tendría que en vez de coger 1 registro por numero, tendría que coger 2 registros,
#ya que los doble utilizan dos registros, realizar este cambio me afectaría mucho a mi código ya que he elegido los registros de forma ordenada,
#y se me sobreescribirían los registros unos con otros.

    .data

titulo: .asciiz "Practica 3. PRINCIPIO DE COMPUTADORES\nIntroduzca el error maximo permitido: "
numero_e: .asciiz "\nNumero e: "
final: .asciiz "\nTerminos calculados: "

    .text

main:
    la $a0,titulo   #Carga y escribe en pantalla la cadena de caracteres "titulo".
	li $v0,4
	syscall
    li $v0,6   #Prepara el programa para leer un numero float
    syscall
    mov.s $f21,$f0

    li.s $f23, 1.0  #Cargo este registro con un valor de 1, ya que en el programa se utiliza mucho el 1, y de esta forma lo tengo mas a mano
    li.s $f6, 1.0 #Cargo el registro de itineraciones con un 1 porque minimo hace 1 itineracion
    
    do:
        li.s $f4, 0.0  #Inicio la comprobacion del error a 0 ( para que cuando se repita el bucle sea 0, y no pe 1.71825409
        li.s $f10,0.0  #Inicio el numero final a 0 para evitar errores

        j factorial  #Las siguientes dos lineas son un salto a la funcion factorial definida mas abajo
        fin_factorial:

        div.s  $f8,$f23,$f8 #Divido 1 entre $f8
        
        add.s  $f7,$f7,$f8 #Estas sumando la funcion factorial a numero, y lo guardas es numero, que es el registro $f7
        
        add.s  $f5,$f5,$f23 #Un simple ++i ($f5+1)
        li.s $f24,1.0  #Esto es un simple discriminatorio para que en la funcion factorial, entre por fin_factorial2 en vez de por fin_factorial
        
        j factorial
        fin_factorial2:

        div.s  $f8,$f23,$f8  #Divido 1 entre $f8
        add.s $f10,$f7,$f8  #Sumo la variable numero con el 1/factorial(i) y lo guardo en la variable $f10 (numero_final)

        add.s  $f6,$f6,$f23 #Le sumo 1 al numero de itineraciones
        li.s $f24,0.0  #Reseteo el valor del discriminatorio para que en la funcion factorial, entre por fin_factorial en vez de fin_factorial2

    sub.s $f4,$f10,$f7 #Resto al numero e el numero que obtuvimos con la formula, y lo guardo en $f18
    c.lt.s $f4,$f21 #En las siguientes tres lineas compruebo si $f18 es menor que el error que hemos introducido, si es asi, salta por fin_programa, si no es asi, vuelve al bucle do
    bc1f do
    j fin_programa

j do

fin_programa:

    la $a0,numero_e #Carga y escribe en pantalla la cadena de caracteres "numero_e".
	li $v0,4
	syscall

    mov.s $f12,$f10 #Muevo el contenido del registro $f10 (numero_final) al registro $f12
	li $v0,2  #Cargo el contenido del registro $v0 con un 2, que significa que puede escribir numeros en float, y en la siguiente linea lo imprimo por pantalla
	syscall

#   CUESTION 1:

    la $a0,final  #Escribo en pantalla la cadena de caracteres llamada "final".
	li $v0,4
	syscall
    
    cvt.w.s $f6,$f6  #Convierto el registro $f6 de float a entero
    mfc1 $4,$f6 #Muevo el contenido del registro $f6 al registro general $4
    move $a0,$4 #Muevo el contenido del registro $f6 al registro $a0
	li $v0,1  #Cargo el contenido del registro $v0 con un 1, que significa que puede escribir numeros enteros, y en la siguiente linea lo imprimo por pantalla
	syscall
 
    li	$v0,10  #Cargo el registro $v0 con 10 que es el exit del programa
	syscall


#FUNCION FACTORIAL

    factorial:
      li.s $f8, 1.0  #Inicio la variable a con 1, para que cuando lo multipliques con j no se multiplique por 0 y sea siempre 0 
      li.s $f9, 1.0  #Inicio el intinerante j con 1, para que cuando multipliques con a no se multiplique por 0 y sea siempre 0

      for: c.lt.s $f5,$f9 #Las dos siguientes lineas son el bucle for, que si $f6 que es la variable j, es menor o igual que $f5 la variable i, salta al fin del for
        bc1t fin_for

        mul.s $f8,$f8,$f9  #Multiplico la variable a por j, y lo guardo en el registro $f8
        add.s  $f9,$f9,$f23 #Esto es un simple ++j
        j for #Salto al inicio del for

      fin_for:
      c.eq.s $f24,$f23 #Compruebo si $f24==1, si no es igual a 1 salta por fac, si es igual a 1 salta a fin_factorial2
        bc1f fac
          j fin_factorial2
      fac:
      c.eq.s $f5,$f22  #Compruebo si la variable i($f5) es igual a 0 (cogi el registro $f17 porque al no usarlo siempre sera 0), si es igual a 0, cambia el registro $f8 por 1, 
      # y sale de la funcion, si la variable i no es igual a 0, divido 1 entre $f8 y salgo del bucle.

        bc1t cero
        
        j fin_factorial

      cero:
        li.s $f8, 1.0
        j fin_factorial