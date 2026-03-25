/*Write a C program to validate a password entered by the user based on the following rules:
    i. Password must be at least 8 characters long. // Use strlen() function
    ii. It must contain at least one uppercase letter, one lowercase letter, and one digit. 
Use a user-defined function to check these conditions and return whether the password is 
valid. (strings, for loop)
Function Prototypes:
void input(char *str);
int is_valid(char *str);
int is_upper(char c); // Sub function of is_valid()
int is_lower(char c); // Sub function of is_valid()
int is_digit(char c); // Sub function of is_valid()
void display(char *str, int res);*/
#include<stdio.h>
#include<string.h>
void input(char *str);
int is_valid(char *str);
int is_upper(char c);
int is_lower(char c);
int is_digit(char c);
void display(char *str, int res);
int main(){
    char s[100];
    input(s);
    int r=is_valid(s);
    display(s,r);
    return 0;
}
void input(char *x){
    printf("Enter password: ");
    fgets(x,100,stdin);
}
int is_valid(char *x){
    int u,l,d;
    int n=strlen(x);
    for(int i=0;i<n;i++){
        if((is_upper(x[i]))==1){
            u=1;
            break;
        }
    }
    for(int i=0;i<n;i++){
        if((is_lower(x[i]))==1){
            l=1;
            break;
        }
    }
    for(int i=0;i<n;i++){
        if((is_digit(x[i]))==1){
            d=1;
            break;
        }
    }
    if((n>=8)&&(u==1)&&(l==1)&&(d==1)){
        return 1;
    }
    else{
        return 0;
    }
}
int is_upper(char x){

        if((x>='A')&&(x<='Z')){
            return 1;
            
        }
        else{
            return 0;
        }
}
int is_lower(char x){
        if((x>='A')&&(x<='Z')){
            return 1;
            
        }
        else{
            return 0;
        }
}
int is_digit(char x){
        
        if((x>=0)&&(x<=9)){
            return 1;
        }
        else{
            return 0;
        }
}
void display(char *x,int r){
    if(r==1){
        printf("Valid password\n");
    }
    else{
        printf("Invalid password\n");
    }
}































