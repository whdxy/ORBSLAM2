#!/bin/bash

to_path=/home/whd/SLAM/MC-SLAM/result/Ground_Truth/
for id in {0..10}
do
	printf -v n "%0*d" 2 $id
	path=/home/whd/SLAM/kitti/odometry/data_odometry_color/$n/pose/
	#echo $path
	cd $path
	cp -r $path $to_path 
done



