#!/bin/bash

# Contar la cantidad de veces que se lee la palabra “misterio” del diario llamada paginaDiario.txt.

# Pasar por argumento las veces que Mabel dice "Mabel no esta aqui está en sueterlandia". Si
#  ese número es par, calcular su factorial y si es impar calcular su fibonacci.

entrada=$1
numero=$2
salida=$3

if [ ! -s $entrada ];then
    exit 1
fi

if [ $# -ne 3 ]; then
    echo "Error: Se requieren exactamente tres argumentos."
    exit 1
fi

if ! [[ "$2" =~ ^[0-9]+$ ]]; then # verificamos si el segundo argumento sea un numero y no una letra o letra con numero
    echo "ERROR: El segundo argumento tiene que ser un numero"
    exit 1
elif [ "$2" -lt 0 ]; then # verificamos que el segundo argumento sea un numero natural incluido el 0
    echo "ERROR: El segundo argumento tiene que ser un numero mayor e igual que 0."
    exit 1
fi

clave="misterio"
# Buscamos la cantidad de palabras 'misterio' que aparece, 
# podria estar al inicio o al final, en mayuscula
# grep -E -i  -o '(misterio | misterio | misterio$)' paginaDiario.txt | wc -w 
grep -E -i -o "($clave | $clave | $clave$)" $entrada | wc -w >> $salida

factorial() {
    acum=1
    for i in $(seq 1 $1); do
            acum=$(($acum * $i))
    done
    echo "$acum" >> $salida
    return 0
}

fibonacci() {
    if [ $1 -eq 0 ]; then
        res=0
        return
    elif [ $1 -eq 1 ]; then 
        res=1
        return
    fi
    anterior=0
    res=1
    for i in $(seq 2 $1); do
        aux=$res
        res=$(($anterior + $res))
        anterior=$aux
    done
}

if [ $(($numero%2)) -eq 0 ]; then
    factorial "$numero"
else
    fibonacci "$numero"
    echo "$res" >> $salida
fi 
