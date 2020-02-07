//
//  RotationViewController.swift
//  demoDay5ActionTap
//
//  Created by Tuan Cuong on 1/20/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit

class RotationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    
    @IBAction func rotationImgActionClick(_ sender: UIRotationGestureRecognizer) {
        print("dang xoay")
        print(sender.rotation)
        
        sender.view?.transform = ( (sender.view?.transform.rotated(by: sender.rotation))!)
        sender.rotation = 0
    }
    
}
