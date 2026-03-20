/*Write a C program using user-defined functions to
    i. Accept names of two students.
    ii. Find the length of each student's name.
    iii. Compare which student's name is longer and display an appropriate 
    message. (strings, while/do while, if)
Function Prototypes:
void input(char *name);
int calculate_name_length(char *name);
void compare_output(int len1, int len2);*/

#include<stdio.h>
void input(char *name);
int calculate_name_length(char *name);
void compare_output(int len1, int len2);
int main(){
    char s1[100],s2[100];
    printf("Enter name of student 1: ");
    input(s1);
    printf("Enter name of student 2: ");
    input(s2);
    int l1=calculate_name_length(s1);
    int l2=calculate_name_length(s2);
    compare_output(l1,l2);
    return 0;
}
void input(char *x){
    scanf("%99s",x);
}
int calculate_name_length(char *x){
    int i=0;
    while(x[i]!='\0'){
        i++;
    }
    return i;
}
void compare_output(int l1,int l2){
    printf("Length of student 1 name = %d\n",l1);
    printf("Length of student 2 name = %d\n",l2);
    if(l1>l2){
        printf("Student 1 name is longer with length = %d\n",l1);
    }
    else if(l1<l2){
        printf("Student 2 name is longer with length = %d\n",l2);
    }
    else{
        printf("Both students names have same length = %d\n",l2);
    }
}

































