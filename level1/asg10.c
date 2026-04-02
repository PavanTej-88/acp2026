/*A warehouse management system requires an efficient way to store large volumes 
of product data. Unlike text files, binary files provide faster access and better 
storage efficiency. Develop a modular C program to manage product inventory using 
binary file handling. The program must allow the user to input details for n 
products (ID, Name, and Price), store them in an array of structures, and save the 
entire collection into a binary file named inventory.bin. Subsequently, the program 
should read the data back from the binary file to calculate the total stock value and 
display the final results to the user. Each operation, input, file writing, calculation, 
and display, must be implemented in separate, independent functions to ensure code modularity 
and clarity.
Function Prototypes:
    • void inputProducts(Product p[], int n);
    • void saveToBinaryFile(Product p[], int n, const char *file);
    • float calculateTotalValue(const char *file);
    • void displayTotalValue(float total);*/
#include<stdio.h>
#include<stdlib.h>
#define mi 50
typedef struct{
    int id;
    char n[50];
    float p;
}Product;
void inputProducts(Product p[], int n);
void saveToBinaryFile(Product p[], int n, const char *file);
float calculateTotalValue(const char *file);
void displayTotalValue(float total);
int main(){
    int n;
    printf("Enter number of products: ");
    scanf("%d",&n);
    if(n<=0||n>mi){
        printf("Invalid number of products\n");
        return -1;
    }
    Product p[n];
    inputProducts(p,n);
    saveToBinaryFile(p,n,"inventory.bin");
    float total_value=calculateTotalValue("inventory.bin");
    displayTotalValue(total_value);
    return 0;
}
void inputProducts(Product *p,int n){
    for(int i=0;i<n;i++){
        printf("Enter product %d details:\n",i+1);
        printf("Enter id: ");
        scanf("%d",&p[i].id);
        printf("Enter name: ");
        scanf("%s",p[i].n);
        printf("Enter price: ");
        scanf("%f",&p[i].p);
    }
}
void saveToBinaryFile(Product *p,int n,const char *f){
    FILE *ptr=fopen(f,"wb");
    if(ptr==NULL){
        printf("Error opening file.\n");
        exit(-1);
    }
    fwrite(p,sizeof(Product),n,ptr);
    fclose(ptr);
}
float calculateTotalValue(const char *f){
    FILE *ptr=fopen(f,"rb");
    if(ptr==NULL){
        printf("Error opening file.\n");
        exit(-1);
    }
    Product p1[mi];
    int i=0;
    float total_value=0;
    while(fread(&p1[i],sizeof(Product),1,ptr)==1){
        total_value+=p1[i].p;
        i++;
    }
    fclose(ptr);
    return total_value;
}
void displayTotalValue(float t){
    printf("Total stock value of the products: %.2f\n",t);
}
































