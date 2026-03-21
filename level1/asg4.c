/*Develop a modular C program to manage a fleet of 4 cars. 
Use a structure to store vehicle details and implement logic to display only 
modern vehicles (manufactured after 2022). Create a structure Car with the following members:
    • car_id
    • model_name
    • manufacture_year
    • price
Create an array of 4 cars. The program should read details of 4 cars from the user. 
Display only those cars manufactured after the year 2022.
Function prototype:
void readCars(int n, Car_t c[]);
void displayModernCars(int n, Car_t c[]);*/
#include<stdio.h>
#define y 4
typedef struct{
    int cid;
    char mn[50];
    int my;
    float p;
}Car_t;
void readCars(int n, Car_t *c);
void displayModernCars(int n, Car_t *c);
int main(){
    Car_t c[y];
    readCars(y,c);
    displayModernCars(y,c);
    return 0;
}
void readCars(int x,Car_t *c){
    for(int i=0;i<x;i++){
        printf("Enter car id of car %d : ",i+1);
        scanf("%d",&c[i].cid);
        printf("Enter model name of car %d : ",i+1);
        scanf("%49s",c[i].mn);
        printf("Enter manufacture year of car %d : ",i+1);
        scanf("%d",&c[i].my);
        printf("Enter price of car %d : ",i+1);
        scanf("%f",&c[i].p);
    }
}
void displayModernCars(int x,Car_t *c){
    int f=0;
    printf("-------- Modern cars manufactured after 2022 --------\n");
    for(int i=0;i<x;i++){
        if(c[i].my>2022){
            printf("Car ID: %d\nModel name: %s\nManufacture year(after 2022): %d\nPrice: %.2f\n",c[i].cid,c[i].mn,c[i].my,c[i].p);
            f=1;
        }
    }
    if(f==0){
        printf("No modern cars available manufactured after 2022\n");
    }
}

































