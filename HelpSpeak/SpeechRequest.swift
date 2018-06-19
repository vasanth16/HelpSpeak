//
//  GoogleRequests.swift
//  HelpSpeak
//
//  Created by Vasanth Rajasekaran on 5/28/18.
//  Copyright © 2018 Vasanth. All rights reserved.
//

import Foundation
import Alamofire
import Speech


extension ViewController{
    
    func SpeechAuth() {
        SFSpeechRecognizer.requestAuthorization{ authStatus in
            
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized{
                if let path = Bundle.main.url(forResource: "test", withExtension: "m4a") {
                do {
                    let sound = try AVAudioPlayer(contentsOf: path)
                    self.soundPlayer = sound
                    sound.play()
                } catch{
                    print("There has been an error")
                }
                
                let recognizer = SFSpeechRecognizer()
                let request  = SFSpeechURLRecognitionRequest(url: path)
                recognizer?.recognitionTask(with: request){ (result, error) in
                    if let error = error{
                        print ("There was an error: \(error)")
                    }else {
                        print(result?.bestTranscription.formattedString)
                    }
                        
                    }
            }
        }
    }
}
}
