/*A pharmacy requires a digital inventory system to track 
medications and their expiration years. Design and implement 
a modular C program to manage this data using a structure that 
stores a medicine's ID, name, and expiration year. The system must 
allow the user to define the number of medicines to be entered, 
input the data for each record, and display the complete inventory list. 
To ensure clean coding and professional memory management, the program 
must use separate functions for memory allocation, data entry, display, 
and safe deallocation of the array.
Function Prototypes:
    • Medicine_t* allocate_inventory(int n);
    • void read_inventory(Medicine_t *m, int n);
    • void display_inventory(Medicine_t *m, int n);
    • void delete_inventory(Medicine_t **m);*/
#include<stdio.h>
#include<stdlib.h>
typedef struct{
    int mid;
    char n[50];
    int y;
}Medicine_t;
Medicine_t* allocate_inventory(int n);
void read_inventory(Medicine_t *m, int n);
void display_inventory(Medicine_t *m, int n);
void delete_inventory(Medicine_t **m);
int main(){
    int n;
    printf("Enter nmuber of medicines: ");
    scanf("%d",&n);
    if(n<=0){
        printf("Invalid size\n");
        return 0;;
    }
    Medicine_t* m=allocate_inventory(n);
    read_inventory(m,n);
    display_inventory(m,n);
    delete_inventory(&m);
    return 0;
}
Medicine_t* allocate_inventory(int n){
    Medicine_t*x=malloc(n*sizeof(Medicine_t));
    if(x==NULL){
        printf("Memory allocation failed\n");
        exit(1);
    }
    return x;
}
void read_inventory(Medicine_t*  x,int n){
    for(int i=0;i<n;i++){
        printf("Enter medicine ID of medicine %d: ",i+1);
        scanf("%d",&((*x).mid));
        printf("Enter name of medicine %d: ",i+1);
        scanf("%s",&((*x).n));
        printf("Enter expiration year of medicine %d: ",i+1);
        scanf("%d",&((*x).y));
    }
}
void display_inventory(Medicine_t*  x,int n){
    for(int i=0;i<n;i++){
        printf("Medicine ID of medicine %d: ",i+1);
        scanf("%d",&((*x).mid));
        printf("Name of medicine %d: ",i+1);
        scanf("%s",&((*x).n));
        printf("Expiration year of medicine %d: ",i+1);
        scanf("%d",&((*x).y));
    }
}
void delete_inventory(Medicine_t** x){
    free(*x);
    *x=NULL;
}





























