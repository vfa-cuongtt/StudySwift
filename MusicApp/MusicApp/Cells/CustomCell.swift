//
//  CustomCell.swift
//  MusicApp
//
//  Created by Tuan Cuong on 2/18/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblArtist: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var btnPause: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var lblProgress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
