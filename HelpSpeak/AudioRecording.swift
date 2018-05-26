//
//  AudioRecording.swift
//  HelpSpeak
//
//  Created by Vasanth Rajasekaran on 5/24/18.
//  Copyright © 2018 Vasanth. All rights reserved.
//

import Foundation
import AVFoundation
import Alamofire


extension ViewController{


    func setupRecorder (){
        var recordSettings = [AVFormatIDKey: kAudioFormatAppleLossless,
                              AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue,
                              AVEncoderBitRateKey: 320000,
                              AVNumberOfChannelsKey: 2,
                              AVSampleRateKey: 44100.0] as [String : Any]
        var error: Error?
        var soundRecorder = AVAudioRecorder
    }
    
    func getCacheDirectory() -> String{
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearcgPathDomainMask.UserDomainMask, true) as! [String]
        
        return paths[0]
    }
    
    func getFileUrl() -> NSURL{
        let path =
        
        
    }




}
