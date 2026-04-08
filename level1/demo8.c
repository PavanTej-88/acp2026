/*Write a C program to concatenate two strings using user-defined functions. 
The program should accept two strings from the user and pass them to a function 
that performs the concatenation. (strings, while/do while)
Function prototype:
void input(char *str);
void concatenate_strings(char *str1, char *str2);
void display(char *str);
*/

#include<stdio.h>
#include<string.h>
void input(char * );
void concatenate_strings(char *,char * );
void display(char * );
int main(){
    char str1[100],str2[100];
    input(str1);
    input(str2);
    concatenate_strings(str1,str2);
    display(str1);
    return 0;
}
void input(char *x){
    printf("Enter string: ");
    scanf("%s",x);
}
void concatenate_strings(char *a,char *b){
    int i=0;
    int n=strlen(a);
    while(b[i]!='\0'){
        a[n+i]=b[i];
        i++;
    }
    a[n+i]='\0';
}
void display(char *x){
    printf("Concatenated string: %s\n",x);
}



















