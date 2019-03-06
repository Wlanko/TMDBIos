//
//  FTitelCell.swift
//  TMDb
//
//  Created by Vlad on 01.03.2019.
//  Copyright © 2019 Vlad. All rights reserved.
//

import UIKit

class FilmTitelCell: UITableViewCell {

    @IBOutlet weak var titel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(filmTitel: String){
        titel.text = filmTitel
    }

}
