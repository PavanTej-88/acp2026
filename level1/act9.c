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
    double bs;
}Employee;
void inputEmployees(Employee e[], int n);
void writeToTextFile(Employee e[], int n, const char *filename);
double calculateTotalPayroll(const char *filename);
void displayExpenditure(double total);
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
    double   tpy=calculateTotalPayroll("payroll.txt");
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
        scanf("%lf",&e[i].bs);
    }
}
void writeToTextFile(Employee *e,int n,const char *f){
    FILE *ptr=fopen(f,"w");
    if(ptr==NULL){
        printf("Error cannot open file\n");
        exit(-1);
    }
    for(int i=0;i<n;i++){
        fprintf(ptr,"%d %s %.2lf\n",e[i].id,e[i].n,e[i].bs);
    }
    fclose(ptr);
}
double calculateTotalPayroll(const char *f){
    double tbs;
    int id;
    char n[50];
    double t=0;
    FILE *ptr=fopen(f,"r");
    if(ptr==NULL){
        printf("Error cannot open file\n");
        exit(-1);
    }
    while((fscanf(ptr,"%d %s %lf",&id,n,&tbs))==3){
        t = t+tbs;
    }
    fclose(ptr);
    return t;
}
void displayExpenditure(double t){
    printf("Total expenditure = %.2lf\n",t);
}

































