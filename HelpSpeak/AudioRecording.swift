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
        print("GETTING FILE")
        return paths[0]
    }
    
    // recording
    func startRecording (){
        let session = AVAudioSession.sharedInstance() //Creates the session
        isRecording = true
        let audioUrl = getAudioFileUrl().appendingPathComponent("recording.m4a")
        print(audioUrl)
        do {
            
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:.defaultToSpeaker)
            try session.setActive(true)
            
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 36000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
                ] as [String : Any]
            
            // Create the audio recording and assign ourselves as the delgate
            
            soundRecorder = try AVAudioRecorder (url: audioUrl, settings: settings)
            soundRecorder.delegate = self
            soundRecorder.record()
            print("RECORDING")

        }
        catch let error{
            print("tap a button")
        }
        
    }
    
    func stopRecording(){
        soundRecorder.stop()
        isRecording = false
        print("RECORDING STOPPED")
    }
    
    
    
    //for playing the recording
    func playRecording(){
        let url = getAudioFileUrl()
        do {
            // Setting up with the saved fire URL

            let sound = try AVAudioPlayer(contentsOf: url)
            self.soundPlayer = sound
            
            
            // setting up delegate
            sound.delegate = self
            sound.prepareToPlay()
            sound.play()
            print("PLAYING RECORDING")

            
        }catch {
            print("error loading file")
        }
    }
    
    
    



}
