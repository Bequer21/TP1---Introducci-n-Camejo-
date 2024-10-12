#!/bin/bash

# Para capturar a Pato, es necesario que esté en la misma subsala que los gemelos, que se
# haya resbalado en el barro o se esté limpiando las pezuñas, y además, la hora en la que
# se encuentre no debe tener minutos par.

entrada=$1
salida=$2

if [ $# -ne 2 ]; then
    echo "Error: Se requieren exactamente dos argumentos."
    exit 1
fi

touch $salida
if [ ! -s $entrada ];then
    exit 1
fi

# Acciones que tiene que tener Pato para ser encontrado, tan solo realiza una de las acciones.
accion1="limpió las pezuñas"
accion2="resbaló en el barro"

# Aqui se estara guardando la primero busquea que es importante el horario y sala.
auxiliar="auxiliar.txt"
auxiliar2="auxiliar2.txt"

# La sala tiene que ser 7,y el numero anterior tiene que ser impar.
grep  '[13579] [7]' $entrada > $auxiliar

# Busca en un archivo auxiliar las dos acciones de pato
grep -E "($accion1|$accion2)" $auxiliar > $auxiliar2

# solo buscamos la primera aparicion en este caso la primera linea 
hora=$(grep -o -m 1 '[0-2][0-9]:[0-5][0-9]' $auxiliar2)

# se imprime con el formato pedido en el archivo de salida
echo "Hora indicada para capturar a Pato : $hora" > $salida

rm $auxiliar
rm $auxiliar2
