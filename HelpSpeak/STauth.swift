//
//  STauth.swift
//  HelpSpeak
//
//  Created by Vasanth Rajasekaran on 5/21/18.
//  Copyright © 2018 Vasanth. All rights reserved.
//

import Foundation
import Alamofire
import OAuthSwift
import UIKit
import SafariServices
import WebKit
import JavaScriptCore

extension ViewController {
public
    func getAccessST(){
    let preferences = WKPreferences()
    preferences.javaScriptEnabled = true
    
    let params = [
        "client_id":"gk1nFtbQr4pBpJD0rzAp3vaSi555sm4s",
        "scope":"openid phone offline_access&",
        "state":"statecode&",
        "response_type":"code&",
        "redirect_uri":"http://localhost:3000/callback"
    ]
    Alamofire.request ("https://account-sandbox.safetrek.io/authorize?audience=https://api-sandbox.safetrek.io&client_id=gk1nFtbQr4pBpJD0rzAp3vaSi555sm4s&scope=openid%20phone%20offline_access&state=statecode&response_type=code&redirect_uri=http://localhost:3000/callback", method: .get).responseString{ response in
        print("Request for Auth: \(response.request)\n")
        print ("Response for Auth: \(response.response)\n")
        print("Error for Auth: \(response.error)\n")
        
        print (response.result.value)
    }
    
    }

     func getToken() {
        let params = [
            "grant_type": "authorization_code",
            "code": "3000/callback",
            "client_id": "gk1nFtbQr4pBpJD0rzAp3vaSi555sm4s",
            "client_secret": "eWTSj_izMvD3nBJFXxkRDZF4aXDGKofYRZyzw_31oer31kuoY6-OVDs27nEHJu0B",
            "redirect_uri": "http://localhost:3000/callback"
        ]
        Alamofire.request("https://login-sandbox.safetrek.io/oauth/token", method: .post, parameters: params).responseJSON{ response in
            print("Request for Token: \(response.request)\n")
            print ("Response for Token: \(response.response)\n")
            print("Error for Token: \(response.error)\n")
            
            print (response.result.isSuccess)
            if let json = response.result.value{
                print ("Json: \(json)")
        }
        
    }

}

}
