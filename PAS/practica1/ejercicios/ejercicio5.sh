#!/bin/bash

if [ $# -ne 1 ]; then #Comprueba si el número de argumentos es 1

    echo "Uso: $0 <directorio>"
    exit 1
fi

directorio=$1

if [ ! -d "$directorio" ]; then #Comprueba si el directorio origen existe

    echo "Error: El directorio no existe"
    exit 1
fi

ficheros=$(find $directorio -type f) #Almacena todos los archivos dentro de $directorio

for fichero in $ficheros; do  #Para cada fichero

    nombre=$(basename $fichero) #Nombre del fichero
    ruta=$fichero #Ruta del fichero
    tam=$(stat -c %s $fichero) #Tamaño del fichero
    #%s     Tamaño en bytes del fichero

    permisos=$(stat -c %A $fichero) #Permisos del fichero
    #%A     Permisos (-rwxr-xr--)
    
    fecha_mod=$(stat -c %Y $fichero) #Fecha de modificación
    #%Y     Timestamp unix (cuando fue modificado en segundos desde 1970)

    echo -e "$nombre\t$ruta\t$tam bytes\t$permisos\t$fecha_mod" #Imprime dividiento en tabuladores (\t)
done | sort -k5 -n  #Ordena por fecha de modificación
#sort -k5 -n    Ordena por el quinto campo (fecha_mod) en por formato numérico

echo
echo "Ejercicio finalizado correctamente"
exit 0