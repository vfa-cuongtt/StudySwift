//
//  CollectionImageViewCell.swift
//  demoDay5ActionTap
//
//  Created by Tuan Cuong on 2/10/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit

class CollectionImageViewCell: UIViewController {

    @IBOutlet weak var ImgAvatar: UIImageView!
    var imgName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        ImgAvatar.image = UIImage(named: imgName)
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
