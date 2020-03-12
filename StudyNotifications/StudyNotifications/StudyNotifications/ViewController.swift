//
//  ViewController.swift
//  StudyNotifications
//
//  Created by Tuan Cuong on 3/12/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit
import UserNotifications
class ViewController: UIViewController {
//    var uuidString = UUID().uuidString
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // step 1: ask user for permission
        let center = UNUserNotificationCenter.current()
        // Step 2: create the notification content
        let content = UNMutableNotificationContent()
        content.title = "Hello 123"
        content.body = "Ahihi"
        content.sound = UNNotificationSound.default
        
        
//        // step 3: Create the trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//
//        // step 4: Create the request
       
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        print("UUID: \(appDelegate.uuidString)")
        let request =  UNNotificationRequest(identifier: appDelegate.uuidString, content: content, trigger: trigger)
//
//        
//        // step 5: register with notification center
//        print("request: \(request)")
        center.add(request) { (error) in
            // check the error parrameter and handle any errors
            print("error: \(error)")
            
        }
        
        
    }


}

