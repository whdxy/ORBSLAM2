cd ../test

for sequence in {0..10}
do
    for id in {0..99}
    do
	
        #echo "MC-SLAM  sequence:"$sequence "id:"$id
        echo "ORB-SLAM  sequence:"${sequence} "id:"${id} 
	./stereo_kitti_test $sequence  $id
	
    done
done
