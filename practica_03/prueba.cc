#include <iostream>

using namespace std;

float factorial(int i){
  float a{1};
  for(int j{1};j<=i;j++)
    a*= j;
  return(i==0 ? 1 : a);
}

int main(){
  double error{0}, numero{0},numero_final{0};
  cout<<"Practica 3. PRINCIPIO DE COMPUTADORES\nIntroduzca el error maximo permitido: ";
  cin >> error;
  int i{0}, itineraciones{1};
  do{
    numero_final=0;    
    numero+= 1/(factorial(i)); 
    ++i;
    numero_final=1/(factorial(i))+numero;
    ++itineraciones;
    cout<<numero_final<<endl;
  }
  while((numero_final-numero)>error);

  cout<<"Numero e: "<<numero_final;
  cout<<"\nTerminos calculados: "<<itineraciones;
  return 0;
}