#include<stdio.h>
#include<stdlib.h>
void pop(),push(char),display();
char stack[100]="\0", input[100], *ip;
int top=-1;
void push(char c)
{
    top++;
    stack[top]=c;
}
void pop()
{
    stack[top]='\0';
    top--;
}
void display()
{
    printf("\n%s\t%s\t",stack,ip);
}
void main()
{
    printf("E->E+E\n");
    printf("E->E*E\n");
    printf("E->(E)\n");
    printf("E->d\n");
    printf("Enter the input string followed by $ \n");
    scanf("%s",input);
    ip=input;
    push('$');
    printf("STACK\t BUFFER \t ACTION\n");
    printf("-----\t ------- \t ------\n");
    display();
    if(stack[top]=='$' && *ip=='$')
    {
        printf("Null Input");
        exit(0);
    }
    do
    {
        if((stack[top]=='E' && stack[top-1]=='$') && (*(ip)=='$'))
        {
            display();
            printf("\t Valid\n\n\n");
            break;
        }
        if(stack[top]=='$')
        {
            push(*ip);
            ip++;
            printf("Shift");
        }
        else if(stack[top]=='d')
        {
            display();
            pop();
            push('E');
            printf("\tReduce E->d");
        }
        else if(stack[top]=='E' && stack[top-1]=='+' && stack[top-2]=='E'&& *ip!='*')
        {
            display();
            pop();
            pop();
            pop();
            push('E');
            printf("\tReduce E->E+E");
        }
        else if(stack[top]=='E' && stack[top-1]=='*' && stack[top-2]=='E')
        {
            display();
            pop();
            pop();
            pop();
            push('E');
            printf("\tReduce E->E*E");
        }
        else if(stack[top]==')' && stack[top-1]=='E' && stack[top-2]=='(')
        {
            display();
            
            pop();
            pop();
            pop();
            push('E');
            printf("\tReduce E->(E)");
        }
        else if(*ip=='$')
        { 
            printf("\t Invalid\n\n\n");
            break;
        }
        else
        {
            display();
            push(*ip);
            ip++;
            printf("\tshift");
        }
    }while(1);
}