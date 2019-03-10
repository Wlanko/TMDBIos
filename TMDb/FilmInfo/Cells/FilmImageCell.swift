//
//  FImageCell.swift
//  TMDb
//
//  Created by Vlad on 02.03.2019.
//  Copyright © 2019 Vlad. All rights reserved.
//

import UIKit

class FilmImageCell: UITableViewCell {
    
    @IBOutlet var iView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(filmImage: String){
        iView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(filmImage)"), placeholder: UIImage(named: "backgroundPlaceholder"))
    }
}
