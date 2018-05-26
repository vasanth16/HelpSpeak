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
    
    //The Button outlets
    @IBOutlet weak var PoliceButton: UIButton!
    @IBOutlet weak var StopRecordingButton: UIButton!
    @IBOutlet weak var EMSButton: UIButton!
    @IBOutlet weak var FireButton: UIButton!
    
    
    
    //Trying out stuff
    var locationmanager: CLLocationManager!
    var webView: WKWebView!
    var jsContext: JSContext!
    
    //Recording setup
    var soundRecorder = AVAudioRecorder()
    var soundPlayer = AVAudioPlayer()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationmanager = CLLocationManager()
        locationmanager.delegate = self
        locationmanager.requestWhenInUseAuthorization()
        
       var isRecording = true
        
        
        AVAudioSession.sharedInstance().requestRecordPermission () {
            [unowned self] allowed in
            if allowed {
                // Microphone allowed, do what you like!
                self.setupRecorder()
            } else {
                // User denied microphone. Tell them off!
                
            }
        }
        /*let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        webView = WKWebView(frame: view.bounds, configuration: configuration)
        view.addSubview(webView)*/

    }
    
    
    
    func LocationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus, didUpdateLocations locations: [CLLocation]){
        if status != .authorizedWhenInUse{return}
        locationmanager.desiredAccuracy = kCLLocationAccuracyBest
        locationmanager.startUpdatingLocation()
        let locvalue: CLLocationCoordinate2D = manager.location!.coordinate
        print("Lat: \(locvalue.latitude)")
        print("Long: \(locvalue.longitude)")
    }
    
    var lati : CLLocation?

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func StopRecordingButton(_ sender: Any) {
        
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
    }
    
    }


