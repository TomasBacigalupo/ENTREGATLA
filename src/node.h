#ifndef _NODE_H_
#define _NODE_H_

#define MAX_STRING_SIZE 512

typedef struct Node {
    int type;
    char string[MAX_STRING_SIZE];
}Node;

Node * new_node(int type, char * string);

#endif
