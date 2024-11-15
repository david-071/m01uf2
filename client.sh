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

echo "4. ENVIAR FILE_NAME"

FILE_NAME="dragon.txt"

echo "FILE_NAME $FILE_NAME" | nc localhost $PORT

DATA=`nc -l $PORT`

echo "7. COMPROVANDO OK_FILE_NAME"
if [ "$DATA" != "OK_FILE_NAME" ]
then
	echo "ERROR 2: El prefijo se envió incorrectamente"
	exit 2
fi
