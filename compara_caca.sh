#!/bin/sh

ulimit -c unlimited
ulimit -c
rm -fv /cores/*
rm -fv core*
#mv -fv ya_echos/* .
#rm -rfv ya_echos
#mkdir ya_echos
for caca in $(ls caca*txt)
do
	caca_truncada=""
	return_codi=0

	caca_truncada=${caca%.txt}
	echo "la caca actual $caca"
	echo "la caca truncada $caca_truncada"
	caca_log_c=$caca_truncada.c.log
	caca_log_piton=$caca_truncada.ref.log
	echo "la caca en c $caca_log_c"
	echo "la caca ref $caca_log_piton"
	date
	./$1 < $caca > $caca_log_c
	return_codi=$?
	date
	if [ $return_codi -ne 0 ] 
	then
		echo "verga, fallo en $caca"
		exit 1
	fi
	diferencia_ojala=$(diff $caca_log_c $caca_log_piton)
	echo "la diferencia es"
	#echo "$diferencia_ojala CACA"
	if [[ ! -z "$diferencia_ojala" && $return_codi -eq 0 ]]
	then
		echo "verga, diff en $caca"
		exit 1
	fi
#	mv $caca ya_echos/
done
