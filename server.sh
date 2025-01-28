#0 "FILE_NAMEi/bin/bash


PORT="2022"

echo "Servidor de Dragón Magia Abuelita Miedo 2022"

echo "0. ESCUCHAMOS"
DATA=`nc -l $PORT`

if [ "$DATA" != "DMAM" ]
then
	echo "ERROR 1: Cabecera incorrecta"
	echo "KO_HEADER" | nc localhost $PORT
	exit 1
fi

echo "2. CHECK OK - Enviando OK_HEADER"
echo "OK_HEADER" | nc localhost $PORT
DATA=`nc -l $PORT`

echo "5. COMPROBANDO PREFIJO y MD5SUM"
PREFIX=`echo "$DATA" | cut -d " " -f 1`
NOMBRE_ARCHIVO=`echo "$DATA" | cut -d " " -f 2`
MD5SUM_CLIENT=`echo "$DATA" | cut -d " " -f 3`

if [ "$PREFIX" != "FILE_NAME" ]
then
	echo "ERROR 2: Prefijo  incorrecto"
	echo "KO_FILE_NAME" | nc localhost $PORT
	exit 2
fi

MD5SUM_OBTENIDO=`echo -n "NOMBRE_ARCHIVO" | md5sum`

if [ "$MD5SUM_CLIENTE" != "$MD5SUM_OBTENIDO" ]
then
	echo "ERROR 3: El MD5 del nombre del archivo es incorrecto"
	echo "KO_FILE_NAME_MD5" | nc localhost $PORT
	exit 3
fi

echo "6. ENVIANDO OK_FILE_NAME"
echo "OK_FILE_NAME" | nc localhost $PORT
DATA=`nc -l $PORT`


echo "8. RECIBIENDO Y ALMACENANDO DATOS"
if [ "$DATA" == "" ]
then
	echo "ERROR 4: Datos incorrectos"
	echo "KO_DATA" | nc localhost $PORT
	exit 4
fi

echo "$DATA" > server/dragon.txt

echo "9. CHECK Y RESPUESTA"
echo "OK_DATA"| nc localhost $PORT
DATA=`nc -l $PORT`

echo "12. RECIBIENDO MD5"
PREFIX=`echo "$DATA" | cut -d " " -f 1`
MD5SUM_RECIBIDO=`echo "$DATA" | cut -d " " -f 2`
MD5SUM_OBTENIDO=`md5sum server/dragon.txt | cut -d " " -f 1`

echo "13. CHECK Prefix y MD5 - ENVIANDO OK_FILE_MD5"
if [ "$PREFIX" != "FILE_MD5" ]
then
	echo "ERROR 5: Prefijo  incorrecto"
	echo "KO_FILE_MD5" | nc localhost $PORT
	exit 5
fi

if [ "$MD5SUM_RECIBIDO" != "$MD5SUM_OBTENIDO" ]
then
	echo "ERROR 6: El MD5 del contenido del archivo es incorrecto"
	echo "KO_FILE_MD5" | nc localhost $PORT
	exit 6
fi


echo "OK_FILE_MD5"| nc localhost $PORT


