/*Write a program to swap two strings.  
Function prototype:
void read_string(char str[], int size);
void print_string(char str[]);
void swap_strings(char str1[], char str2[]);*/
#include<stdio.h>
#include<string.h>
void read_string(char *str, int x);
void print_string(char *str);
void swap_strings(char *str1, char *str2);
int main(){
    int n1,n2;
    printf("Enter size of string1: ");
    scanf("%d",&n1);
    printf("Enter size of string2: ");
    scanf("%d",&n2);
    char str1[n1],str2[n2];
    read_string(str1,n1);
    read_string(str2,n2);
    printf("Strings before swapping:\n");
    print_string(str1);
    print_string(str2);
    swap_strings(str1,str2);
    printf("Strings after swapping:\n");
    print_string(str1);
    print_string(str2);
    return 0;
}
void read_string(char *s,int x){
    printf("Enter string{max_size=%d}: ",x);
    scanf("%s",s);
}
void print_string(char *s){
    printf("%s\n",s);
}
void swap_strings(char *x,char *y){
    int k=strlen(x)>strlen(y)?strlen(x):strlen(y);
    char temp[k+1];
    strcpy(temp,x);
    strcpy(x,y);
    strcpy(y,temp);
}


























