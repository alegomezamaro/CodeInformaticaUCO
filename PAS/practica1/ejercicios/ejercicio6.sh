#!/bin/bash

if [ $# -ne 1 ]; then #Comprueba si el número de argumentos es 1

    echo "Uso: $0 <directorio>"
    exit 1
fi

directorio="${1%/}" #Eliminamos / si tiene

if [ ! -d "$directorio" ]; then #Comprueba si el directorio origen existe

    echo "Error: El directorio no existe"
    exit 1
fi

lista=("$directorio") #Guardamos directorio

while [ ${#lista[@]} -gt 0 ]; do #Mientras haya elementos en lista 

    dir="${lista[0]}" #Obtenemos el primer elemento del array
    lista=("${lista[@]:1}") #Eliminamos el primer elemento del array
    index="${dir%/}/index.html" #Creamos una ruta/index.html
    
    echo "<!DOCTYPE html>" > "$index" #Creamos el fichero index.html
    echo "<html><body>" >> "$index" #Añadir el cuerpo del fichero
    echo "<h1>Contenido de $(basename "$dir")</h1>" >> "$index" #Añadimos el título
    echo "<ul>" >> "$index" #Añadimos la lista

    for elemento in "$dir"/*; do #Recorremos los elementos del directorio

        nombre=$(basename "$elemento") #Obtenemos el nombre del elemento

        if [ "$nombre" = "index.html" ]; then #Si el nombre es index.html, se salta

            continue
        fi

        if [ -d "$elemento" ]; then #Si es un directorio

            echo "<li><a href=\"$nombre/index.html\">$nombre</a></li>" >> "$index" #Añadir el enlace a index.html
            lista+=("$elemento") #Añadir el directorio a la lista

        else #Sino

            echo "<li>$nombre</li>" >> "$index" #Añadir el nombre del fichero al index.html
        fi
    done

    echo "</ul>" >> "$index" #Cerrar la lista
    echo "</body></html>" >> "$index" #Cerrar el fichero
    echo "Se ha creado el fichero $index con el contenido del directorio $dir" # Muestra un mensaje indicando que se ha creado el archivo index.html con el contenido del directorio correspondiente
done

echo
echo "Ejercicio finalizado correctamente"
exit 0