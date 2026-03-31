/*Write a modular C program to perform the following tasks using file handling functions:
    i. Read the details of n students from the user and store them in an array of structures.
    ii. Write the array of structures to a text (ASCII) file using fprintf().
    iii. Read the data back from the ASCII file into a second array using fscanf() and display it.
    iv. Display the array of structures.
Function prototype:
void inputStudents(Student students[], int n);
void writeToTextFile(Student students[], int n, const char *filename);
int readFromTextFile(Student students[], const char *filename);
void printStudents(Student students[], int n);*/
#include<stdio.h>
#include<stdlib.h>
typedef struct{
    char n[50];
    int sid;
    int m;
}Student;
void inputStudents(Student students[], int n);
void writeToTextFile(Student students[], int n, const char *filename);
int readFromTextFile(Student students[], const char *filename);
void printStudents(Student students[], int n);
int main(){
    int n;
    //const char f[50]="student.txt";
    printf("Enter number of students: ");
    scanf("%d",&n);
    if(n<=0){
        printf("Invalid number of students\n");
        return -1;
    }
    Student s[n];
    inputStudents(s,n);
    writeToTextFile(s,n,"students.txt");
    Student s1[n];
    int x=readFromTextFile(s1,"students.txt");
    printStudents(s1,x);
    return 0;
}
void inputStudents(Student *s,int n){
    for(int i=0;i<n;i++){
        printf("Enter student %d details\n",i+1);
        printf("Enter student name: ");
        scanf("%s",s[i].n);
        printf("Enter student id: ");
        scanf("%d",&(s[i].sid));
        printf("Enter student marks: ");
        scanf("%d",&(s[i].m));
    }
}
void writeToTextFile(Student *s,int n,const char *f){
    FILE *ptr;
    ptr=fopen(f,"w");
    if(ptr==NULL){
        printf("Error opening file\n");
        exit(-1);
    }
    for(int i=0;i<n;i++){
        fprintf(ptr,"%s %d %d",s[i].n,s[i].sid,s[i].m);
    }
    fclose(ptr);
}
int readFromTextFile(Student *s1,const char *f){
    FILE *ptr;
    int i=0;
    ptr=fopen(f,"r");
    if(ptr==NULL){
        printf("Error opening file\n");
        exit(-1);
    }
    while((fscanf(ptr,"%s %d %d",s1[i].n,&s1[i].sid,&s1[i].m))==3){
        i++;
    }
    fclose(ptr);
    printf("Read %d students\n",i);
    for(int j=0;j<20;j++){
        printf("=");
    }
    printf("\n");
    return i;
}
void printStudents(Student *s1,int x){
    printf("%d students details:\n",x);
    for(int i=0;i<x;i++){
        printf("Student %d:\n",i+1);
        printf("Name\tId\tMarks\n");
        printf("%s\t",s1[i].n);
        printf("%d\t",s1[i].sid);
        printf("%d\n",s1[i].m);
    }
}
        




































