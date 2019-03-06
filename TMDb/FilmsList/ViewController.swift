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
    
    var filmsList: FilmsList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchFilms()
    }
    
    func  fetchFilms() {
        let urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=64e28959ab896eae16e8746c65fa2a18&page=1")!)
        
        let task = URLSession.shared.dataTask(with: urlRequest){ (data, response, error) in
            
            if error != nil{
                print(error)
                return
            }
            
            do{
                self.filmsList = try JSONDecoder().decode(FilmsList.self, from: data!)
                
                DispatchQueue.main.async{
                    self.tabelview.reloadData()
                }
                
            }catch let error {
                print(error)
            }
            
        }
        
        task.resume()
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
        let stB = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard?.instantiateViewController(withIdentifier: "FilmInfoViewController") as! FilmInfoViewController
        let n : Int = indexPath.row
        let id = String(describing: filmsList?.results[n]!.id ?? 0)
        print(indexPath.row)
        vc.filmId = id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
