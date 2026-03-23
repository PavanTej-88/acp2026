/*Develop a modular C program to manage an integer array using dynamic 
memory allocation. You must implement specific functions to allocate, initialize, 
display, and safely deallocate memory. This task ensures proficiency in preventing 
memory leaks and managing dangling pointers.
Function prototype:
int* create_array(int n); 
void initialize_array(int *arr, int n); 
void print_array(int *arr, int n); 
void delete_array(int **arr);*/

#include<stdio.h>
int* create_array(int n); 
void initialize_array(int *arr, int n); 
void print_array(int *arr, int n); 
void delete_array(int **arr);
int main(){
    int n;
    printf("Enter number of elements of the array: ");
    scanf("%d",&n);
    int *a=create_array(n);
    initialize_array(a,n);
    print_array(a,n);
    delete_array(&a);
    return 0;
}
int * create_array(int n){
    int *x=malloc(n*sizeof(int));
    return x;
}
void initialize_array(int *a,int n){
    for(int i=0;i<n;i++){
        printf("Enter element %d of the array: ",i+1);
        scanf("%d",(a+i));
    }
}
void print_array(int *a,int n){
    for(int i=0;i<n;i++){
        printf("Element %d: %d\n",i+1,*(a+i));
    }
}
void delete_array(int **a,int n){
    free(*a);
    *a=NULL;
}


































