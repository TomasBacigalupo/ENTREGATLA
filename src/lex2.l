%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "y.tab.h"
    #include "node.h"
    #include "data_types.h"
    extern void yyerror(const char * msg);
%}


digit   [0-9]
number  -?[0-9]+(\.[0-9]+)?
string  \"[^\"]*\"
var     [a-zA-Z]+
newline \
text [a-zA-z]([a-zA-z]|digit)*
exit    ("terminar")


%%
"igual"         {return SAME;}
"cambio"        {return CAMBIO;}
"text"          {return TEXT_T;}
"number"        {return NUMBER_T;}
">="            {return GET;}
">"             {return GT;}
"<="            {return LET;}
"<"             {return LT;}
"."             {yylineno++;return END_LINE;}; //sumar cantidad de lineas
"="             {return EQUALS;};
"inicio"        {return MAIN;};
"finsi"         {return ENDIF;};
"finciclo"      {return ENDCYCLE;};
"fin"           {return END;};
"si"            {return IF;};
"sino"          {return ELSE;};
"y"             {return AND;};
"o"             {return OR;};
"("             {return OP;};
")"             {return CP;};
"!="            {return DIF;};

"sobre"         {return DIV;};
"*"             {return MUL;};
"-"             {return MINUS;};
"+"             {return PLUS;};
"imprimir"      {return PRINT;}
"mientras"      {return WHILE;};
{number}        {
                    yylval.node = new_node(NUM_TYPE, yytext);
                    return NUM_C;
                }
{string}        {
                    yylval.node = new_node(STRING_TYPE, yytext);
                    return TEXT_C;
                }
{var}           {
                    yylval.node = new_node(STRING_TYPE, yytext);
                    return ID;
                }
.               { /* ignorar los demas caracteres */ }
%%

int yywrap(void){
    return 1;
}

void yyerror (char const *s) {
   fprintf (stderr, "%s at line %d\n", s, yylineno);
}

