#!/bin/sh

ulimit -c unlimited
ulimit -c
rm -fv /cores/*
rm -fv core*
#mv -fv ya_echos/* .
#rm -rfv ya_echos
#mkdir ya_echos
for prueba in $(ls in*txt)
do
	prueba_truncada=""
	return_codi=0

	prueba_truncada=${prueba%.*}
	echo "la prueba actual $prueba"
	echo "la prueba truncada $prueba_truncada"
	prueba_log_c=$prueba_truncada.c.log
	prueba_log_piton=$prueba_truncada.shame.log
#	echo "la prueba en c $prueba_log_c"
#	echo "la prueba ref $prueba_log_piton"
#	date
	$1 < $prueba > $prueba_log_c
	$2 < $prueba > $prueba_log_piton
	return_codi=$?
#	date
	if [ $return_codi -ne 0 ] 
	then
		echo "caramba, fallo en $prueba"
		exit 1
	fi
	diferencia_ojala=$(diff $prueba_log_c $prueba_log_piton)
#	echo "la diferencia es"
	#echo "$diferencia_ojala CACA"
	if [[ ! -z "$diferencia_ojala" && $return_codi -eq 0 ]]
	then
		echo "caramba, diff en $prueba"
		exit 1
	fi
#	mv $prueba ya_echos/
done
