//
//  View2Controller.swift
//  demoDay5ActionTap
//
//  Created by Tuan Cuong on 1/16/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit

class PinchViewController: UIViewController {
    var data: [String] = []

    // UIPinchGestureRecognizer
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(data) 
    }
    
    @IBAction func pinchImgAction(_ sender: UIPinchGestureRecognizer) {
        sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
        sender.scale = 1
    }
    

}
