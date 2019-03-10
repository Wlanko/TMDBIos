//
//  NetworkManager.swift
//  TMDb
//
//  Created by Vlad on 10.03.2019.
//  Copyright © 2019 Vlad. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    let baseURL = "https://api.themoviedb.org/3"
    
    func getMovies(callback: @escaping (FilmsList) -> Void) {
        Alamofire.request(URL(string: "\(baseURL)/movie/popular?api_key=64e28959ab896eae16e8746c65fa2a18&page=1")!, method: .get).responseJSON { (response) in
            if response.error != nil{
                print(response.error)
                return
            }
            do{
                let filmsList = try JSONDecoder().decode(FilmsList.self, from: response.data!)
                callback(filmsList)
            }catch let error {
                print(error)
            }
        }
    }
    
    func getSerials(callback: @escaping (FilmsList) -> Void) {
        Alamofire.request(URL(string: "\(baseURL)/tv/popular?api_key=64e28959ab896eae16e8746c65fa2a18&page=1")!, method: .get).responseJSON { (response) in
            if response.error != nil{
                print(response.error)
                return
            }
            do{
                let serialsList = try JSONDecoder().decode(FilmsList.self, from: response.data!)
                callback(serialsList)
            }catch let error {
                print(error)
            }
        }
    }
    
    func getMovie(filmId: String, callback: @escaping (filmInfo) -> Void) {
        let url: URL
        url = URL(string: "\(baseURL)/movie/\(filmId)?api_key=64e28959ab896eae16e8746c65fa2a18")!
        
        Alamofire.request(url, method: .get).responseJSON {(response) in
            if response.error != nil{
                print(response.error)
            }
            
            do{
                let film = try JSONDecoder().decode(filmInfo.self, from: response.data!)
                callback(film)
            }catch let error{
                print(error)
            }
        }

    }
    
    func getSerial(serialId: String, callback: @escaping (filmInfo) -> Void) {
        let url: URL
        url = URL(string: "\(baseURL)/tv/\(serialId)?api_key=64e28959ab896eae16e8746c65fa2a18")!
        
        Alamofire.request(url, method: .get).responseJSON {(response) in
            if response.error != nil{
                print(response.error)
            }
            
            do{
                let film = try JSONDecoder().decode(filmInfo.self, from: response.data!)
                callback(film)
            }catch let error{
                print(error)
            }
        }
        
    }
}
