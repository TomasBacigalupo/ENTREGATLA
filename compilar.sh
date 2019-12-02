#!/bin/bash

# check if the source file exists
FILE_SOURCE="$1"
if [ ! ${FILE_SOURCE: -5} == ".ag" ]; then
    echo "El archivo debe ser de la extension .ag"
    exit 1
fi

# check if the number of arguments are correct
if [ "$#" -ne 2 ]; then
    echo ""
    exit 1
fi


# generate the code
cd src
./compilar < ${FILE_SOURCE} > out.c
cd ..