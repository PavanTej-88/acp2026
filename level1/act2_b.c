/*(b) Write a C program to check if the user qualifies for a 
free unit consumption scheme using functions and structure. Example: If consumption is less than 
50 units, the bill is ₹0. (if statement)
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
    float rate;
    float total_bill;
}ElectricityBill;
ElectricityBill input();
ElectricityBill calculate_bill(ElectricityBill e);
void output(ElectricityBill e);
int main(){
    ElectricityBill x;
    x=input();
    x=calculate_bill(x);
    output(x);
    return 0;    
}
ElectricityBill input(){
    ElectricityBill e;
    printf("Enter number of units: ");
    scanf("%d",&e.units);
    printf("Enter rate per unit: ");
    scanf("%f",&e.rate);
    return e;
}
ElectricityBill calculate_bill(ElectricityBill e){    
    if(e.units<50){
        e.total_bill=0;
        return e;
    }
    e.total_bill=e.units*e.rate;
    return e;
}
void output(ElectricityBill e){
    printf("Electricity Bill = %.2f\n",e.total_bill);
}















