/*The sports department requires a digital system to track player performance 
for various matches where the team size varies dynamically. Design and implement 
a modular C program that utilizes Dynamic Memory Allocation to manage these scores 
efficiently. The program must demonstrate clean coding principles by separating concerns 
into independent functions for memory reservation, data entry, mathematical processing, 
and output display. Specifically, the system must prompt the user for the number of players, 
allocate the exact required memory, validate the allocation, read the scores, display the scores, 
compute the total team score, and finally implement a safe deallocation strategy that prevents 
dangling pointers by resetting the memory address to NULL after freeing.
Function Prototypes:
    • int* allocate_scores(int n);
    • void read_scores(int *arr, int n);
    • int calculate_total(int *arr, int n);
    • void display_scores(int *arr, int n);
    • void delete_scores(int **arr);*/
#include<stdio.h>
#include<stdlib.h>
int* allocate_scores(int n);
void read_scores(int *arr, int n);
int calculate_total(int *arr, int n);
void display_scores(int *arr, int n);
void delete_scores(int **arr);
int main(){
    int n;
    printf("Enter number of players: ");
    scanf("%d",&n);
    if(n<=0){
        printf("Invalid size\n");
        return 0;
    }
    int *a=allocate_scores(n);
    read_scores(a,n);
    int total=calculate_total(a,n);
    display_scores(a,n);
    delete_scores(&a);
    return 0;
}
int *allocate_scores(int n){
    int *x=malloc(n*sizeof(int));
    if(x==NULL){
        printf("Allocation unsuccessful\n");
        exit(1);
    }
    return x;
}
void read_scores(int *a,int n){
    for(int i=0;i<n;i++){
        printf("Enter player %d score: ",i+1);
        scanf("%d",(a+i));
    }
}
int calculate_total(int *a,int n){
    int s=0;
    for(int i=0;i<n;i++){
        s=s+(*(a+i));
    }
    return s;
}
void display_scores(int *a,int n){
    for(int i=0;i<n;i++){
        printf("Player %d: %d\n",i+1,*(a+i));
    }
}
void delete_scores(int **a){
    free(*a);
    *a=NULL;
}





























