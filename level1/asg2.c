/*Write a C program to compare the cost of tiling three floors and 
determine the most expensive one using 
functions and structure. (else-if ladder)
typedef struct { 
char name[50]; 
float length; 
float width; 
float cost_per_unit; 
float total_cost; 
} Floor;
Function Prototypes:
Floor input();
float calculate_cost(Floor floor);
void compare_costs(Floor f1, Floor f2, Floor f3);*/
#include<stdio.h>
typedef struct{
    char n[50];
    float l,w,cpu,tc;
}Floor;
Floor input(void);
float calculate_cost(Floor x);
void compare_costs(Floor f1, Floor f2, Floor f3);
int main(){
    Floor f1,f2,f3;
    printf("Enter details for floor 1\n");
    f1=input();
    printf("Enter details for floor 2\n");
    f2=input();
    printf("Enter details for floor 3\n");
    f3=input();
    f1.tc=calculate_cost(f1);
    f2.tc=calculate_cost(f2);
    f3.tc=calculate_cost(f3);
    compare_costs(f1,f2,f3);
    return 0;
}
Floor input(void){
    Floor x;
    printf("Enter name of floor: ");
    scanf("%s",x.n);
    printf("Enter length of floor: ");
    scanf("%f",&x.l);
    printf("Enter width of floor: ");
    scanf("%f",&x.w);
    printf("Enter cost per unit for tiling: ");
    scanf("%f",&x.cpu);
    return x;
}
float calculate_cost(Floor x){
    x.tc=(x.l*x.w)*x.cpu;
    return x.tc;
}
void compare_costs(Floor f1,Floor f2,Floor f3){
    if((f1.tc>f2.tc)&&(f1.tc>f3.tc)){
        printf("Cost for tiling floor 1 is highest, cost = %.2f\n",f1.tc);
    }
    else if((f2.tc>f3.tc)&&(f2.tc>f1.tc)){
        printf("Cost for tiling floor 2 is highest, cost = %.2f\n",f2.tc);
    }
    else if((f3.tc>f1.tc)&&(f3.tc>f2.tc)){
        printf("Cost for tiling floor 3 is highest, cost = %.2f\n",f3.tc);
    }
    else if((f1.tc==f2.tc)&&(f1.tc>f3.tc)){
        printf("Cost for tiling floor 1 and floor 2 is highest, cost = %.2f\n",f1.tc);
    }
    else if((f2.tc==f3.tc)&&(f2.tc>f1.tc)){
        printf("Cost for tiling floor 2 and floor 3 is highest, cost = %.2f\n",f2.tc);
    }
    else if((f1.tc==f3.tc)&&(f1.tc>f2.tc)){
        printf("Cost for tiling floor 1 and floor 3 is highest, cost = %.2f\n",f3.tc);
    }
    else{
        printf("Cost for tiling for all floors is equal, cost = %.2f\n",f2.tc);
    }
}

















