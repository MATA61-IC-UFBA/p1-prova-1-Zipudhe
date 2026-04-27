%{
#include "prova1.tab.h"
#include <stdlib.h>
#include <string.h>

void yyerror(const char *msg);
int yylex();
%}

%option noyywrap

DIGIT     [0-9]
NUM       {DIGIT}+(\.{DIGIT}+)?
ID        [a-zA-Z][a-zA-Z0-9_]{0,255}

%%

[ \t]+ {}
\s+         { return SPACET; }

{NUM}       { return  NUM; }

"\\"        { return COMMENT; }

"concat"    { return CONCATF; }
"length"    { return LENGTHF; }
"print"     { return PRINTF; }
"="         { return ASSIGNT; }

"+"         { return PLUS; }
"-"         { return MINUS; }
"*"         { return TIMES; }
"/"         { return DIV; }
"("         { return LPART; }
")"         { return RPART; }
\"          { return DQUOTET; }

","         { return COMMAT; }

\n          { return EOL; }
.           { return ERROR; }

%%
