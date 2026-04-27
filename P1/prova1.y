%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
extern int yyparse();
void yyerror(const char *msg);

%}

%start program

%token NUM PLUS MINUS TIMES DIV LPAREN RPAREN
%token EOL
%token ERROR
%token IDENT STRING CONCAT LENGTH PRINT ASSIGN

%left PLUS MINUS
%left TIMES DIV

%%

/* programa */
program
: stmt_list 
; 

stmt_list
: stmt
| stmt_list stmt
;

stmt
: IDENT ASSIGN expr
| PRINT LPAREN exprlist RPAREN
| expr
;

exprlist
: expr
| exprlist ',' expr
;

expr
: expr PLUS expr
| expr MINUS expr
| expr TIMES expr
| expr DIV expr
| LPAREN expr RPAREN
| NUM
| STRING
| CONCAT LPAREN exprlist RPAREN
| LENGTH LPAREN expr RPAREN
| IDENT
;

%%

