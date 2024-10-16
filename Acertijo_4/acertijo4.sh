#!/bin/bash

# cueva = doblar
# secreta = izquierda
# pocos = despues
# metros = derecha
# arriba = delante
# atras = reversa

# Reciba el nombre del papiro (archivo con el mensaje) ingresado por Dipper (es decir, por el usuario).

# Escribir el primer mensaje en un nuevo archivo llamado ’mensaje_papiro.txt’.

# Que utilice el contenido de ’mensaje_papiro.txt’ para descifrar el mensaje y, que el mensaje
# final, se escriba en el mismo archivo. El mensaje final no debe tener espacios, debe estar todo
# junto.

entrada=$1
salida=$2 

# Caso donde no se pudo ingresar dos argumentos
if [ $# -ne 2 ]; then
    echo "Error: Se requieren exactamente dos argumentos."
    exit 1
fi

touch "$salida"
# Si el archivo de entrada esta vacia no realiza ningun comando tan solo crea un archivo de salida vacia.
if [ ! -s $entrada ];then
    exit 1
fi

codigo="codigo.txt"

# Con sed eliminamos todo lo que no este relacionado con lo buscado 'I' ignora el case de mayuscula y minuscula
sed 's/[^a-z]//gI' "$entrada" > "$salida"


sed -i 's/cueva/doblar/gI' $salida
sed -i 's/secreta/izquierda/gI' $salida
sed -i 's/pocos/despues/gI' $salida
sed -i 's/metros/derecha/gI' $salida
sed -i 's/arriba/delante/gI' $salida
sed -i 's/atras/reversa/gI' $salida

while read -r linea;do
    echo -n "$linea" >> "$codigo"
done < "$salida"

echo "" >> "$codigo"

>"$salida" # Limpiamos la salida

cp "$codigo" "$salida"

rm "$codigo"
