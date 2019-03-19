//
//  ViewController.swift
//  TMDb
//
//  Created by Vlad on 07.02.2019.
//  Copyright © 2019 Vlad. All rights reserved.
//

import UIKit
import Kingfisher

class FilmViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    let apiManager = NetworkManager()
    var list: [Films] = []
    var page = 0
    var tableViewList:[IndexPath] = []
    
    var filmsList: FilmsList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.estimatedRowHeight = 108
//        ImageCache.default.memoryStorage.config.totalCostLimit = 100 * 1024 * 1024
        
        getPage()
    }
    
    func getPage(){
        ImageCache.default.memoryStorage.config.countLimit = 20
        page = page + 1
        getFilms()
    }
        
    func getFilms(){
        apiManager.getMovies(page: page, callback: {(movies) in
            self.filmsList = movies
            self.tableViewList.removeAll()
            for i in (self.filmsList?.results)!{
                self.list.append(i!)
                self.tableViewList.append(IndexPath(row: self.list.count-1, section: 0))
            }
            DispatchQueue.main.async {
//                self.tableview.setContentOffset(self.tableview.contentOffset, animated: false)
//                self.tableview.beginUpdates()
//                self.tableview.insertRows(at: self.tableViewList, with: .automatic)
//                self.tableview.endUpdates()
                    self.tableview.reloadData()
            }
        })
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filmCell", for: indexPath) as! FilmCell
        
        cell.setData(film: self.list[indexPath.row])
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FilmInfoViewController") as! FilmInfoViewController
        let n : Int = indexPath.row
        let id = String(describing: list[n].id ?? 0)
        print(indexPath.row)
        vc.filmId = id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == list.count - 1{
            DispatchQueue.global(qos: .background).async {
                self.getPage()
            }
//            ImageCache.default.clearMemoryCache()
        }
    }
}
