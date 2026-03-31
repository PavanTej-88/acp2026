/*A startup needs a system to manage employee salaries and persist them for 
monthly auditing. Develop a modular C program to store employee records 
(ID, Name, and Basic Salary) in an array of structures. The program should write 
these records to a text file named payroll.txt. Subsequently, it should read the 
data from the file to calculate the total salary expenditure and display it. 
Function Prototypes:
    • void inputEmployees(Employee e[], int n);
    • void writeToTextFile(Employee e[], int n, const char *filename);
    • float calculateTotalPayroll(const char *filename);
    • void displayExpenditure(float total);*/
#include<stdio.h>
#include<stdlib.h>
typedef struct{
    int id;
    char n[50];
    float bs;
}Employee;
void inputEmployees(Employee e[], int n);
void writeToTextFile(Employee e[], int n, const char *filename);
float calculateTotalPayroll(const char *filename);
void displayExpenditure(float total);
int main(){
    int n;
    printf("Enter number of employees: ");
    scanf("%d",&n);
    if(n<=0){
        printf("Invalid number\n");
        return -1;
    }
    Employee e[n];
    inputEmployees(e,n);
    writeToTextFile(e,n,"payroll.txt");
    float tpy=calculateTotalPayroll("payroll.txt");
    displayExpenditure(tpy);
    return 0;
}
void inputEmployees(Employee *e,int n){
    for(int i=0;i<n;i++){
        printf("Enter employee %d details\n",i+1);
        printf("Enter employee id: ");
        scanf("%d",&e[i].id);
        printf("Enter employee name: ");
        scanf("%s",e[i].n);
        printf("Enter employee basic salary: ");
        scanf("%f",&e[i].bs);
    }
}
void writeToTextFile(Employee *e,int n,const char *f){
    FILE *ptr=fopen(f,"w");
    if(ptr==NULL){
        printf("Error cannot open file\n");
        exit(-1);
    }
    for(int i=0;i<n;i++){
        fprintf(ptr,"%d %s %f",e[i].id,e[i].n,e[i].bs);
    }
}
float calculateTotalPayroll(const char *f){
    float tbs;
    int id;
    char n[50];
    float t=0;
    FILE *ptr=fopen(f,"r");
    if(ptr==NULL){
        printf("Error cannot open file\n");
        exit(-1);
    }
    while((fscanf(ptr,"%d %s %f",&id,n,&tbs))==3){
        t = t+tbs;
    }
    return t;
}
void displayExpenditure(float t){
    printf("Total expenditure = %.2f\n",t);
}

































