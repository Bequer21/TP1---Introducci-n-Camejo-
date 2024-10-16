#!/bin/bash

entrada=$1
infractores="infractores.txt"
tiempos_historicos="acertijo3.txt"

# Caso donde no se pudo ingresar un argumentos
if [ $# -ne 1 ]; then
    echo "Error: Se requieren exactamente un argumentos."
    exit 1
fi

touch $infractores
touch $tiempos_historicos
# Si el archivo de entrada esta vacia no realiza ningun comando tan solo crea dos archivos vacios
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
    sort -t, -k 3,3n $numeros | head -n 3 >> $infractores # detallado en las ultimas lineas
    num=$(("$num"+1))
done

rm $numeros

# Buscamos los 3 mejores tiempos historicos
sort -t, -k 3,3n $entrada | head -n 3 >> $tiempos_historicos # detallado en las ultimas lineas

# -k 3,3n indica que se debe ordenar por la tercera columna de cada linea de menor a mayor.
# -t, delimitador de campo es una coma, por ser un archivo csv
# head -n 3 toma solo las primeras 3 lineas de la salida anterior
# sort --> https://www.gnu.org/software/coreutils/manual/html_node/sort-invocation.html
# head --> https://www.gnu.org/software/coreutils/manual/html_node/head-invocation.html#head-invocation
