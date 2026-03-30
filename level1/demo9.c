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
        printf("Enter student name: ");
        scanf("%s",(*s).n);
        printf("Enter student id: ");
        scanf("%d",&((*s).sid));
        printf("Enter student marks: ");
        scanf("%d",&((*s).m));
    }
}
void writeToTextFile(Student *s,int n,const char *f){
    FILE *ptr;
    ptr=fopen(f,"w");
    for(int i=0;i<n;i++){
        fprintf(ptr,"%s",s[i].n);
        fprintf(ptr,"%d",&s[i].sid);
        fprintf(ptr,"%d",s[i].m);
    }
    fclose(ptr);
}
int readFromTextFile(Student *s1,const char *f){
    FILE *ptr;
    int i=0;
    ptr=fopen(f,"r");
    while(ptr!=EOF){
        fscanf(ptr,"%s",s1[i].n);
        fscanf(ptr,"%d",&(s1[i].sid));
        fscanf(ptr,"%d",&(s1[i].m));
        i++;
    }
    fclose(ptr);
    return i;
}
void printStudents(Student *s1,int x){
    for(int i=0;i<x;i++){
        printf("Student %d:\n",i+1);
        printf("Name = %s\n",s1[i].n);
        printf("id = %d\n",s1[i].sid);
        printf("Marks = %d\n",s1[i].m);
    }
}
        




































