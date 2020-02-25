//
//  AlbumTableViewCell.swift
//  DemoAlamofire
//
//  Created by Tuan Cuong on 2/24/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit

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

    func fillData(_ data: Album){
        lblTitle.text = data.title
        lblDescription.text = data.description
        
        // load thumbnail
        do {
            let url:URL =  URL(string: data.thumbnail)!
            print("CuongTT_URL: \(url)")
            let imgUrl:Data = try Data(contentsOf: url)
            imgThumbnail.image = UIImage(data: imgUrl)
        } catch {
            print("Cant Load Image")
        }
        
    }
    

}
