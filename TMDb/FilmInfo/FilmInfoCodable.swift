//
//  FilmInfoCodable.swift
//  TMDb
//
//  Created by Vlad on 04.03.2019.
//  Copyright © 2019 Vlad. All rights reserved.
//

import Foundation

struct filmInfo: Codable {
    let id: Int?
    let title: String?
    let name: String?
    let vote_average: Double?
    let overview: String?
    let backdrop_path: String?
    let production_companies: [ProductCompanies?]
}

struct ProductCompanies: Codable {
    let logo_path: String?
    let name: String
}
