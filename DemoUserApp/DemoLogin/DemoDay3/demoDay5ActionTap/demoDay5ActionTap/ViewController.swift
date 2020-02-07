//
//  ViewController.swift
//  demoDay5ActionTap
//
//  Created by Tuan Cuong on 1/15/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // UITapGestureRecognizer
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func nextViewActionClick(_ sender: UIButton) {
        let view2 = storyboard?.instantiateViewController(withIdentifier: "PinchVC") as! PinchViewController
        
        navigationController?.pushViewController(view2, animated: true)
    }
    
    @IBAction func tapActionView(_ sender: UITapGestureRecognizer) {
        print(sender.location(in: view))
        let img:UIImageView = UIImageView()
        img.image = UIImage(named: "Ahihi")
        img.frame.size = CGSize(width: 100, height: 100)
        img.center = sender.location(in: view)
        view.addSubview(img)
    }
}

