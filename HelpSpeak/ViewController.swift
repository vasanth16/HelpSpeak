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
    var soundRecorder = AVAudioRecorder()
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
        AVAudioSession.sharedInstance().requestRecordPermission () {
            [unowned self] allowed in
            if allowed {
                // Microphone allowed, do what you like!
                self.startRecording()
                
            } else {
                // User denied microphone. Tell them off!
                
            }
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
    
    @IBAction func StopRecordingButton(_ sender: Any) {
        self.stopRecording()
        self.playRecording()
    }
    
    
    
    @IBAction func Allbutton(_ sender: Any) {
        getAccessST()
        getToken()
        var params = [
            "Authorization": "Bearer <Token>",
            "Content-Type": "application/json",
            "Services":[
                "services.police":"true",
                "services.fire": "true",
                "services.medical": "true"],
            "location.coordinates": [
                "lat": lati?.coordinate.latitude,
                "lng": lati?.coordinate.longitude,
                "accuracy": lati?.horizontalAccuracy] as [String: Any]
            ] as [String:Any]
        
        Alamofire.request("https://api.safetrek.io/v1/alarms", method: .post, parameters: params).responseString { response in
            print("Request for Police: \(response.request)\n")
            print ("Response for Police: \(response.response)\n")
            print("Error for Police: \(response.error)\n")
            
            print (response.result.isSuccess)
            if let json = response.result.value{
                print ("Json: \(json)")
            }
            
        }
        
        //Gets the Pop Up for recording evidence
        let popupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"EVPopUP") as! PopupViewController
        self.addChildViewController(popupVC)
        popupVC.view.frame = self.view.frame
        self.view.addSubview(popupVC.view)
        popupVC.didMove(toParentViewController: self)
}
   
    @IBAction func PoliceButton(_ sender: Any) {

        getAccessST()
        getToken()
        var params = [
            "Authorization": "Bearer <Token>",
            "Content-Type": "application/json",
            "Services":[
                "services.police":"true",
                "services.fire": "false",
                "services.medical": "false"],
            "location.coordinates": [
                "lat": lati?.coordinate.latitude,
                "lng": lati?.coordinate.longitude,
                "accuracy": lati?.horizontalAccuracy] as [String: Any]
            ] as [String:Any]
        
        Alamofire.request("https://api.safetrek.io/v1/alarms", method: .post, parameters: params).responseString { response in
            print("Request for Police: \(response.request)\n")
            print ("Response for Police: \(response.response)\n")
            print("Error for Police: \(response.error)\n")
            
            print (response.result.isSuccess)
            if let json = response.result.value{
                print ("Json: \(json)")
            }
            
        }
        let popupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"EVPopUP") as! PopupViewController
        self.addChildViewController(popupVC)
        popupVC.view.frame = self.view.frame
        self.view.addSubview(popupVC.view)
        popupVC.didMove(toParentViewController: self)
    
        }
    
    @IBAction func EMSButton(_ sender: Any) {
        getAccessST()
        getToken()
        var params = [
            "Authorization": "Bearer <Token>",
            "Content-Type": "application/json",
            "Services":[
                "services.police":"false",
                "services.fire": "false",
                "services.medical": "true"],
            "location.coordinates": [
                "lat": lati?.coordinate.latitude,
                "lng": lati?.coordinate.longitude,
                "accuracy": lati?.horizontalAccuracy] as [String: Any]
            ] as [String:Any]
        
        Alamofire.request("https://api.safetrek.io/v1/alarms", method: .post, parameters: params).responseString { response in
            print("Request for Police: \(response.request)\n")
            print ("Response for Police: \(response.response)\n")
            print("Error for Police: \(response.error)\n")
            
            print (response.result.isSuccess)
            if let json = response.result.value{
                print ("Json: \(json)")
            }
            
        }
        let popupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"EVPopUP") as! PopupViewController
        self.addChildViewController(popupVC)
        popupVC.view.frame = self.view.frame
        self.view.addSubview(popupVC.view)
        popupVC.didMove(toParentViewController: self)
    }
    
    @IBAction func FireButton(_ sender: Any) {
        getAccessST()
        getToken()
        var params = [
            "Authorization": "Bearer <Token>",
            "Content-Type": "application/json",
            "Services":[
                "services.police":"false",
                "services.fire": "true",
                "services.medical": "false"],
            "location.coordinates": [
                "lat": lati?.coordinate.latitude,
                "lng": lati?.coordinate.longitude,
                "accuracy": lati?.horizontalAccuracy] as [String: Any]
            ] as [String:Any]
        
        Alamofire.request("https://api.safetrek.io/v1/alarms", method: .post, parameters: params).responseString { response in
            print("Request for Police: \(response.request)\n")
            print ("Response for Police: \(response.response)\n")
            print("Error for Police: \(response.error)\n")
            
            print (response.result.isSuccess)
            if let json = response.result.value{
                print ("Json: \(json)")
            }
            
        }
        let popupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"EVPopUP") as! PopupViewController
        self.addChildViewController(popupVC)
        popupVC.view.frame = self.view.frame
        self.view.addSubview(popupVC.view)
        popupVC.didMove(toParentViewController: self)
    }
    
    }


