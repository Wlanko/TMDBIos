//
//  FilmInfoViewController.swift
//  TMDb
//
//  Created by Vlad on 25.02.2019.
//  Copyright © 2019 Vlad. All rights reserved.
//

import UIKit

class FilmInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var fITV: UITableView!
    
    var filmId: String?
    var film : filmInfo?
    var serialOrFilm: Bool? = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchFilm()
    }
    
    func  fetchFilm() {
        guard let fId = filmId else {return}
        let urlRequest: URLRequest
        if serialOrFilm != false{
            urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/tv/\(fId)?api_key=64e28959ab896eae16e8746c65fa2a18")!)
        }
        else{
            urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/\(fId)?api_key=64e28959ab896eae16e8746c65fa2a18")!)
        }
        let task = URLSession.shared.dataTask(with: urlRequest){ (data, response, error) in
            
            if error != nil{
                print(error)
                return
            }
            
            do{
                self.film = try JSONDecoder().decode(filmInfo.self, from: data!)
                
                DispatchQueue.main.async{
                    self.fITV.reloadData()
                }
                
            }catch let error {
                print(error)
            }
            
        }
        
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Vote", for: indexPath) as! FilmVoteCell
        
        cell.setData(filmVote: self.film?.vote_average ?? 0)
        
        switch indexPath.row {
        case 0:
            let imageCell = tableView.dequeueReusableCell(withIdentifier: "Image", for: indexPath) as! FilmImageCell
            imageCell.setData(filmImage: self.film?.backdrop_path ?? "NONE")
            return imageCell
            
        case 1:
            let titleCell = tableView.dequeueReusableCell(withIdentifier: "Title", for: indexPath) as! FilmTitelCell
            if self.film?.title != nil{
                titleCell.setData(filmTitel: self.film?.title ?? "NONE")
            }
            else{
                titleCell.setData(filmTitel: self.film?.name ?? "NONE")
            }
            return titleCell
            
        case 3:
            let descCell = tableView.dequeueReusableCell(withIdentifier: "Desc", for: indexPath) as! FilmDescCell
            descCell.setData(filmDesc: self.film?.overview ?? "NONE")
            return descCell
        case 4:
            let editorsCell = tableView.dequeueReusableCell(withIdentifier: "Editors", for: indexPath) as! FilmEditorStudiosCell
            editorsCell.setListOfCompanies(filmEditor: film?.production_companies ?? [])
            return editorsCell
            
        default:
            return cell
        }
    }
    
}
