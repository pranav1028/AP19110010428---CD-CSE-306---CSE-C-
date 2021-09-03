id [a-zA-Z][a-zA-Z0-9]*
numbers [+-]?[0-9]+
float [+-]?[0-9]+(\.[0-9])?(\E[+-]?[0-9])?

%{
#include<stdio.h>
#include<string.h>
int n=0,flag=0,i=0,com=0,scom=0,count=0;
char st[30][30];
%}

%%
\n {scom=0;count++;}
"//" {scom=1;fprintf(yyout," \n single line comment\n\n");}
"/*" {com=1;fprintf(yyout," \n comment start\n");}
"*/" {com=0;fprintf(yyout," \n comment end\n");}
"<=" {if(!com&&!scom) fprintf(yyout," \n %s is a relational operator less than or equal to \n",yytext);}
"<" {if(!com&&!scom) fprintf(yyout," \n %s is a relational operator less than \n",yytext);}
">=" {if(!com&&!scom) fprintf(yyout," \n %s is a relational operator greater than or equal to \n",yytext);}
">" {if(!com&&!scom) fprintf(yyout," \n %s is a relational operator greater than \n",yytext);}
"==" {if(!com&&!scom) fprintf(yyout," \n %s is a relational operator equal to \n",yytext);}
"!=" {if(!com&&!scom) fprintf(yyout," \n %s is a relational operator not equal to \n",yytext);}
"=" {if(!com&&!scom) fprintf(yyout," \n %s is assignment opertor \n",yytext);}
int | float | char | double | const | auto | long | static | void | 
main {if(!com&&!scom)fprintf(yyout," \n %s is keyword \n",yytext);}
{numbers} {if(!com&&!scom) fprintf(yyout," \n %s is an integer \n",yytext);}
{float} {if(!com&&!scom) fprintf(yyout," \n %s is a floating point number \n",yytext);}
{id} {if(!com&&!scom) fprintf(yyout," \n %s is an identifier \n",yytext);
                         if(!com&&!scom){
                         for(i=0;i<n;i++){
			 if (strcmp(st[i], yytext) == 0){
			 flag = 1;
			 break;}}
			 if (flag == 0){
			 strcpy(st[n++], yytext);}
			 flag = 0;}
                     }
.
%%

main()
{
	yyin =fopen("x.txt","r");
	yyout=fopen("y.txt","w");
	yylex();
	printf("\n the contents of symbol table are :\n");
	for(i=0;i<n;i++)
	{
	    printf("\n %s",st[i]); printf("\n");
	}
	printf(" \n no of lines = %d\n\n",count);
	return 0;
}

int yywrap()
{
return 1;
}
