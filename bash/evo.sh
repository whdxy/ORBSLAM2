#!/bin/bash

path_SLAM=/home/whd/SLAM/ORB_SLAM2/result/
path_save=/home/whd/SLAM/ORB_SLAM2/result/0007/evo

dpc=_dpc


for sequence in {9..9}
do
    for id in {0..40}
    do
	printf -v n_sequence "%0*d" 4 $sequence
	printf -v n_id "%0*d" 3 $id
        
        path_seq=$path_SLAM/$n_sequence
        
        cd $path_seq  
        
        evo_ape kitti $n_id.txt truth.txt --save_results $path_save/ape/$n_sequence/orb$n_id.zip
        evo_res $path_save/ape/$n_sequence/orb$n_id.zip --save_table $path_save/ape/$n_sequence/orb$n_id.csv 
        rm -rf $path_save/ape/$n_sequence/orb$n_id.zip       
        evo_ape kitti $n_id.txt truth.txt -a -s --save_results $path_save/ape/$n_sequence/orb_as$n_id.zip
        evo_res $path_save/ape/$n_sequence/orb_as$n_id.zip --save_table $path_save/ape/$n_sequence/orb_as$n_id.csv 
        rm -rf $path_save/ape/$n_sequence/orb_as$n_id.zip
       
        evo_rpe kitti $n_id.txt truth.txt --delta 100 --delta_unit m --save_results $path_save/rpe_t/$n_sequence/orb$n_id.zip
        evo_res $path_save/rpe_t/$n_sequence/orb$n_id.zip --save_table $path_save/rpe_t/$n_sequence/orb$n_id.csv 
	rm -rf $path_save/rpe_t/$n_sequence/orb$n_id.zip
	evo_rpe kitti $n_id.txt truth.txt --delta 100 --delta_unit m -a -s --save_results $path_save/rpe_t/$n_sequence/orb_as$n_id.zip
	evo_res $path_save/rpe_t/$n_sequence/orb_as$n_id.zip --save_table $path_save/rpe_t/$n_sequence/orb_as$n_id.csv 
	rm -rf $path_save/rpe_t/$n_sequence/orb_as$n_id.zip

	evo_rpe kitti $n_id.txt truth.txt -r angle_deg --delta 100 --delta_unit m--save_results $path_save/rpe_R/$n_sequence/orb$n_id.zip
	evo_res $path_save/rpe_R/$n_sequence/orb$n_id.zip --save_table $path_save/rpe_R/$n_sequence/orb$n_id.csv 
	rm -rf $path_save/rpe_R/$n_sequence/orb$n_id.zip	
	evo_rpe kitti $n_id.txt truth.txt -r angle_deg --delta 100 --delta_unit m -a -s --save_results $path_save/rpe_R/$n_sequence/orb_as$n_id.zip
	evo_res $path_save/rpe_R/$n_sequence/orb_as$n_id.zip --save_table $path_save/rpe_R/$n_sequence/orb_as$n_id.csv 
	rm -rf $path_save/rpe_R/$n_sequence/orb_as$n_id.zip	
		


        evo_ape kitti $n_id$dpc.txt truth.txt --save_results $path_save/ape/$n_sequence/dpc$n_id.zip
        evo_res $path_save/ape/$n_sequence/dpc$n_id.zip --save_table $path_save/ape/$n_sequence/dpc$n_id.csv 
        rm -rf $path_save/ape/$n_sequence/dpc$n_id.zip     
        evo_ape kitti $n_id$dpc.txt truth.txt -a -s --save_results $path_save/ape/$n_sequence/dpc_as$n_id.zip
        evo_res $path_save/ape/$n_sequence/dpc_as$n_id.zip --save_table $path_save/ape/$n_sequence/dpc_as$n_id.csv 
        rm -rf $path_save/ape/$n_sequence/dpc_as$n_id.zip
        
        evo_rpe kitti $n_id$dpc.txt truth.txt --delta 100 --delta_unit m --save_results $path_save/rpe_t/$n_sequence/dpc$n_id.zip
        evo_res $path_save/rpe_t/$n_sequence/dpc$n_id.zip --save_table $path_save/rpe_t/$n_sequence/dpc$n_id.csv 
	rm -rf $path_save/rpe_t/$n_sequence/dpc$n_id.zip
	evo_rpe kitti $n_id$dpc.txt truth.txt --delta 100 --delta_unit m -a -s --save_results $path_save/rpe_t/$n_sequence/dpc_as$n_id.zip
	evo_res $path_save/rpe_t/$n_sequence/dpc_as$n_id.zip --save_table $path_save/rpe_t/$n_sequence/dpc_as$n_id.csv 
	rm -rf $path_save/rpe_t/$n_sequence/dpc_as$n_id.zip

	evo_rpe kitti $n_id$dpc.txt truth.txt -r angle_deg --delta 100 --delta_unit m --save_results $path_save/rpe_R/$n_sequence/dpc$n_id.zip
	evo_res $path_save/rpe_R/$n_sequence/dpc$n_id.zip --save_table $path_save/rpe_R/$n_sequence/dpc$n_id.csv 
	rm -rf $path_save/rpe_R/$n_sequence/dpc$n_id.zip	
	evo_rpe kitti $n_id$dpc.txt truth.txt -r angle_deg --delta 100 --delta_unit m -a -s --save_results $path_save/rpe_R/$n_sequence/dpc_as$n_id.zip
	evo_res $path_save/rpe_R/$n_sequence/dpc_as$n_id.zip --save_table $path_save/rpe_R/$n_sequence/dpc_as$n_id.csv 
	rm -rf $path_save/rpe_R/$n_sequence/dpc_as$n_id.zip		
	
    done
done
