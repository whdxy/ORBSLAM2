t1=$(date +%H%M%S)

cd ../Stereo

sequence=7
{
    for id in {0..99}
    do 
	
        #echo "MC-SLAM  sequence:"$sequence "id:"$id
        #echo "ORB-SLAM  sequence:"${sequence} "id:"${id} 
        echo "ORB-SLAME  sequence:"$sequence "id:"$id
	./stereo_kitti $sequence  $id
	
    done
} &

sequence=9
{
    for id in {0..99}
    do 
	
        #echo "MC-SLAM  sequence:"$sequence "id:"$id
        #echo "ORB-SLAM  sequence:"${sequence} "id:"${id} 
        echo "ORB-SLAME  sequence:"$sequence "id:"$id
	./stereo_kitti $sequence  $id
	
    done
} &
    

#wait
t2=$(date +%H%M%S)
echo -e "t1:\t$t1"
echo -e "t2:\t$t2"
