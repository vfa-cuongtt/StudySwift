//
//  AlbumTableViewCell.swift
//  DemoAlamofire
//
//  Created by Tuan Cuong on 2/24/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit
import Kingfisher

class AlbumTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgThumbnail: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func fillData(_ data: Audio){
        lblTitle.text = data.title
        lblDescription.text = data.description
        
        // load thumbnail
        do {
            let url:URL = URL(string: data.thumbnail!.url!)!
            imgThumbnail.kf.setImage(with: url)
        } catch {
            print("Cant Load Image")
        }
        
    }
    

}
