//
//  SerialViewController.swift
//  TMDb
//
//  Created by Vlad on 24.02.2019.
//  Copyright © 2019 Vlad. All rights reserved.
//

import UIKit

class SerialViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var sTView: UITableView!
    var serials : FilmsList?

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchSerials()
    }

    func  fetchSerials() {
        let urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/tv/popular?api_key=64e28959ab896eae16e8746c65fa2a18&page=1")!)
        
        let task = URLSession.shared.dataTask(with: urlRequest){ (data, response, error) in
            
            if error != nil{
                print(error)
                return
            }
            
            
            do{
                self.serials = try JSONDecoder().decode(FilmsList.self, from: data!)
                
                DispatchQueue.main.async{
                    self.sTView.reloadData()
                }
                
            }catch let error {
                print(error)
            }
            
        }
        
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "serialCell", for: indexPath) as! SerialCell
        
        cell.setDataSerial(serial: self.serials?.results[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.serials?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stB = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard?.instantiateViewController(withIdentifier: "FilmInfoViewController") as! FilmInfoViewController
        let n : Int = indexPath.row
        let id = String(describing: serials?.results[n]!.id ?? 0)
        print(indexPath.row)
        vc.filmId = id
        vc.serialOrFilm = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
