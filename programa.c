#include<stdio.h>
#include<stdlib.h>

int main(){
int var = 5;
printf("inicial \n ");
printf("%d \n ", var);
if(var < 10){
var = var + 10;
printf("primeiro \n ");
printf("%d \n ", var);
while(var < 100){
var = var + 10;
printf("Loop \n ");
printf("%d \n ", var);
}
}
if(var > 100){
var = var + 10;
printf("primeiro \n ");
printf("%d \n ", var);
}

return 0;
}
