#!/bin/bash

SOURCE="$1"

./src/compiler < ${SOURCE} > out.c
gcc -o ${SOURCE}.out out.c
rm -rf out.c