//
//  SerialViewController.swift
//  TMDb
//
//  Created by Vlad on 24.02.2019.
//  Copyright © 2019 Vlad. All rights reserved.
//

import UIKit
import Kingfisher

class SerialViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var sTView: UITableView!
    var serialList : FilmsList?
    let apiManager = NetworkManager()
    var page = 0
    var list : [Films] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        sTView.estimatedRowHeight = 108

        getPage()
    }
    
    func getSerials(){
        apiManager.getSerials(page: page, callback: { (serials) in
            self.serialList = serials
            for i in self.serialList?.results ?? []{
                self.list.append(i!)
            }
            DispatchQueue.main.async {
                self.sTView.reloadData()
            }
        })
    }
    
    func getPage(){
        ImageCache.default.memoryStorage.config.countLimit = 20
        page = page + 1
        getSerials()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "serialCell", for: indexPath) as! SerialCell
        
        cell.setDataSerial(serial: self.list[indexPath.row])
        
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
        vc.serialId = id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == list.count - 1{
            DispatchQueue.global(qos: .background).async {
                self.getPage()
            }            //            ImageCache.default.clearMemoryCache()
        }
    }
}
