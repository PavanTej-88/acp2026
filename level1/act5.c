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
    int n;
    printf("Enter size of string: ");
    scanf("%d",&n);
    char str1[n],str2[n];
    read_string(str1,n);
    read_string(str2,n);
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
    printf("Enter string1{max_size=%d}: \n",x);
    fgets(s,sizeof(s),stdin);
}
void print_string(char *s){
    printf("%s",s);
}
void swap_strings(char *x,char *y){
    int i=0;
    char temp;
    while((x[i]!='\0')&&(y[i]!='\0')){
        temp=x[i];
        x[i]=y[i];
        y[i]=temp;
        i++;
    }
}



























