#!/bin/bash
cd src
yacc -d gramatica.y 
flex lex2.l 
make > /dev/null 2>&1
cd ..
echo Bienvenido a Aguila Compiler