%{
    #include "./node.h"
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <stdarg.h>
    #include "data_types.h"
    #include "symbol_table.h"

    extern int yylex();
    void yyerror(const char * s);
    char* strcat_va(int count, ...);
    int yydebug=1;
%}

%union {
    struct Node * node;
}

%token NUMERO
%token VARIABLE
%token EQUALS
%token var
%token SAME
%token LT
%token LET
%token GT
%token GET
%token WHILE
%token AND OR
%token OP CP
%token DIF DIV MINUS MUL PLUS
%token ENDCYCLE
%token PRINT
%token CAMBIO


%token<node> ID
%token<node> END_LINE
%token<node> END
%token<node> MAIN
%token<node> IF
%token<node> ELSE
%token<node> ENDIF

%token<node> NUMBER_T
%token<node> TEXT_T




%token<node> NUM_C
%token<node> TEXT_C


%type<node> ASSIGNMENT
%type<node> EXPRESSION
%type<node> STATEMENT
%type<node> TERM
%type<node> CODE
%type<node> CONDITION
%type<node> DEFINITION


%right EQUALS DIF
%left GT GET LT LET
%left  EQUALSCMP NTEQUAL
%left PLUS MINUS MUL DIV MOD
%left OR AND NOT

%start PROGRAM

%%

PROGRAM : MAIN CODE END {
                        printf("#include <stdio.h>\n#include <string.h>\nint main(){\n");
                        printf("%s", $2->string);
                        printf("}\n");
                        exit(EXIT_SUCCESS);
                        }
        | MAIN END{
                 printf("int main(){\n");
                 printf("}\n");
                 exit(EXIT_SUCCESS);
        }

CODE:    STATEMENT {$$ = new_node(STRING_TYPE,strcat_va(2,$1->string," "));};
        | STATEMENT CODE{$$ = new_node(STRING_TYPE, strcat_va(3, $1->string, "\t", $2->string));};

STATEMENT   : PRINT EXPRESSION END_LINE {
                if(get_symbol_type((char *)$2->string) == STRING_TYPE || $2->type == STRING_TYPE){
                    $$ = new_node(STRING_TYPE, strcat_va(3, "printf(\"%s\\n\",", $2->string , ");\n" ));
                }else if(get_symbol_type((char *)$2->string) == NUM_TYPE || $2->type == NUM_TYPE){
                    $$ = new_node(NUM_TYPE, strcat_va(3, "printf(\"%d\\n\",", $2->string , ");\n" ));
                }
            }
            | END_LINE {$$ = new_node(STRING_TYPE, "\n");}
            | ASSIGNMENT END_LINE { printf("%s", $1->string); $$ = new_node($1->type, $1->string);}
            | DEFINITION END_LINE {$$ = new_node($1->type, $1->string);}
            | IF CONDITION CODE ELSE CODE ENDIF { $$ = new_node($2->type, strcat_va(7,"if(", $2->string, "){\n", $3->string, "\n}", "else{\n", $5->string)); }
            | WHILE CONDITION CODE ENDCYCLE
{$$ = new_node(STRING_TYPE,strcat_va(5,"while(",$2->string,")\n","{", $3->string ,"};\n"));}
            ;

ASSIGNMENT : CAMBIO ID EQUALS EXPRESSION {
            //same_type(get_type($2->string),$4->type); //TODO
            $$ = new_node($4->type,strcat_va(4,$2->string,"=",$4->string,";\n"));};



DEFINITION  :  ID EQUALS EXPRESSION {
            add_symbol($1->string, $3->type);
            //same_type(get_symbol_type($2->string),$3->type); //FIXME
            if($3->type == NUM_TYPE){
                $$ = new_node($1->type, strcat_va(6, "int", " ", $1->string, "=", $3->string,";\n"));
            }else{
                $$ = new_node($1->type, strcat_va(6, "char *", " ", $1->string, "=", $3->string,";\n"));
            }};

