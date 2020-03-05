//
//  DetailViewController.swift
//  DemoAlamofire
//
//  Created by Tuan Cuong on 2/28/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var lbDetail: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var lbDescription: UILabel!
    
    var audio: Audio?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupData()
    }
    
    func setupData() {
        self.lbDetail.text = audio?.title
        
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
