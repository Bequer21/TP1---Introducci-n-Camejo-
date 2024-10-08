#!/bin/bash

entrada=$1
infractores="infractores.txt"
tiempos_historicos="acertijo3.txt"
touch $infractores
touch $tiempos_historicos

if [ ! -s $entrada ];then
    exit 1
fi

numeros="años.txt"

# en caso de que el tiempo que demore sea de 4 digitos se tiene que ignorar ya que no va ser un año buscado
# ejmplo :  noombre1, 12/06/2017, 2372---> 2372 no debe ser tomado como año.
grep -E '/[0-9]{4}' $entrada | grep -o -E '[0-9]{4}' $entrada > $numeros

num=0

while read -r linea; do
    if [[ "$num" -le "$linea" ]]; then
        num="$linea" # Busco el año mayor, para luego a partir de ello buscar las fechas de los ultimos 5 años
    fi
done < "$numeros"    

num=$(("$num"-5)) # Le descuento 5 años para empezar a estar ordenando desde el menor año hasta el mayor

for i in $(seq 0 4); do
    grep "$num" $entrada > $numeros
    sort -t, -k 3,3n $numeros | head -n 3 >> $infractores
    num=$(("$num"+1))
done

rm $numeros

# Buscamos los 3 mejores tiempos historicos

sort -t, -k 3,3n $entrada | head -n 3 >> $tiempos_historicos