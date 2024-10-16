#!/bin/bash

# Los numeros 1, 2 y 9 por X
# El 0 y 8 por _ (guión bajo)

entrada=$1
salida=$2

# Caso donde no se pudo ingresar dos argumentos
if [ $# -ne 2 ]; then
    echo "Error: Se requieren exactamente dos argumentos."
    exit 1
fi

touch $salida
# Si el archivo de entrada esta vacia no realiza ningun comando tan solo crea un archivo de salida vacia.
if [ ! -s $entrada ];then
    exit 1
fi

auxiliar="auxiliar.txt"
# reemplazar los numeros 1,2 y 9 por 'X' 
sed -E 's/[1]|[2]|[9]/X/g' $entrada > $auxiliar 

# reemplazar los numeros 0 y 8  por '_'
sed -E 's/[0]|[8]/_/g' $auxiliar > $salida

rm "$auxiliar"