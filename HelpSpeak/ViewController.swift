//
//  ViewController.swift
//  HelpSpeak
//
//  Created by Vasanth Rajasekaran on 5/18/18.
//  Copyright © 2018 Vasanth. All rights reserved.
//

import UIKit
import OAuthSwift
import Alamofire
import CoreLocation
import JavaScriptCore
import WebKit
import SafariServices
import AVFoundation

class ViewController: UIViewController, CLLocationManagerDelegate, SFSafariViewControllerDelegate, AVAudioRecorderDelegate, AVAudioPlayerDelegate  {
    
    //Recording Button
    @IBOutlet weak var StopRecordingButton: UIButton!
    
    //Button Outlets
    @IBOutlet weak var PoliceButton: UIButton!
    @IBOutlet weak var EMSButton: UIButton!
    @IBOutlet weak var FireButton: UIButton!
    
    
    
    //Trying out stuff
    var locationmanager: CLLocationManager!
    var webView: WKWebView!
    var jsContext: JSContext!
    var lati : CLLocation? // Location Object used for the buttons

    //Recording setup
    var recordingSession = AVAudioSession()
    var soundRecorder : AVAudioRecorder!
    var soundPlayer = AVAudioPlayer()
    var isRecording = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Location Manager set up
        locationmanager = CLLocationManager()
        locationmanager.delegate = self
        locationmanager.requestWhenInUseAuthorization()
        
        
        
        // Asking user permission for accessing Microphone
        recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.startRecording()
                    } else {
                        print("Dont Allow")
                    }
                }
            }
        } catch {
            print("failed to record!")
        }


    }
    
    
    
    
    func LocationManager(_ manager: CLLocationManager, didChangeAuthorization status:
        CLAuthorizationStatus, didUpdateLocations locations: [CLLocation]){
        
        // Check if Location services are authorized
        if status != .authorizedWhenInUse{return}
        
        //Starts location collection
        locationmanager.desiredAccuracy = kCLLocationAccuracyBest
        locationmanager.startUpdatingLocation()
        let locvalue: CLLocationCoordinate2D = manager.location!.coordinate
        
        //prints out the data
        print("Lat: \(locvalue.latitude)")
        print("Long: \(locvalue.longitude)")
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func TestRecording(_ sender: Any) {
        stopRecording()
        isRecording = false
        playRecording()
        
    }
    
    @IBAction func StopRecordingButton(_ sender: Any) {
        self.stopRecording()
        self.playRecording()
    }
    
    func popUpSummon(){
        let popupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"EVPopUP") as! PopupViewController
        self.addChildViewController(popupVC)
        popupVC.view.frame = self.view.frame
        self.view.addSubview(popupVC.view)
        popupVC.didMove(toParentViewController: self)
    }
    
    @IBAction func Allbutton(_ sender: Any) {
        allbutton()
        popUpSummon()
        
       
    }
   
    @IBAction func PoliceButton(_ sender: Any) {
        policeButton()
        popUpSummon()
        }
    
    @IBAction func EMSButton(_ sender: Any) {
        emsButton()
        popUpSummon()
    }
    
    @IBAction func FireButton(_ sender: Any) {
        fireButton()
        popUpSummon()
    }
    
}



