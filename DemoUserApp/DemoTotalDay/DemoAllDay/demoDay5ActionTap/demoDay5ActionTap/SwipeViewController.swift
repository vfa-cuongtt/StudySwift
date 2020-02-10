//
//  SwipeViewController.swift
//  demoDay5ActionTap
//
//  Created by Tuan Cuong on 1/20/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit

class SwipeViewController: UIViewController {

    @IBOutlet weak var imgFan: UIImageView!
    var root:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    @IBAction func swipeActionClick(_ sender: Any) {
        print("swiper")
        root += 45
        UIView.animate(withDuration: 0.1) {
            self.imgFan.layer.transform = CATransform3DMakeRotation( (CGFloat(M_PI) * self.root / 180), 0, 0, 1)
            self.imgFan.layer.backgroundColor = UIColor.red.cgColor
        }
        
    }
    
}
