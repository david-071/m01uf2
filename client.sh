#!/bin/bash

PORT="2022"

echo "Cliente de Dragón Magia Abuelita Miedo 2022"

echo "1. ENVÍO DE CABECERA"
echo "DMAM" | nc 127.0.0.1 $PORT

DATA=`nc -l $PORT`

echo "3. COMPROVANDO OK_HEADER"
if [ "$DATA" != "OK_HEADER" ]
then
	echo "ERROR 1: El header se envió incorrectamente"
	exit 1
fi

<<<<<<< HEAD
echo "3. ENVIAR NOMBRE DE ARCHIVO"
echo "FILE_NAME dragon.txt" | nc localhost 2022

DATA=`nc -l $PORT`
=======
echo "4. ENVIAR FILE_NAME"

FILE_NAME="dragon.txt"

echo "FILE_NAME $FILE_NAME" | nc localhost $PORT

DATA=`nc -l $PORT`

echo "6. COMPROVANDO OK_FILE_NAME"
if [ "$DATA" != "OK_FILE_NAME" ]
then
	echo "ERROR 2: El prefijo se envió incorrectamente"
	exit 2
fi
>>>>>>> 13a1b7f (Implementació del envió del nombre de archivo)