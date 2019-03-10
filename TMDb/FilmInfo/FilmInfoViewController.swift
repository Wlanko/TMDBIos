//
//  FilmInfoViewController.swift
//  TMDb
//
//  Created by Vlad on 25.02.2019.
//  Copyright © 2019 Vlad. All rights reserved.
//

import UIKit

class FilmInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var loadingLbl: UILabel!
    
    @IBOutlet weak var fITV: UITableView!
    
    var filmId: String?
    var serialId: String?
    var filmOrSerial: filmInfo?
    let apiManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fITV.isHidden = true
        
        if filmId != nil{
            getFilm()
        }
        else{
            getSerial()
        }
    }
    
    
    func getFilm(){
        guard let filmId = filmId else {return}
        apiManager.getMovie(filmId: filmId, callback: {(movieInfo) in
            
            self.filmOrSerial = movieInfo
            DispatchQueue.main.async {
                self.fITV.reloadData()
                self.fITV.isHidden = false
                self.loadingLbl.isHidden = true
            }
        })
        
    }
    
    func getSerial(){
        guard let serialId = serialId else {return}
        apiManager.getSerial(serialId: serialId, callback: {(serialInfo) in
            
            self.filmOrSerial = serialInfo
            DispatchQueue.main.async {
                self.fITV.reloadData()
                self.fITV.isHidden = false
                self.loadingLbl.isHidden = true
            }
        })
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Vote", for: indexPath) as! FilmVoteCell
        
        cell.setData(filmVote: self.filmOrSerial?.vote_average ?? 0)
        
        switch indexPath.row {
        case 0:
            let imageCell = tableView.dequeueReusableCell(withIdentifier: "Image", for: indexPath) as! FilmImageCell
            imageCell.setData(filmImage: self.filmOrSerial?.backdrop_path ?? "NONE")
            return imageCell
            
        case 1:
            let titleCell = tableView.dequeueReusableCell(withIdentifier: "Title", for: indexPath) as! FilmTitelCell
            if self.filmOrSerial?.title != nil{
                titleCell.setData(filmTitel: self.filmOrSerial?.title ?? "NONE")
            }
            else{
                titleCell.setData(filmTitel: self.filmOrSerial?.name ?? "NONE")
            }
            return titleCell
            
        case 3:
            let descCell = tableView.dequeueReusableCell(withIdentifier: "Desc", for: indexPath) as! FilmDescCell
            descCell.setData(filmDesc: self.filmOrSerial?.overview ?? "NONE")
            return descCell
        case 4:
            let editorsCell = tableView.dequeueReusableCell(withIdentifier: "Editors", for: indexPath) as! FilmEditorStudiosCell
            editorsCell.setListOfCompanies(filmEditor: filmOrSerial?.production_companies ?? [])
            return editorsCell
            
        default:
            return cell
        }
    }
    
}
