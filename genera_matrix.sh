caca=$1
DEBUG=1
for ((x=1;x<=caca;++x))
do
#	echo "generando mierda $x"
	fila=$(sh genera_numeros_random.sh $2 $3 $4|xargs)
#	echo "fila caca $fila"
	echo "$fila"
done
