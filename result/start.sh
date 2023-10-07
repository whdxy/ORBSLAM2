path_to_vocabulary=/home/whd/SLAM/ORB_SLAM2/Vocabulary/ORBvoc.txt
path_to_settings=/home/whd/SLAM/ORB_SLAM2/result/myself.yaml

#name=2023-04-22-08-21-27
#name=2023-04-22-07-24-32
name=2023-04-22-07-39-36

#path_to_sequence=/mnt/nas/dataset/理想ONE_学校_0426/$name
path_to_sequence=/mnt/nas/dataset/理想ONE_公司_曹安公路_学校_0422/$name
path_to_save=/home/whd/SLAM/ORB_SLAM2/result/$name.txt

echo $path_to_sequence
echo $path_to_save
cd ../Stereo
./stereo_kitti $path_to_vocabulary $path_to_settings $path_to_sequence $path_to_save
