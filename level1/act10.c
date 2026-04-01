/*An airline reservation system requires a high-performance method to archive flight 
details. Unlike text files, binary storage allows the system to save and retrieve 
complex structure data rapidly without data conversion. Develop a modular C program 
to manage flight records (Flight Number, Destination, and Ticket Price). The program 
must input $n$ flights, save the entire array of structures to a binary file named 
flights.bin using block-write operations, and then read the file to find and display 
the flight with the highest ticket price.
Function Prototypes:
    • void inputFlights(Flight f[], int n);
    • void saveToBinary(Flight f[], int n, const char *filename);
    • Flight findMostExpensive(const char *filename);
    • void displayTopFlight(Flight f);*/
#include<stdio.h>
#include<stdlib.h>
#define mi 50
typedef struct{
    int fn;
    char d[50];
    float tp;
}Flight;
void inputFlights(Flight f[], int n);
void saveToBinary(Flight f[], int n, const char *filename);
Flight findMostExpensive(const char *filename);
void displayTopFlight(Flight f);
int main(void){
    int n;
    printf("Enter number of flights: ");
    scanf("%d",&n);
    if(n<=0||n>mi){
        printf("Invalid number of flights\n");
        return -1;
    }
    Flight f[n];
    inputFlights(f,n);
    saveToBinary(f,n,"flights.bin");
    Flight f1=findMostExpensive("flights.bin");
    displayTopFlight(f1);
    return 0;
}
void inputFlights(Flight *f,int n){
    for(int i=0;i<n;i++){
        printf("Enter flight %d details:\n",i+1);
        printf("Flight number: ");
        scanf("%d",&f[i].fn);
        printf("Destination: ");
        scanf("%s",f[i].d);
        printf("Total price: ");
        scanf("%f",&f[i].tp);
    }
}
void saveToBinary(Flight *f,int n,const char *s){
    FILE *ptr=fopen(s,"wb");
    if(ptr==NULL){
        printf("Error opening file\n");
        exit(-1);
    }
    fwrite(f,sizeof(Flight),n,ptr);
    fclose(ptr);
}
Flight findMostExpensive(const char *s){
    FILE *ptr=fopen(s,"rb");
    if(ptr==NULL){
        printf("Error opening file\n");
        exit(-1);
    }
    Flight k[mi];
    int i=0,m=0;
    while((fread(&k[i],sizeof(Flight),1,ptr))==1){
        if(k[i].tp>k[m].tp){
            m=i;
        }
        i++;
    }
    return k[m];
}
void displayTopFlight(Flight f){
    printf("The flight %d has highest price %f\n",f.fn,f.tp);
}






























