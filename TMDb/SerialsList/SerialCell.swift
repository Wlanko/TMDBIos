//
//  SerialCell.swift
//  TMDb
//
//  Created by Vlad on 24.02.2019.
//  Copyright © 2019 Vlad. All rights reserved.
//

import UIKit

class SerialCell: UITableViewCell {

    @IBOutlet weak var SImgView: UIImageView!
    @IBOutlet weak var STitle: UILabel!
    @IBOutlet weak var SDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDataSerial(serial: Films?){
        STitle.text = serial?.name
        SDesc.text = serial?.overview
        SImgView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500" + ((serial?.poster_path)!)))
    }

}
