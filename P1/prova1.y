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
:
| stmt_list stmts
| stmt_list EOL
;

stmt
: IDENT ASSIGN expr
| IDENT ASSIGN expr EOL
| PRINT LPAREN exprlist RPAREN
| PRINT LPAREN exprlist RPAREN EOL
| expr
| expr EOL
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

