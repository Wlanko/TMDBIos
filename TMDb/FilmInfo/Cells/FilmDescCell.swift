//
//  FDescCell.swift
//  TMDb
//
//  Created by Vlad on 02.03.2019.
//  Copyright © 2019 Vlad. All rights reserved.
//

import UIKit

class FilmDescCell: UITableViewCell {
    
    @IBOutlet weak var desc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(filmDesc: String){
        desc.text = filmDesc
    }

}
