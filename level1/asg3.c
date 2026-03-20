/*Write a C program using functions and array of structures to calculate 
the tiling cost for multiple floors and display the floor that has the 
highest total tiling cost. (array of structures, for loop, if statement)
typedef struct {
    	float length;
    	float width;
    	float area;
    	float costPerUnit;
    	float totalCost;
} Floor;
Function Prototypes:
void inputDetails(int n, Floor floors[n]);
void calculateCosts(int n, Floor floors[n]);
void highestCostFloor(int n, Floor floors[n]);
void displayHighestCost(int index, Floor floors[]);
*/
#include<stdio.h>
typedef struct{
    float l,w,a,cpu,tc;
}Floor;
void inputDetails(int n, Floor *f);
void calculateCosts(int n, Floor *f);
void highestCostFloor(int n, Floor *f);
void displayHighestCost(int index, Floor *f);
int main(){
    int n;
    printf("Enter number of floors: ");
    scanf("%d",&n);
    if(n<=0){
        printf("Invalid number of floors");
        return 0;
    }
    Floor f[n];
    inputDetails(n,f);
    calculateCosts(n,f);
    highestCostFloor(n,f);
    return 0;
}
void inputDetails(int x,Floor *f){
    for(int i=0;i<x;i++){
        printf("Enter length of floor %d: ",i+1);
        scanf("%f",f[i].l);
        printf("Enter width of floor %d: ",i+1);
        scanf("%f",f[i].w);
        printf("Enter cost per unit for floor %d: ",i+1);
        scanf("%f",f[i].cpu);
    }
}void calculateCosts(int x,Floor *f){
    for(int i=0;i<x;i++){
        f[i].a=f[i].l*f[i].w;
        f[i].tc=f[i].a*f[i].cpu;
    }
}
void highestCostFloor(int x,Floor *f){
    int l=0;
    for(int i=0;i<x;i++){
        if(f[i].tc>f[l].tc){
            l=i;
        }
    }
    displayHighestCost(l,f);
}
void displayHighestCost(int l,Floor *f){
    printf("Floor %d has highest cost for tiling, cost = %d\n",l,f[l].tc);
}


























