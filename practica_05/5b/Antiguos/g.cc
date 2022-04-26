#include <iostream>
#include <cmath>
#include <vector>
double fi(int n,double x){

int i{0},j{1},fx{0},fn{0};
if(n==0)
    return 0.5;
if(n==1)
    return 1;
if(n==2)
    return x*0.5;
for(int k{2};k<n;k++){
    fx=i+j;
    ++fx;
    i=j;
    j=fx;
}

i=0,j=1;
for(int k{2};k<n;k++){
    fn=i+j;
    i=j;
    j=fn;
}

return (pow(0.5,fn)*pow(x,fx));
}
double fr(int n,double x){
  
  if(n==0)
    return 0.5;
  else if(n==1)
    return 1;
  else
    return fr(n-1,x)* fr(n-2,x)* x;

}
std::vector<double> b;
int main(){

int a,n;
double x,resultado{1};
std::cout<<"Introduzca opcion. <1> Iterativa <2> Recursiva <0> Salir: ";
std::cin >> a;
if(a==1){

  std::cout<<"Introduzca el valor de n: ";
  std::cin>> n;
  std::cout<<"Introduzca el valor de x: ";
  std::cin>> x;
  std::cout<< fi(n,x)<<"\n";
  b.push_back(n);
  b.push_back(x);
  b.push_back(fi(n,x));
  main();
}else if(a==2){
  std::cout<<"Introduzca el valor de n: ";
  std::cin>> n;
  std::cout<<"Introduzca el valor de x: ";
  std::cin>> x;
  
  std::cout<<fr(n,x)<<"\n";
  b.push_back(n);
  b.push_back(x);
  b.push_back(fr(n,x));
  main();

}else

  for(int j=0,i=0;j<b.size()/3;j++){
      std::cout<< b[i]<<" ";
      i++;
      std::cout<< b[i]<<" ";
      i++;
      std::cout<< b[i]<<"\n";
      i++;
  }
  return 0;
}