%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
extern int yyparse();
void yyerror(const char *msg);

%}

%union {
    int int_val;
    char* str_val;
}

%token EOL 0

%token <int_val> NUM
%token <int_val> PLUST
%token <int_val> MINUST
%token <int_val> TIMEST
%token <int_val> DIVT
%token <int_val> RPART
%token <int_val> LPART
%token <int_val> COMMENT
%token <int_val> LENGTHF
%token <int_val> PRINTF
%token <int_val> ASSIGNT
%token <int_val> STRING_LITERAL
%token <int_val> ID
%token <int_val> CONCATF
%token <int_val> SPACET
%token <int_val> COMMAT
%token <int_val> ERROR

/*
 * Garante assosciatividade à esquerda
 */
%left PLUST MINUST /* Menor precedência */
%left TIMEST DIVT  /* Maior que anterior precedência */
%left LPART RPART /* Maior precedência */

%start program


%%
program
    : stmt_list EOL
;

stmt_list
        : stmt_list stmt
        | stmt
        ;

stmt
    : assign_stmt
    | func_stmt
    ;


assign_stmt
          : ID ASSIGNT expr
          | ID ASSIGNT str
          | ID ASSIGNT func_stmt
          ;


str
  : STRING_LITERAL
  ;

str_list
        : str_list COMMAT str_item
        | str_item
        | ID
        ;

str_item
        : ID
        | str
        ;

func_stmt
        : CONCATF concat_stmt
        | LENGTHF length_stmt
        | PRINTF print_stmt
        ;

length_stmt
          : LPART str RPART
          | LPART ID RPART
          ;

print_stmt
          : LPART str RPART
          | LPART ID RPART
          ;

concat_stmt
          : LPART str_list RPART
          ;

expr
    : NUM PLUS expr
    | NUM MINUS expr
    | NUM TIMES expr
    | NUM DIV expr
    | LPART expr RPART
    | NUM
    ;

%%
