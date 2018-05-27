//
//  STRequests.swift
//  HelpSpeak
//
//  Created by Vasanth Rajasekaran on 5/27/18.
//  Copyright © 2018 Vasanth. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import CoreLocation
import JavaScriptCore
import WebKit
import SafariServices
import AVFoundation

extension ViewController{
    
    // Contains all the request data thats being sent to the Safetrek API
    func allbutton(){
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
    func policeButton(){
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
    func emsButton(){
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
    func fireButton(){
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
