#include "symbol_table.h"
#include <stdlib.h>
#include <string.h>

#define MAX_SYMBOLS_SIZE 512
#define SYMBOL_NOT_FOUND -1

char symbols_table[MAX_SYMBOLS_SIZE][MAX_SYMBOLS_SIZE];
int symbols_type[MAX_SYMBOLS_SIZE];
int count_symbols = 0;
extern void yyerror(const char *s);


void same_type(int type1, int type2) {
    if(type1 != type2) { yyerror("diferentes tipos de datos"); exit(EXIT_FAILURE);}
}

int get_symbol_type(char * symbol){
    for(int i = 0;i < count_symbols; i++){
        if(strcmp(symbol, symbols_table[i]) == 0){
            return symbols_type[i];
        }
    }
    return SYMBOL_NOT_FOUND; //not found
}

void add_symbol(char * symbol_name, int symbol_type){
    //lookup
    if(strlen(symbol_name) > MAX_SYMBOLS_SIZE){
        yyerror("nombre de variable muy grande");
        exit(EXIT_FAILURE);
    }
    for(int i = 0; i < count_symbols; i++){
        if(strcmp(symbol_name, symbols_table[i]) == 0){
            //found
            yyerror("esta variable ya fue definida");
            exit(EXIT_FAILURE);
        }
    }
    strcpy(symbols_table[count_symbols], symbol_name);
    symbols_type[count_symbols++] = symbol_type;
}
