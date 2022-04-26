#include <iostream>

const int size=4;
int main();  //Declaro antes el main para que me deje saltar

void no_mem(){
  std::cout<<"Introduzca una cantidad de columnas y filas que no pasen la memoria máxima(400).\n\n";
  main();    
}
void err(){
  std::cout<<"La matriz no puede tener 0 columnas o menor, ni 0 filas o menor.\n";
  main();
}
int main(){

    int cols{0}, fils{0},mem{0},n{0};
    std::cout<<"Practica 4. Matrices. Intercambio de filas y/o columnas\n";
    std::cout<<"Introduzca el numero de filas: ";
    std::cin>>fils;
    if(fils<=0)
      err();
    std::cout<<"Introduzca el numero de columnas: ";
    std::cin>>cols;
    if(cols<=0)
      err();
    mem=cols*fils*size;
    if(mem>400)
      no_mem();
    mem-=size;
    int matriz[fils][cols];
    for(int i{0};i<fils;i++)                           //Esto lo hice distinto que en el codigo .s, ya que programe primero el .s, y para rellenar una matriz en c++ la forma mas fácil es esta
      for(int j{0};j<cols;j++){
        std::cout<<"Introduzca un numero de la matriz: ";
        std::cin>>n;
        matriz[i][j]=n;
      }
    while(true){
      std::cout<<"Practica 4. Matrices. Intercambio de filas y/o columnas\n";
      for(int i{0};i<fils;i++){
        for(int j{0};j<cols;j++)
          std::cout<<matriz[i][j]<<" ";
        std::cout<<"\n";
      }
      int selector{-1};
      
      std::cout<<"Introduzca opcion. <1> Intercambia filas, <2> Intercambia columnas, <0> Salir: ";
      while(selector != 0 && selector != 1 && selector !=2){
        std::cin>>selector;
        int n1{0},n2{0},cambio{0};
        switch(selector){
            case 0:
              exit(EXIT_SUCCESS);
            case 1:
              
              std::cout<<"Introduzca dos enteros con las filas que se deben intercambiar [0-"<<fils-1<<"]:\n";
              std::cin>>n1;
              std::cin>>n2;  
              while(n1<0 || n1>= fils || n2<0 || n2>= fils){
                std::cout<<"Error, el numero que estas introduciendo es incorrecto, por favor, introduzca valores que no sobrepase los limites.\nIntroduzca dos enteros con las filas que se deben intercambiar [0-"<<fils-1<<"]:\n";
                std::cin>>n1;
                std::cin>>n2;    
              }
              for(int i{0};i<cols;i++){
                cambio=matriz[n1][i];
                matriz[n1][i]=matriz[n2][i];
                matriz[n2][i]=cambio;
              }
              break;
            case 2:
              std::cout<<"Introduzca dos enteros con las columnas que se deben intercambiar [0-"<<cols-1<<"]:\n";
              std::cin>>n1;
              std::cin>>n2;  
              while(n1<0 || n1>= cols || n2<0 || n2>= cols){
                std::cout<<"Error, el numero que estas introduciendo es incorrecto, por favor, introduzca valores que no sobrepase los limites.\nIntroduzca dos enteros con las columnas que se deben intercambiar [0-"<<cols-1<<"]:\n";
                std::cin>>n1;
                std::cin>>n2;    
              }
              for(int i{0};i<fils;i++){
                cambio=matriz[i][n1];
                matriz[i][n1]=matriz[i][n2];
                matriz[i][n2]=cambio;
              }
              break;
            default:
              std::cout<<"Introduzca un valor que sea 0 , 1 o 2.\n";
              std::cout<<"Introduzca opcion. <1> Intercambia filas, <2> Intercambia columnas, <0> Salir: ";
              break;
        }
      }
    }
}