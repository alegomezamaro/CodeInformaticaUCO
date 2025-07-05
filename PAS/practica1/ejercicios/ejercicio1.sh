#!/bin/bash

if [ $# -ne 1 ]; then #Comprueba si el número de argumentos es 1

    echo "Error: No se proporcionó un argumento. $0 <directorio>"
    exit 1
fi

directorio=$1

if [ ! -d "$directorio" ]; then #Comprueba si el directorio existe

    echo "El directorio origen no existe"
    exit 1
fi

ficheros=$(find $directorio -type f) #Busca todos los ficheros (-type f) de "directorio"
primerFichero=$(find $directorio -type f | head -n 1) #Coge el primer fichero de la lista
lineas=$(cat $primerFichero | wc -l) #Cuenta las líneas del primer fichero
total=0
media=0

for ((i=1; i<=$lineas; i=$i+1)); do #Recorremos todas las líneas

    asistencia=0

    for fichero in $ficheros; do #Recorremos todos los ficheros

        lineaFichero=$(cat $fichero | head -n $i | tail -n 1) #Head lee las "i" primeras lineas y tail coge la ultima de ellas
        asistencia=(($asistencia+$lineaFichero)) #Sumamos el número de asistencias en dicha sesion
    done
    
    echo "Asistieron $asistencia personas a la sesión $i"
    total=(($total+$asistencia)) #Sumamos las asistencias totales

done

media=(($total/$lineas)) #Calculamos la media de asistencia  
echo "La media de asistencia es: $media"

echo
echo "Ejercicio finalizado correctamente"
exit 0 #Salir