for sequence in {0..10}
do
	printf -v id "%0*d" 2 $sequence
	#echo $id
	mkdir $id
done
