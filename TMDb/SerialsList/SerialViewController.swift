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
    var serialList : FilmsList?
    let apiManager = NetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        getSerials()
    }
    
    func getSerials(){
        apiManager.getSerials(callback: { (serials) in
            self.serialList = serials
            DispatchQueue.main.async {
                self.sTView.reloadData()
            }
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "serialCell", for: indexPath) as! SerialCell
        
        cell.setDataSerial(serial: self.serialList?.results[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.serialList?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FilmInfoViewController") as! FilmInfoViewController
        let n : Int = indexPath.row
        let id = String(describing: serialList?.results[n]!.id ?? 0)
        print(indexPath.row)
        vc.serialId = id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
