//
//  FilmEditorStudiosCell.swift
//  TMDb
//
//  Created by Vlad on 03.03.2019.
//  Copyright © 2019 Vlad. All rights reserved.
//

import UIKit

class FilmEditorStudiosCell: UITableViewCell , UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var productCompanies: UILabel!
    
    var editorComapanies: [ProductCompanies?] = []
    
    @IBOutlet weak var listOfCompanies: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        listOfCompanies.delegate = self
        listOfCompanies.dataSource = self
        
        // Initialization code
    }
    
    
    func setListOfCompanies(filmEditor: [ProductCompanies?]){
        productCompanies.text = "Production Companies"
        do{
            editorComapanies = filmEditor
            
            DispatchQueue.main.async{
                self.listOfCompanies.reloadData()
            }
            
        }catch let error {
            print(error)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return editorComapanies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCompany", for: indexPath) as! ProductCompaniesCell
        cell.setData(filmEditor: editorComapanies[indexPath.row])
        return cell
    }
}
