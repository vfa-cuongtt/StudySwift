//
//  ImageViewController.swift
//  demoDay5ActionTap
//
//  Created by Tuan Cuong on 2/4/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var imgAvatar: UIImageView!
    var imgName:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgAvatar.image = UIImage.init(named: imgName)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
