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
    int i=0;
    if(strlen(x)>strlen(y)){
        int k=strlen(x);
        char temp[k];
        for(i=0;i<=k;i++){
            temp[i]=x[i];
            x[i]=y[i];
            y[i]=temp[i];
        }
    }

        
    else if(strlen(y)>strlen(x)){
        int k=strlen(y);
        char temp[k];
        for(i=0;i<=k;i++){
            temp[i]=y[i];
            y[i]=x[i];
            x[i]=temp[i];
        }
    }
    else{
        int k=strlen(y);
        char temp[k];
        for(i=0;i<=k;i++){
            temp[i]=y[i];
            y[i]=x[i];
            x[i]=temp[i];
        }
}
}


























