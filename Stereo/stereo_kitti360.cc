/**
* This file is part of ORB-SLAM2.
*
* Copyright (C) 2014-2016 Raúl Mur-Artal <raulmur at unizar dot es> (University of Zaragoza)
* For more information see <https://github.com/raulmur/ORB_SLAM2>
*
* ORB-SLAM2 is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* ORB-SLAM2 is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with ORB-SLAM2. If not, see <http://www.gnu.org/licenses/>.
*/


#include<iostream>
#include<algorithm>
#include<fstream>
#include<iomanip>
#include<chrono>

#include<opencv2/core/core.hpp>
#include<System.h>

using namespace std;

void LoadImages(const string &strPathToSequence, vector<string> &vstrImageLeft,
                vector<string> &vstrImageRight, vector<double> &vTimestamps);

int main(int argc, char **argv)
{
    /*
    if(argc != 5)
    {
        cerr << endl << "Usage: ./stereo_kitti path_to_vocabulary path_to_settings path_to_sequence path_to_save" << endl;
        return 1;
    }


    // Retrieve paths to images
    vector<string> vstrImageLeft;
    vector<string> vstrImageRight;
    vector<double> vTimestamps;
    LoadImages(string(argv[3]), vstrImageLeft, vstrImageRight, vTimestamps);

    const int nImages = vstrImageLeft.size();

    // Create SLAM system. It initializes all system threads and gets ready to process frames.
    ORB_SLAM2::System SLAM(argv[1],argv[2],ORB_SLAM2::System::STEREO,true);
    */


    string s1("/home/whd/SLAM/ORB_SLAM2/Vocabulary/ORBvoc.txt");
    string s2("/home/whd/SLAM/ORB_SLAM2/result/KITTI360.yaml");
    //string s2("/home/whd/SLAM/ORB_SLAM2/result/KITTI00-02.yaml");


    /*
    string s3("/mnt/nas/dataset/理想ONE_公司_曹安公路_学校_0422/2023-04-22-07-39-36");
    string s4("/home/whd/SLAM/ORB_SLAM2/result/2023-04-22-07-39-36.txt");
     */

    //string s3("/mnt/nas/dataset/理想ONE_学校_0426/2023-04-22-08-21-27");
    //string s4("/home/whd/SLAM/ORB_SLAM2/result/2023-04-22-08-21-27.txt");

    //string s3("/mnt/nas/kitti360/0002");
    //string s4("/home/whd/SLAM/ORB_SLAM2/result/360_02.txt");

    int sequence_id = stoi(argv[1]);
    stringstream sequence_id_ss;
    sequence_id_ss << setw(4) << setfill('0') << sequence_id;
    string sequence_id_str;
    sequence_id_ss >> sequence_id_str;

    int save_id = stoi(argv[2]);
    stringstream save_id_ss;
    save_id_ss << setw(3) << setfill('0') << save_id;
    string save_id_str;
    save_id_ss >> save_id_str;

    string path_to_sequence = "/mnt/nas/kitti360/";
    path_to_sequence = path_to_sequence + sequence_id_str;
    string path_to_save = "/home/whd/SLAM/ORB_SLAM2/result/";
    path_to_save = path_to_save + sequence_id_str + "/" + save_id_str + ".txt";

    string s3 = path_to_sequence;
    string s4 = path_to_save;

    // Retrieve paths to images
    vector<string> vstrImageLeft;
    vector<string> vstrImageRight;
    vector<double> vTimestamps;
    LoadImages(s3, vstrImageLeft, vstrImageRight, vTimestamps);

    const int nImages = vstrImageLeft.size();

    // Create SLAM system. It initializes all system threads and gets ready to process frames.
    ORB_SLAM2::System SLAM(s1,s2,ORB_SLAM2::System::STEREO,true);

    // Vector for tracking time statistics
    vector<float> vTimesTrack;
    vTimesTrack.resize(nImages);

    cout << endl << "-------" << endl;
    cout << "Start processing sequence ..." << endl;
    cout << "Images in the sequence: " << nImages << endl << endl;   

    // Main loop
    cv::Mat imLeft, imRight;
    for(int ni=0; ni<nImages; ni++)
    //for(int ni=0; ni<1000; ni++)
    {
        // Read left and right images from file
        imLeft = cv::imread(vstrImageLeft[ni],CV_LOAD_IMAGE_UNCHANGED);
        imRight = cv::imread(vstrImageRight[ni],CV_LOAD_IMAGE_UNCHANGED);
        double tframe = vTimestamps[ni];

        if(imLeft.empty())
        {
            cerr << endl << "Failed to load image at: "
                 << string(vstrImageLeft[ni]) << endl;
            return 1;
        }

//#ifdef COMPILEDWITHC11
        std::chrono::steady_clock::time_point t1 = std::chrono::steady_clock::now();
//#else
//        std::chrono::monotonic_clock::time_point t1 = std::chrono::monotonic_clock::now();
//#endif

        // Pass the images to the SLAM system
        SLAM.TrackStereo(imLeft,imRight,tframe);
        //cout << ni << endl;
//#ifdef COMPILEDWITHC11
        std::chrono::steady_clock::time_point t2 = std::chrono::steady_clock::now();
//#else
//        std::chrono::monotonic_clock::time_point t2 = std::chrono::monotonic_clock::now();
//#endif

        double ttrack= std::chrono::duration_cast<std::chrono::duration<double> >(t2 - t1).count();

        vTimesTrack[ni]=ttrack;

        // Wait to load the next frame
        double T=0; // 两帧时间间隔
        if(ni<nImages-1)
            T = vTimestamps[ni+1]-tframe;
        else if(ni>0)
            T = tframe-vTimestamps[ni-1];

        if(ttrack<T)
            usleep((T-ttrack)*1e6);

        //if(ni==100)
         //   usleep(1e8);
    }


    vector<float> vTimesLBA;
    vector<float> vTimesGBA;

    vTimesLBA = SLAM.GetTimesLBA();
    vTimesGBA = SLAM.GetTimesGBA();

    double totalTimesLBA=0;
    double totalTimesGBA=0;

    for(int i=0;i<vTimesLBA.size();i++){
        totalTimesLBA += vTimesLBA[i];
    }
    for(int i=0;i<vTimesGBA.size();i++){
        totalTimesGBA += vTimesGBA[i];
    }

    cout << "TimesLBA: " << totalTimesLBA/vTimesLBA.size() << endl;
    cout << "TimesGBA: " << totalTimesGBA/vTimesGBA.size() << endl;

    // Stop all threads
    SLAM.Shutdown();

    // Tracking time statistics
    sort(vTimesTrack.begin(),vTimesTrack.end());
    float totaltime = 0;
    for(int ni=0; ni<nImages; ni++)
    {
        totaltime+=vTimesTrack[ni];
    }
    cout << "-------" << endl << endl;
    cout << "median tracking time: " << vTimesTrack[nImages/2] << endl;
    cout << "mean tracking time: " << totaltime/nImages << endl;
    cout << "fps: " << nImages/totaltime << endl;
    // Save camera trajectory
    //SLAM.SaveTrajectoryKITTI(argv[4]);
    SLAM.SaveTrajectoryKITTI(s4);


    return 0;
}

void LoadImages(const string &strPathToSequence, vector<string> &vstrImageLeft,
                vector<string> &vstrImageRight, vector<double> &vTimestamps)
{
    ifstream fTimes;
    string strPathTimeFile = strPathToSequence + "/times.txt";
    fTimes.open(strPathTimeFile.c_str());
    while(!fTimes.eof())
    {
        string s;
        getline(fTimes,s);
        if(!s.empty())
        {
            stringstream ss;
            ss << s;
            double t;
            ss >> t;
            vTimestamps.push_back(t);
        }
    }

    string strPrefixLeft = strPathToSequence + "/image_2/";
    string strPrefixRight = strPathToSequence + "/image_3/";

    const int nTimes = vTimestamps.size();
    vstrImageLeft.resize(nTimes);
    vstrImageRight.resize(nTimes);

    for(int i=0; i<nTimes; i++)
    {
        stringstream ss;
        ss << setfill('0') << setw(10) << i;
        vstrImageLeft[i] = strPrefixLeft + ss.str() + ".png";
        vstrImageRight[i] = strPrefixRight + ss.str() + ".png";
    }
}
