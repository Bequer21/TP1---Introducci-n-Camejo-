#!/bin/bash

# cueva = dobla
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
touch "$salida"
if [ ! -s $entrada ];then
    exit 1
fi

if [ $# -ne 2 ]; then
    echo "Error: Se requieren exactamente dos argumentos."
    exit 1
fi

codigo="codigo.txt"

# Con sed eliminamos todo lo que no este relacionado con lo buscado 'I' ignora el case de mayuscula y minuscula
sed 's/[^a-z]//gI' "$entrada" > "$salida"

# Funcion que nos permite realizar la busqueda en cuando a lo que se pide.
buscar_codigo() {
    case $1 in
        "cueva")
            palabra="doblar"
            ;;
        "secreta")
            palabra="izquierda"
            ;;
        "pocos")
            palabra="despues"
            ;;
        "metros")
            palabra="derecha"
            ;;
        "arriba")
            palabra="delante"
            ;;
        "atras")
            palabra="reversa"
            ;;
        *)
            return 1
            ;;
    esac
    return 0
}
while read -r palabra;do
    echo "${palabra,,}" >> "$codigo" # Convertimos en minuscula cada palabra
done < "$salida"

>"$salida" # Limpiamos la salida

while read -r linea;do
    if buscar_codigo "$linea"; then
       echo -n "$palabra" >> "$salida"
    fi
done < "$codigo"

echo "" >> "$salida"

rm "$codigo"
