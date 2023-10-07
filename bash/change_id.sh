for sequence in {1..10}
do
	printf -v sequence_2 "%0*d" 2 $sequence
	cd /home/whd/SLAM/MC-SLAM/result/ORB-SLAM/$sequence_2
	for id in {0..99}
	do
		printf -v id_2 "%0*d" 2 $id
		printf -v id_3 "%0*d" 3 $id
		#echo $id
		mv $id_2.txt $id_3.txt
	done
done
