//
//  FilmCodable.swift
//  TMDb
//
//  Created by Vlad on 03.03.2019.
//  Copyright © 2019 Vlad. All rights reserved.
//

import Foundation

struct Films: Codable {
    let id: Int?
    let title: String?
    let name: String?
    let poster_path: String?
    let vote_average: Double?
    let overview: String?
    let backdrop_path: String?
    let release_date: String?
    //let production_companies: [ProductCompanies?]
}
struct FilmsList: Codable {
    let results: [Films?]
}


