/*Write a C program to count the number of vowels and consonants in a given string 
using a user-defined function. The program should accept a string from the user and 
pass it to a function that performs the counting logic. (strings, while/do while)
Function Prototypes:
void input(char *str);
void count(char *str, int *vowels, int *consonants);
void display(char *str, int vowels, int consonants);*/
#include<stdio.h>
int main(){
    int vowels=0,consonants=0;
    char str[100];
    input(str);
    count(str,&vowels,&consonants);
    display(str,vowels,consonants);
    return 0;
}
void input(char *s){
    printf("Enter string: ");
    scanf("%99s",s);
}
void count(char *s,int *v,int *c){
    int i=0;
    while(s[i]!='\0'){
        if(s[i]=='a'||s[i]=='e's[i]=='i's[i]=='o's[i]=='u's[i]=='U's[i]=='O's[i]=='I's[i]=='E's[i]=='A'){
            ( *v )++;
        }
        else if((s[i]>='A'&&s[i]<='Z')||(s[i]>='a'&&s[i]<='z')){
            ( *c )++;
        }
        i++;
    }
}
void display(char *s,int v,int c){
    printf("Number of vowels in %s = %d\n",s,v);
    printf("Number of consonants in %s = %d\n",s,c);
}


























