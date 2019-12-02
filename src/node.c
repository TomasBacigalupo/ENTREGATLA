#include "node.h"
#include <stdlib.h>
#include <string.h>

Node * new_node(int type, char * string){
    Node * node = malloc(sizeof(Node));
    node->type = type;
    strcpy(node->string, string);
    return node;
}

