//
//  PopupViewController.swift
//  HelpSpeak
//
//  Created by Vasanth Rajasekaran on 5/26/18.
//  Copyright © 2018 Vasanth. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {
    @IBOutlet var StopRecordingandClose: UIView!
    @IBOutlet weak var ExitButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        // Do any additional setup after loading the view.
        
        ViewController().startRecording()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func ExitButton(_ sender: Any) {
        self.view.removeFromSuperview()
        ViewController().stopRecording()
    }
    
    @IBAction func StopRecordandClose(_ sender: Any) {
        ViewController().stopRecording()
        ViewController().playRecording()
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
