/*Write a program to swap two structures.
typedef struct {
    char name[50];
    int age;
} Person;  
Function prototype:
void read_person(Person *p);
void print_person(Person *p);
void swap_person(Person *p1, Person *p2);*/
#include<stdio.h>
#include<string.h>
typedef struct{
    char n[50];
    int age;
}Person;
void read_person(Person *p);
void print_person(Person *p);
void swap_person(Person *p1, Person *p2);
int main(){
    Person p1,p2;
    printf("Enter details of person 1\n");
    read_person(&p1);
    printf("Enter details of person 2\n");
    read_person(&p2);
    printf("Structures before swapping\n");
    printf("Person 1\n");
    print_person(&p1);
    printf("Person 2\n");
    print_person(&p2);
    swap_person(&p1,&p2);
    printf("Structures after swapping\n");
    printf("Person 1\n");
    print_person(&p1);
    printf("Person 2\n");
    print_person(&p2);
    return 0;
}
void read_person(Person *p){
    printf("Enter person name: ");
    scanf("%49s",((*p).n));
    printf("Enter person age: ");
    scanf("%d",&((*p).age));
}
void print_person(Person *p){
    printf("Name: %s\n",((*p).n));
    printf("Age: %d\n",((*p).age));
}
void swap_person(Person *p1,Person *p2){
    Person temp;
    strcpy(temp.n,((*p1).n));
    strcpy(((*p1).n),((*p2).n));
    strcpy(((*p2).n),temp.n);
    temp.age=(*p1).age;
    (*p1).age=(*p2).age;
    (*p2).age=temp.age;
}