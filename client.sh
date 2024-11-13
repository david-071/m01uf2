#!/bin/bash

PORT="2022"

echo "Cliente de Dragón Magia Abuelita Miedo 2022"

echo "1. ENVÍO DE CABECERA"
echo "DMAM" | nc 127.0.0.1 $PORT

DATA=`nc -l $PORT`

if [ "$DATA" != "OK_HEADER" ]
then
	echo "ERROR 1: el header se envió incorrectamente"
	exit 1
fi

