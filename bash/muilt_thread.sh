#!/bin/bash

t1=$(date +%H:%M:%S)
t11=`date +%s`
to_path=/home/whd/SLAM/MC-SLAM/result/Ground_Truth/
for id in {0..100}
do {
	
	sleep 10
	printf -v n "%0*d" 2 $id
	echo $n
} &
done

wait
t2=$(date +%H:%M:%S)
t22=`date +%s`
t=$[t22-t11]
echo -e "t1:  $t1"
echo -e "t2:  $t2"
echo -e "t:   $t"

