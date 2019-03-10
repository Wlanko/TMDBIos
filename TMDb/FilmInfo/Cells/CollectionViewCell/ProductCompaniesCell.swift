//
//  ProductCompaniesCell.swift
//  TMDb
//
//  Created by Vlad on 04.03.2019.
//  Copyright © 2019 Vlad. All rights reserved.
//

import UIKit
import Kingfisher

class ProductCompaniesCell: UICollectionViewCell {
    
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var companyImage: UIImageView!
    
    func setData(filmEditor: ProductCompanies?){
        companyName.text = filmEditor?.name
        companyImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(filmEditor?.logo_path ?? "")"), placeholder: UIImage(named: "prodCompanyPlaceholder"))
        
    }
}
