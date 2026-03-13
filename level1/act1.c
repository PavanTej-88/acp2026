/*Write a C program using functions to read the temperature of 
each day for a week (7 float values), store them in an array, 
and find the minimum and maximum temperature. 
(array, passing arrays to functions, for loop, if statement)
Function Prototypes:
void inputTemperatures(int n, float temps[n]);
float findHighest(int n, float temps[n]);
float findLowest(int n, float temps[n]);
void output(float max, float min);*/
#include<stdio.h>
void inputTemperatures(int,float * );
float findHighest(int,float * );
float findLowest(int,float * );
void output(float,float);
int main(){
    float d[7];
    inputTemperatures(7,d);
    output(findHighest(7,d),findLowest(7,d));
}
void inputTemperatures(int n,float *x){
    for(int i=0;i<7;i++){
        printf("Enter temperature for day %d: ",i+1);
        scanf("%f",&x[i]);
    }
}
float findHighest(int n,float *x){
    int high=0;
    for(int i=0;i<n;i++){
        if(x[i]>x[high]){
            high=i;
        }
    }
    return x[high];
}
float findLowest(int n,float *x){
    int low=0;
    for(int i=0;i<n;i++){
        if(x[i]<x[low]){
            low=i;
        }
    }
    return x[low];
}
void output(float x,float y){
    printf("Highest temperature = %.2f\n",x);
    printf("Lowest temperature = %.2f\n",y);
}
    
























