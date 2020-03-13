#!/bin/sh

ulimit -c unlimited
ulimit -c
rm -fv /cores/*
rm -fv core*
#mv -fv ya_echos/* .
#rm -rfv ya_echos
#mkdir ya_echos
for input in $(ls in*txt)
do
	input_truncada=""
	return_codi=0

	input_truncada=${input%.txt}
	echo "la input actual $input"
	echo "la input truncada $input_truncada"
	input_log_c=$input_truncada.c.log
	input_log_piton=$input_truncada.ref.log
	echo "la input en c $input_log_c"
	echo "la input ref $input_log_piton"
	date
	# XXX: https://serverfault.com/questions/151109/how-to-get-current-unix-time-in-milliseconds-in-bash
	inicio=$(gdate +%s%N)
	$1 < $input > $input_log_c
	return_codi=$?
	final=$(gdate +%s%N)
	duracion=$(( final-inicio ))
	date
	if [ $return_codi -ne 0 ] 
	then
		echo "verga, fallo en $input"
		exit 1
	fi
	diferencia_ojala=$(diff $input_log_c $input_log_piton)
	echo "la diferencia es"
	#echo "$diferencia_ojala CACA"
	if [[ ! -z "$diferencia_ojala" && $return_codi -eq 0 ]]
	then
		echo "verga, diff en $input"
		exit 1
	fi
	echo "la duracion de $input es $duracion"
#	mv $input ya_echos/
done
