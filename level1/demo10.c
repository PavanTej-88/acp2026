/*Write a modular C program to perform the following tasks using file handling functions:
    i. Read the details of n students from the user and store them in an array of structures
    ii. Write the array of structures to a binary file using fwrite().
    iii. Read the binary file into a second array of structures using fread().
    iv. Display the array of structures.
Function prototype:
void inputStudents(Student students[], int n);
void writeToBinaryFile(Student students[], int n, const char *filename);
int readFromBinaryFile(Student students[], const char *filename);
void printStudents(Student students[], int n);*/
#include<stdio.h>
#include<stdlib.h>
#define mi 50
typedef struct{
    int id,m;
    char n[50];
}Student;
void inputStudents(Student students[], int n);
void writeToBinaryFile(Student students[], int n, const char *filename);
int readFromBinaryFile(Student students[], const char *filename);
void printStudents(Student students[], int n);
int main(){
    int n;
    printf("Enter number of students: ");
    scanf("%d",&n);
    if(n<=0||n>mi){
        printf("Invalid number of students\n");
        return -1;
    }
    Student s[n];
    inputStudents(s,n);
    writeToBinaryFile(s,n,"students.bin");
    Student s1[n];
    int x=readFromBinaryFile(s1,"students.bin");
    printStudents(s1,x);
    return 0;
}
void inputStudents(Student *s,int n){
    for(int i=0;i<n;i++){
        printf("Enter details of student %d:\n",i+1);
        printf("ID: ");
        scanf("%d",&s[i].id);
        printf("Name: ");
        scanf("%s",s[i].n);
        printf("Marks: ");
        scanf("%d",&s[i].m);
    }
}
void writeToBinaryFile(Student *s,int n,const char *f){
    FILE *ptr=fopen(f,"wb");
    if(ptr==NULL){
        printf("Error opening file\n");
        exit(-1);
    }
    fwrite(s,sizeof(Student),n,ptr);
    fclose(ptr);
}
int readFromBinaryFile(Student *s1, const char *f){
    FILE *ptr=fopen(f,"rb");
    if(ptr==NULL){
        printf("Error opening file\n");
        exit(-1);
    }
    int size=fread(s1,sizeof(Student),mi,ptr);
    fclose(ptr);
    return size;
}
void printStudents(Student *s1,int x){
    for(int i=0;i<x;i++){
        printf("Student %d details:\n",i+1);
        printf("ID: %d\n",s1[i].id);
        printf("Name: %s\n",s1[i].n);
        printf("Marks: %d\n",s1[i].m);
    }
}


















































