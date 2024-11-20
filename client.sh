#!/bin/bash

if [ "$1" == "" ]
then
	echo "Debes indicar la dirección del servidor."
	echo "Ejemplo:"
	echo -e "\t$0 127.0.0.1"
	exit 1
fi

IP_SERVER=$1

IP=`ip a | grep "scope global" | xargs | cut -d " " -f 2 | cut -d "/" -f 1`

PORT="2022"

echo "Cliente de Dragón Magia Abuelita Miedo 2022"

echo "1. ENVÍO DE CABECERA"
echo "DMAM $IP" | nc $IP $PORT

DATA=`nc -l $PORT`

echo "3. COMPROVANDO OK_HEADER"
if [ "$DATA" != "OK_HEADER" ]
then
	echo "ERROR 1: El header se envió incorrectamente"
	exit 1
fi

echo "4. ENVIAR FILE_NAME"

FILE_NAME="dragon.txt"

echo "FILE_NAME $FILE_NAME" | nc $IP $PORT

DATA=`nc -l $PORT`

echo "7. COMPROVANDO OK_FILE_NAME"
if [ "$DATA" != "OK_FILE_NAME" ]
then
	echo "ERROR 2: El nombre se envió incorrectamente"
	exit 2
fi

echo "8. ENVIAR ARCHIVO"
cat Client/dragon.txt | nc $IP $PORT

DATA=`nc -l $PORT`
