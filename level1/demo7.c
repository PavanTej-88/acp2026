/*Write a C program to compare two strings using user-defined functions. The program should return:
    • 0 if both strings are equal
    • 1 if the first string is lexicographically greater
    • -1 if the second string is lexicographically greater
Function prototype:
void inputStrings(char str1[], char str2[]);
int compareStrings(char str1[], char str2[]);
void output(int result);
*/

#include<stdio.h>
void inputStrings(char *,char * );
int compareStrings(char *,char * );
void output(int);
int main(){
    char str1[100],str2[100];
    int n;
    inputStrings(str1,str2);
    n=compareStrings(str1,str2);
    output(n);
    return 0;
}
void inputStrings(char *a,char *b){
    printf("Enter string 1: ");
    scanf("%s",a);
    printf("Enter string 2: ");
    scanf("%s",a);
}
int compareStrings(char *a,char *b){
    int i=0;
    while(a[i]!="\0" && b[i]!="\0"){
        if(a[i]<b[i]){
            return -1;
        }
        else if(a[i]>b[i]){
            return 1;
        }
        else{
            return 0;
        }
        i++;
    }
}
void output(int x){
    if(x>0){
        printf("String 1 is larger\n");
    }
    else if(x<0){
        printf("String 2 is larger\n");
    }
    else{
        printf("Both strings are equal\n");
    }
}















