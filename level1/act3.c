/*Write a C program to calculate electricity bills for multiple consumers using 
array of structures and functions and display the highest bill. 
(array of structures, for loop, if statement)
typedef struct {
    	int consumerID;
    	float unitsConsumed;
    	float billAmount;
} Bill;
Function Prototypes:
void input(int n, Bill bills[n]);
void calculate_Bills(int n, Bill bills[n]);
int findHighestBillIndex(int n, Bill bills[n]);
void displayHighestBill(int index, Bill bills[]);*/

#include<stdio.h>
#define r 5.4
void input(int n, Bill *b);
void calculate_Bills(int n, Bill *b);
int findHighestBillIndex(int n, Bill *b);
void displayHighestBill(int index, Bill *b);
typedef struct{
    int consumerID;
    float unitsConsumed,billAmount;
}Bill;
int main(){
    int n;
    printf("Enter number of consumers: ");
    scanf("%d",&n);
    Bill b[n];
    input(n,b);
    calculate_Bills(n,b);
    int l=findHighestBillIndex(n,b);
    displayHighestBill(l,b);
    return 0;
}
void input(int x,Bill *b){
    for(int i=0;i<x;i++){
        printf("Enter consumer ID of consumer %d: ",i+1);
        scanf("%d",&b[i].consumerID);
        printf("Enter bills consumed of consumer %d: ",i+1);
        scanf("%f",&b[i].unitsConsumed);
    }
}
void calculate_Bills(int x,Bill *b){
    for(int i=0;i<x;i++){
        b[i].billAmount=b[i].unitsConsumed*r;
    }
}
int findHighestBillIndex(int x, Bill *b){
    int l=0;
    for(int i=0;i<x;i++){
        if(b[i].billAmount>b[l].billAmount){
            l=i;
        }
    }
    return l;
}
void displayHighestBill(int l, Bill *b){
    printf("Highest consumed bill amount = %.2f\n",b[l].billAmount);
    printf("Consumer ID of highest consumed bill = %d\n",b[l].consumerID);
    printf("Units consumed of highest consumed bill = %.2f\n",b[l].unitsConsumed);
}



















