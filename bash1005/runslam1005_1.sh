cd ../test

for sequence in {1..1}
do
    for id in {0..20}
    do
        echo "ORB-SLAM kitti sequence:"${sequence} "id:"${id} 
	./stereo_kitti_test $sequence  $id
	
    dones
done
