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

%token <int_val> NUM 1
%token <int_val> PLUST 2
%token <int_val> MINUST 3
%token <int_val> TIMEST 4
%token <int_val> DIVT 5
%token <int_val> RPART 6
%token <int_val> LPART 7
%token <int_val> COMMENT 8
%token <int_val> LENGTHF 9
%token <int_val> PRINTF 10
%token <int_val> ASSIGNT 11
%token <int_val> DQUOTET 12
%token <int_val> ID 13
%token <int_val> CONCATF 14
%token <int_val> SPACET 15
%token <int_val> COMMAT 16
%token <int_val> ERROR

/*
 * Garante assosciatividade à esquerda
 */
%left PLUS MINUS /* Menor precedência */
%left TIMES DIV  /* Maior que anterior precedência */
%left LPART RPART /* Maior precedência */

%start program


%%
program
    : stmt_list EOL
;

stmt_list
        : assign_stmt
        | func_stmt

assign_stmt
          : ID ASSIGNT stmt

stmt
    : expr
    | func_stmt
    | str

str
  : DQUOTET ID DQUOTET
  | DQUOTET SPACET DQUOTET

str_list
        : str COMMAT
        | str

func_stmt
        : CONCATF concat_stmt
        | LENGTHF length_stmt
        | PRINTF print_stmt

length_stmt
          : LPART str RPART
          | LPART ID RPART

print_stmt
          : LPART str RPART
          | LPART ID RPART

concat_stmt
          : LPART str_list RPART

expr
    : NUM PLUS expr
    | NUM MINUS expr
    | NUM TIMES expr
    | NUM DIV expr
    | LPART expr RPART
    | NUM
    ;

%%
