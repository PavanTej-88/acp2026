/*Develop a modular C program to manage a team of 11 cricket players and 
calculate the average runs of the team. Create a structure Player 
with the following members:
    • player_name
    • jersey_number
    • runs_scored
Create an array of 11 players. Write a program that:
    1. Reads the details of all 11 players.
    2. Calculates and displays the average runs scored by the team.
Function prototype:
void readPlayers(int n, Player p[]);
float calculateAverageRuns(int n, Player p[]);*/
#include<stdio.h>
#include<string.h>
#define y 11
typedef struct{
    char name[50];
    int jn,runs;
}Player;
void readPlayers(int n, Player *p);
float calculateAverageRuns(int n, Player *p);
int main(){
    Player p[y];
    readPlayers(y,p);
    float avg=calculateAverageRuns(y,p);
    return 0;
}
void readPlayers(int n,Player *x){
    for(int i=0;i<n;i++){
        printf("Enter details of player %d\n",i+1);
        printf("Enter player name: ");
        scanf("%s",x[i].name);
        printf("Enter jersey number: ");
        scanf("%d",&x[i].jn);
        printf("Enter number of runs: ");
        scanf("%d",&x[i].runs);
    }
}
float calculateAverageRuns(int n,Player *x){
    int sum=0;
    for(int i=0;i<n;i++){
        sum=sum+x[i].runs;
    }
    printf("Average runs by the team = %.2f\n",(float)sum/n);
    return (float)sum/n;
}


















