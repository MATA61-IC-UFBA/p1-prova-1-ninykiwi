%{
#include "prova1.tab.h"
#include <stdlib.h>
#include <string.h>

void yyerror(const char *msg);
int yylex();

char lexema[100];
%}

%option noyywrap

DIGITO      [0-9]
INT         {DIGITO}+
REAL        {DIGITO}+"."{DIGITO}+

LETRA      [a-zA-Zà-úÀ-Ú][a-zA-Z0-9à-úÀ-Ú]*
ID         {LETRA}({LETRA}|{DIGITO}|_)*

%%

"print"     { return PRINT; }
"concat"    { return CONCAT; }
"length"    { return LENGTH; }

{REAL} {
    sprintf(lexema, "%s", yytext);
    return NUM;
}

{INT} {
    sprintf(lexema, "%s", yytext);
    return NUM;
}

\"[^\"]*\" {
    strcpy(lexema, yytext);
    return STRING;
}

{ ID } {
    strcpy(lexema, yytext);
    return IDENT;
}

"+"     { return PLUS; }
"-"     { return MINUS; }
"*"     { return TIMES; }
"/"     { return DIV; }
"("     { return LPAREN; }
")"     { return RPAREN; }
"="     { return ASSIGN; }
","     { return ','; }

"//".*   ;

[ \t]   ;

\n      { return EOL; }

.   { return ERROR; }

%%
