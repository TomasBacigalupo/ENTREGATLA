#!/bin/bash

FILE_SOURCE="$1"

# generate the code
./src/compiler < ${FILE_SOURCE} > out.c
gcc -o ${FILE_SOURCE}.out out.c
##rm -rf out.c