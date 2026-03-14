/*Write a C program to check if the electricity units consumed exceed 100 
using functions and structure. If they do, apply an extra charge of ₹5 per 
unit over 100 and display a warning message “High consumption alert! 
Extra charge applied”. (if statement)
typedef struct {
int units;
    	float rate;
    	float total_bill;
} ElectricityBill;
Function Prototypes:
ElectricityBill input();
ElectricityBill calculate_bill(ElectricityBill bill);
void output(ElectricityBill bill);*/
#include<stdio.h>
typedef struct{
    int units;
    float rate,total_bill;
}ElectricityBill;
ElectricityBill input(void);
ElectricityBill calculate_bill(ElectricityBill bill);
void output(ElectricityBill bill);
int main(){
    ElectricityBill eb;
    eb=input();
    eb=calculate_bill(eb);
    output(eb);
    return 0;
}
ElectricityBill input(){
    ElectricityBill x;
    printf("Enter number of units: ");
    scanf("%d",&x.units);
    printf("Enter rate per unit: ");
    scanf("%f",&x.rate);
    return x;
}
ElectricityBill calculate_bill(ElectricityBill x){
    if(x.units<=100){
        x.total_bill=(x.units)*(x.rate);
    }
    else{
        x.total_bill=((100)*(x.rate))+((x.units-100)*(x.rate+5));
    }
    return x;
}
void output(ElectricityBill x){
    printf("Total electricity bill = %.2f\n",x.total_bill);
}

    









