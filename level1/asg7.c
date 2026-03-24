/*Write a C program to count how many words in a given sentence. 
Use a user-defined function to perform the counting. The sentence may 
contain multiple words separated by spaces. (strings, while/do while)
Function Prototypes:
void input(char *str);
int count_words(char *str);
void display(char *str, int count);*/
#include<stdio.h>
#include<string.h>
void input(char *str);
int count_words(char *str);
void display(char *str, int count);
int main(){
    char s[100];
    input(s);
    int w=count_words(s);
    display(s,w);
    return 0;
}
void input(char *x){
    printf("Enter sentence: ");
    fgets(x,100,stdin);
}
int count_words(char *x){
    int i=0,w=0;
    while((x[i]!='\0')&&(x[i]!='\n')){
        if(x[i]==' '){
            w++;
        }
        i++;
    }
    return w;
}
void display(char *x,int w){
    int i=0;
    while((x[i]!='\0')&&(x[i]!='\n')){
        i++;
    }
    x[i]='\0';
    printf("Number of spaces in the sentence '%s' is %d\n",x,w+1);
}




