CONDITION : EXPRESSION SAME EXPRESSION  {
           //same_type(get_symbol_type($1->string),$3->type);
           if($3->type==STRING_TYPE)
            $$ = new_node(STRING_TYPE, strcat_va(5, "(strcmp(", $1->string, ",", $3->string, ")==0)"));
           else
            $$ = new_node(STRING_TYPE, strcat_va(5, "(", $1->string, " == ", $3->string, ")"));
           }
           | EXPRESSION DIF EXPRESSION     {
           //same_type(get_symbol_type($1->string),$3->type);
           if($3->type==STRING_TYPE)
            $$ = new_node(STRING_TYPE, strcat_va(5, "(strcmp(", $1->string, ",", $3->string, ")!=0)"));
           else
            $$ = new_node(STRING_TYPE, strcat_va(5, "(", $1->string, " != ", $3->string, ")"));
           }
           | EXPRESSION GT EXPRESSION      {
           //same_type(get_symbol_type($1->string),$3->type);
           if($3->type==STRING_TYPE)
            $$ = new_node(STRING_TYPE, strcat_va(5, "(strcmp(", $1->string, ",", $3->string, ")>0)"));
           else
            $$ = new_node(STRING_TYPE, strcat_va(5, "(", $1->string, " > ", $3->string, ")"));
           }
           | EXPRESSION GET EXPRESSION     {
           //same_type(get_symbol_type($1->string),$3->type);
           if($3->type==STRING_TYPE)
            $$ = new_node(STRING_TYPE, strcat_va(5, "(strcmp(", $1->string, ",", $3->string, ")>=0)"));
           else
            $$ = new_node(STRING_TYPE, strcat_va(5, "(", $1->string, " >= ", $3->string, ")"));
           }
           | EXPRESSION LT EXPRESSION      {
            //same_type(get_symbol_type($1->string),$3->type);
           if($3->type == STRING_TYPE)
            $$ = new_node(STRING_TYPE, strcat_va(5, "(strcmp(", $1->string, ",", $3->string, ")<0)"));
           else
            $$ = new_node(STRING_TYPE, strcat_va(5, "(", $1->string, "<", $3->string, ")"));
           }
           | EXPRESSION LET EXPRESSION     {
           //same_type(get_symbol_type($1->string),$3->type);
           if($3->type==STRING_TYPE)
            $$ = new_node(STRING_TYPE, strcat_va(5, "(strcmp(", $1->string, ",", $3->string, ")<=0)"));
           else
            $$ = new_node(STRING_TYPE, strcat_va(5, "(", $1->string, " <= ", $3->string, ")"));
           }
           | OP CONDITION OR CONDITION CP {$$ = new_node(STRING_TYPE, strcat_va(5, "(", $2->string, " || ", $4->string, ")"));}
           | OP CONDITION AND CONDITION CP {$$ = new_node(STRING_TYPE, strcat_va(5, "(", $2->string, " && ", $4->string, ")"));};

EXPRESSION  : TERM  {$$ = $1;}
            |EXPRESSION PLUS EXPRESSION{
                //same_type(get_symbol_type($1->string),$3->type);
                if($3->type == STRING_TYPE){
                $$ = new_node(STRING_TYPE, strcat_va(5,"concat(",$1->string,",",$3->string,")"));
                }else{
                    $$ = new_node(NUM_TYPE, strcat_va(5,"(",$1->string,")+(",$3->string,")"));
                }}
            | EXPRESSION MINUS EXPRESSION {
                if($1->type == STRING_TYPE || $3->type == STRING_TYPE){
                    yyerror("Operacion Invalida - se requieren operandos del tipo numero.");
                    exit(1);
                }
                else{
                    $$ = new_node(NUM_TYPE,strcat_va(5,"(",$1->string,")-(",$3->string,")"));
                }
            }
            |EXPRESSION MUL EXPRESSION {
                if($1->type == STRING_TYPE || $3->type == STRING_TYPE){
                    yyerror("Operacion Invalida - se requieren operandos del tipo numero.");
                    exit(1);
                }
                else{
                    $$ = new_node(NUM_TYPE, strcat_va(5,"(",$1->string,")*(",$3->string,")"));
                }
            }
            |EXPRESSION DIV EXPRESSION{
                if($1->type == STRING_TYPE || $3->type == STRING_TYPE){
                    yyerror("Operacion Invalida - se requieren operandos del tipo numero.");
                    exit(1);
                } //puede que necesite el getsumbol
                else{
                    if($3->string ==0 ){
                        yyerror("Recuerde que no puede dividir por cero");
                        exit(1);
                    }else{
                        $$ = new_node(NUM_TYPE, strcat_va(5,"(",$1->string,")/(",$3->string,")"));
                    }
                }
            }



TERM        : TEXT_C {$$ = new_node(STRING_TYPE, $1->string);}
            | NUM_C {$$ = new_node(NUM_TYPE, $1->string);}
            | ID {$$ = new_node(STRING_TYPE, $1->string);}


%%


char* strcat_va(int count, ...){
    if(count<=1) return NULL;
    char* next,  *ret;
    int length = 0;
    va_list strings;
    va_start(strings, count);
    next = va_arg(strings, char*);
    length = strlen(next)+ 1;
    ret = (char*)malloc(length * sizeof(char));
    strcpy(ret, next);
    for(int i = 1; i < count ; i++){
        next = va_arg(strings, char*);
        length += strlen(next);
        ret = (char*)realloc((void*)ret, length);
        strcat(ret, next);
    }
    va_end(strings);
    return ret;
}

int main(){
    yyparse();
}
