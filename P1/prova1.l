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
COMMENT  "//".*

%%



"concat"    { return CONCATF; }
"length"    { return LENGTHF; }
"print"     { return PRINTF; }
"="         { return ASSIGNT; }
\"[^\"]*\"  { return STRING_LITERAL; }


"print"       { return PRINTF; }

"/"           { return DIVT; }
"-"           { return MINUST; }
"+"           { return PLUST; }
"*"           { return TIMEST; }

{ID}          { return ID; }
{NUM}         { return NUM; }

"("           { return LPART; }
")"           { return RPART; }
","           { return COMMAT; }

[ \t]+        { /* Ignorar espaços em branco e quebras de linha */ }
\n            { return EOL; }
{COMMENT}    { /* Ignorar comentários */ }
"^_"          { return ERROR; }
.             { return ERROR; }

%%
