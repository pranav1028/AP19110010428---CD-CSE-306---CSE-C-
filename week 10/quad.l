%{
#include<stdio.h>
#include "quadraples_generation.tab.h"
#include<string.h>
%}
%%
[a-z]([a-z]|[0-9])* { strcpy(yylval.exp,yytext);

return VAR;
}
\t ;
\n return 0;
. return yytext[0];
%%