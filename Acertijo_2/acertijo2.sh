#!/bin/bash

# .Cada línea debe comenzar con una letra mayúscula seguida de una letra minúscula. Si no se
#   cumple esto, el verso deberá ser eliminado.

# .Eliminar el verso si hay más de dos vocales consecutivas.

# .Eliminar el verso si contiene números.

# .Reemplazar las vocales con X

# .Si el verso tiene menos de 5 palabras invertir el contenido en la línea (orden de caracteres y
#   palabras).

# .Devolver un archivo venganza.txt con los versos modificados.

entrada=$1
salida=$2
touch $salida
if [ ! -s $entrada ];then
    exit 1
fi

if [ $# -ne 2 ]; then
    echo "Error: Se requieren exactamente dos argumentos."
    exit 1
fi
auxiliar1="auxiliar.txt"
auxiliar2="auxiliar2.txt"

# Elimina los versos que tienen mas de dos vocales seguidos, y elimina los versos que tienen numero 
grep -E -v '[aeiou]{3,}|[0-9]' $entrada > $auxiliar1

# Elimina las lineas que no comienzen con la letra mayuscula seguida de una letra minuscula.
grep '^[A-Z][a-z]' $auxiliar1 > $auxiliar2

# Modificar las vocales minusculas con la letra 'X' de la cancion.
sed -i 's/[aeiou]/X/g' $auxiliar2

# Con un ciclo empiezo a leer linea por linea.
while read -r linea; do
    cant_palabras=$(echo "$linea" | wc -w) #  wc -w para contar la cantidad de palabras
    if [ "$cant_palabras" -lt 5 ];then  # Verifico que si son menores a 5 los invierto
        echo "$linea" | rev >> "$salida"
    else
        echo "$linea" >> "$salida" # si son mayores e iguales a 5 lo escribo en la salida
    fi
done < "$auxiliar2"

rm $auxiliar1 $auxiliar2