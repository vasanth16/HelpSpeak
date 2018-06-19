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
    // get audio file location
    func getAudioFileUrl() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docsDirect = paths[0]
        let audioUrl = docsDirect.appendingPathComponent("recording.m4a")
        return audioUrl
    }
    
    // recording
    func startRecording (){
        let session = AVAudioSession.sharedInstance() //Creates the session
        isRecording = true
        do {
            
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:.defaultToSpeaker)
            try session.setActive(true)
            
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 36000,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
                ] as [String : Any]
            
            // Create the audio recording and assign ourselves as the delgate
            
            soundRecorder = try AVAudioRecorder(url: getAudioFileUrl(), settings: settings)
            print(getAudioFileUrl())
            soundRecorder.delegate = self
            soundRecorder.record()
            print("RECORDING")

        }
        catch {
            print("tap a button")
        }
        
    }
    
    func stopRecording(){
        print(isRecording)
        if  isRecording == true{
            soundRecorder.stop()
            isRecording = false
            print("RECORDING STOPPED")
        }else{
            print("We were not recording")
        }
    }
    
    
    
    //for playing the recording
    func playRecording(){
        let url = getAudioFileUrl()
        print (url)
        do {
            // Setting up with the saved fire URL

            var sound = try AVAudioPlayer(contentsOf: url)
            self.soundPlayer = sound
            
            //setting up delegate
            sound.delegate = self
            sound.prepareToPlay()
            sound.play()
            print("PLAYING RECORDING")

            
        }catch {
            print("error loading file")
        }
    }
    
    
    func areWeRolling (){
        if isRecording == false{
            startRecording()
        }else{
        }
    }
    
    @objc func recordTapped() {
        if isRecording == false {
            startRecording()
        } else {
            stopRecording()
        }
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            stopRecording()
        }
    }

}
