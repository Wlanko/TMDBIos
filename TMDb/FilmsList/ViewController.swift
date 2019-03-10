//
//  ViewController.swift
//  TMDb
//
//  Created by Vlad on 07.02.2019.
//  Copyright © 2019 Vlad. All rights reserved.
//

import UIKit

class FilmViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tabelview: UITableView!
    let apiManager = NetworkManager()
    
    var filmsList: FilmsList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFilms()
    }
        
    func getFilms(){
        apiManager.getMovies(callback: {(movies) in
            self.filmsList = movies
            DispatchQueue.main.async {
                self.tabelview.reloadData()
            }
        })
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filmCell", for: indexPath) as! FilmCell
        
        cell.setData(film: self.filmsList?.results[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filmsList?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FilmInfoViewController") as! FilmInfoViewController
        let n : Int = indexPath.row
        let id = String(describing: filmsList?.results[n]!.id ?? 0)
        print(indexPath.row)
        vc.filmId = id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
