#!/bin/bash

path_ground_truth=/home/whd/SLAM/MC-SLAM/result/Ground_Truth/
path_save=/home/whd/SLAM/MC-SLAM/result/EVO/mc-slam
#path_ORB_SLAM=/home/whd/SLAM/MC-SLAM/result/ORB-SLAM
path_MC_SLAM=/home/whd/SLAM/MC-SLAM/result/MC-SLAM

cd $path_ground_truth

for sequence in {5..10}
do
    for id in {0..299}
    do
	printf -v n_sequence "%0*d" 2 $sequence
	printf -v n_id "%0*d" 3 $id
        #echo "evo: ORB-SLAM  sequence:"$n_sequence "id:"$n_id
          
        
        evo_ape kitti $n_sequence.txt $path_MC_SLAM/$n_sequence/$n_id.txt  --save_results $path_save/ape/$n_sequence/orb$n_id.zip
        evo_res $path_save/ape/$n_sequence/orb$n_id.zip --save_table $path_save/ape/$n_sequence/orb$n_id.csv 
	rm -rf $path_save/ape/$n_sequence/orb$n_id.zip
	
	evo_ape kitti $n_sequence.txt $path_MC_SLAM/$n_sequence/$n_id.txt -a -s --save_results $path_save/ape/$n_sequence/orb_as$n_id.zip
        evo_res $path_save/ape/$n_sequence/orb_as$n_id.zip --save_table $path_save/ape/$n_sequence/orb_as$n_id.csv 
	rm -rf $path_save/ape/$n_sequence/orb_as$n_id.zip
	
	evo_rpe kitti $n_sequence.txt $path_MC_SLAM/$n_sequence/$n_id.txt --delta 100 --delta_unit m --save_results $path_save/rpe_t/$n_sequence/orb$n_id.zip
	evo_res $path_save/rpe_t/$n_sequence/orb$n_id.zip --save_table $path_save/rpe_t/$n_sequence/orb$n_id.csv 
	rm -rf $path_save/rpe_t/$n_sequence/orb$n_id.zip
	
	evo_rpe kitti $n_sequence.txt $path_MC_SLAM/$n_sequence/$n_id.txt --delta 100 --delta_unit m -a -s --save_results $path_save/rpe_t/$n_sequence/orb_as$n_id.zip
	evo_res $path_save/rpe_t/$n_sequence/orb_as$n_id.zip --save_table $path_save/rpe_t/$n_sequence/orb_as$n_id.csv 
	rm -rf $path_save/rpe_t/$n_sequence/orb_as$n_id.zip

	evo_rpe kitti $n_sequence.txt $path_MC_SLAM/$n_sequence/$n_id.txt -r angle_deg --delta 100 --delta_unit m --save_results $path_save/rpe_R/$n_sequence/orb$n_id.zip
	evo_res $path_save/rpe_R/$n_sequence/orb$n_id.zip --save_table $path_save/rpe_R/$n_sequence/orb$n_id.csv 
	rm -rf $path_save/rpe_R/$n_sequence/orb$n_id.zip
	
	evo_rpe kitti $n_sequence.txt $path_MC_SLAM/$n_sequence/$n_id.txt -r angle_deg --delta 100 --delta_unit m -a -s --save_results $path_save/rpe_R/$n_sequence/orb_as$n_id.zip
	evo_res $path_save/rpe_R/$n_sequence/orb_as$n_id.zip --save_table $path_save/rpe_R/$n_sequence/orb_as$n_id.csv 
	rm -rf $path_save/rpe_R/$n_sequence/orb_as$n_id.zip	
	
	#without
	: '
	evo_ape kitti $n_sequence.txt $path_MC_SLAM/$n_sequence/${n_id}_without.txt  --save_results $path_save/ape/$n_sequence/orb${n_id}_without.zip
        evo_res $path_save/ape/$n_sequence/orb${n_id}_without.zip --save_table $path_save/ape/$n_sequence/orb${n_id}_without.csv 
	rm -rf $path_save/ape/$n_sequence/orb${n_id}_without.zip
	
	evo_ape kitti $n_sequence.txt $path_MC_SLAM/$n_sequence/${n_id}_without.txt -a -s --save_results $path_save/ape/$n_sequence/orb_as${n_id}_without.zip
        evo_res $path_save/ape/$n_sequence/orb_as${n_id}_without.zip --save_table $path_save/ape/$n_sequence/orb_as${n_id}_without.csv 
	rm -rf $path_save/ape/$n_sequence/orb_as${n_id}_without.zip
	
	evo_rpe kitti $n_sequence.txt $path_MC_SLAM/$n_sequence/${n_id}_without.txt --delta 100 --delta_unit m --save_results $path_save/rpe_t/$n_sequence/orb${n_id}_without.zip
	evo_res $path_save/rpe_t/$n_sequence/orb${n_id}_without.zip --save_table $path_save/rpe_t/$n_sequence/orb${n_id}_without.csv 
	rm -rf $path_save/rpe_t/$n_sequence/orb${n_id}_without.zip
	
	evo_rpe kitti $n_sequence.txt $path_MC_SLAM/$n_sequence/${n_id}_without.txt --delta 100 --delta_unit m -a -s --save_results $path_save/rpe_t/$n_sequence/orb_as${n_id}_without.zip
	evo_res $path_save/rpe_t/$n_sequence/orb_as${n_id}_without.zip --save_table $path_save/rpe_t/$n_sequence/orb_as${n_id}_without.csv 
	rm -rf $path_save/rpe_t/$n_sequence/orb_as${n_id}_without.zip

	evo_rpe kitti $n_sequence.txt $path_MC_SLAM/$n_sequence/${n_id}_without.txt -r angle_deg --delta 100 --delta_unit m --save_results $path_save/rpe_R/$n_sequence/orb${n_id}_without.zip
	evo_res $path_save/rpe_R/$n_sequence/orb${n_id}_without.zip --save_table $path_save/rpe_R/$n_sequence/orb${n_id}_without.csv 
	rm -rf $path_save/rpe_R/$n_sequence/orb${n_id}_without.zip
	
	evo_rpe kitti $n_sequence.txt $path_MC_SLAM/$n_sequence/${n_id}_without.txt -r angle_deg --delta 100 --delta_unit m -a -s --save_results $path_save/rpe_R/$n_sequence/orb_as${n_id}_without.zip
	evo_res $path_save/rpe_R/$n_sequence/orb_as${n_id}_without.zip --save_table $path_save/rpe_R/$n_sequence/orb_as${n_id}_without.csv 
	rm -rf $path_save/rpe_R/$n_sequence/orb_as${n_id}_without.zip	
	'	
	
    done
done
