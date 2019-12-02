GCC=gcc
GCCFLAGS= -Wall -pedantic -Wno-unused-function -g #-fsanitize=address
LEX=flex
YACC=yacc
YACC_FLAGS= -d
YACC_FILE= gramatica.y
LEX_FILE= lex2.l
OBJ= $(wildcard *.c)
TARGET = compiler

$(TARGET): $(OBJ:.c=.o)
	$(YACC) $(YACC_FLAGS) $(YACC_FILE)
	$(LEX) $(LEX_FILE)
	$(GCC) $(GCCFLAGS) -o $(TARGET) $(wildcard *.c)

clean:
	rm -rf $(OBJ:.c=.o) $(TARGET) y.tab.* lex.yy.*
