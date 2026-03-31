/*A retail store needs a simple logger to record product inventory. Write a modular C program 
that takes 'n' product details (ID, Name, Price) from the user and saves them into a file named 
inventory.txt. The program must separate its logic into distinct functions: one to input data into an 
array, one to persist that data to a file, one to mathematically compute the total stock value from the 
file, and finally, a separate function to present that total to the user. This structure ensures that the 
logic for "how to calculate" is kept separate from "how to display" the results.
Function Prototypes:
    • void inputProducts(Product p[], int n);
    • void saveToFile(Product p[], int n, const char *file);
    • float calculateTotalValue(const char *file);
    • void displayTotalValue(float total);*/
#include<stdio.h>
#include<stdlib.h>
typedef struct{
    int id;
    char n[50];
    float price;
}Product;
void inputProducts(Product p[], int n);
void saveToFile(Product p[], int n, const char *file);
float calculateTotalValue(const char *file);
void displayTotalValue(float total);
int main(){
    int n;
    printf("Enter number of products: ");
    scanf("%d",&n);
    if(n<=0){
        printf("Invalid number of products.\n");
        return -1;
    }
    Product p[n];
    inputProducts(p,n);
    saveToFile(p,n,"inventory.txt");
    float t=calculateTotalValue("inventory.txt");
    displayTotalValue(t);
    return 0;
}
void inputProducts(Product *p,int n){
    for(int i=0;i<n;i++){
        printf("Enter product %d details\n",i+1);
        printf("ID: ");
        scanf("%d",&p[i].id);
        printf("Name: ");
        scanf("%s",p[i].n);
        printf("Price: ");
        scanf("%f",&p[i].price);
    }
}
void saveToFile(Product *p,int n,const char *f){
    FILE *ptr=fopen(f,"w");
    if(ptr==NULL){
        printf("Error cannot open file\n");
        exit(-1);
    }
    for(int i=0;i<n;i++){
        fprintf(ptr,"%d %s %f\n",p[i].id,p[i].n,p[i].price);
    }
    fclose(ptr);
}
float calculateTotalValue(const char *f){
    int id;
    char n[50];
    float price;
    float t=0;
    FILE *ptr=fopen(f,"r");
    if(ptr==NULL){
        printf("Error cannot open file\n");
        exit(-1);
    }
    while((fscanf(ptr,"%d %s %f",&id,n,&price))==3){
        t=t+price;
    }
    fclose(ptr);
    return t;
}
void displayTotalValue(float t){
    printf("Total stock value of the products = %.2f\n",t);
}







































