//
//  FilmCell.swift
//  TMDb
//
//  Created by Vlad on 16.02.2019.
//  Copyright © 2019 Vlad. All rights reserved.
//

import UIKit
import Kingfisher

class FilmCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var id: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(film: Films?){
        title.text = film?.title
        desc.text = film?.overview
        date.text = film?.release_date
        imgView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500" + ((film?.poster_path)!)))
    }
}
