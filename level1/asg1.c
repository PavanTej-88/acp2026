/*Write a C program using functions to read the marks (float) obtained 
by n students in a test, store them in an array, and find the highest and 
lowest mark scored. (array, passing arrays to functions, for loop, if statement)
Function Prototypes:
void inputMarks(int n, float marks[n]);
float findHighestMark(int n, float marks[n]);
float findLowestMark(int n, float marks[n]);
void output(float max, float min);*/

#include<stdio.h>
void inputMarks(int x, float *m);
float findHighestMark(int x, float *m);
float findLowestMark(int x, float *m);
void output(float max, float min);
int main(){
    int n;
    printf("Enter number of students: ");
    scanf("%d",&n);
    if(n<=0){
        printf("Invalid number of students");
        return 0;
    }
    float m[n];
    inputMarks(n,m);
    float h=findHighestMark(n,m);
    float l=findLowestMark(n,m);
    output(h,l);
    return 0;
}
void inputMarks(int x,float *a){
    for(int i=0;i<x;i++){
        printf("Enter marks of student %d : ",i+1);
        scanf("%f",&a[i]);
    }
}
float findHighestMark(int x,float *a){
    int high=0;
    for(int i=1;i<x;i++){
        if(a[i]>a[high]){
            high=i;
        }
    }
    return a[high];
}
float findLowestMark(int x,float *a){
    int low=0;
    for(int i=1;i<x;i++){
        if(a[i]<a[low]){
            low=i;
        }
    }
    return a[low];
}
void output(float max,float min){
    printf("Maximum marks = %.2f\n",max);
    printf("Minimum marks = %.2f\n",min);
}

















