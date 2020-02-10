//
//  Detail.swift
//  MovieApp
//
//  Created by koineks teknoloji on 10.02.2020.
//  Copyright © 2020 Ahmet Muhammet Vural. All rights reserved.
//

import Foundation

struct Detail: Decodable {
    
    var created_by: [Created_by]
    var backdrop_path: String
    var seasons: [Seasons]
    var production_companies: [Production_companies]
    var overview: String?

    
    private enum CodingKeys: String, CodingKey{
        case created_by = "created_by"
        case backdrop_path = "backdrop_path"
        case seasons = "seasons"
        case production_companies = "production_companies"
         case overview = "overview"
    }
}
struct Created_by: Decodable {
    var name: String
    var gender: Int
    var profile_path: String?

    
    private enum CodingKeys: String, CodingKey{
        case name = "name"
        case gender = "gender"
        case profile_path = "profile_path"
        
     }
}

struct Seasons: Decodable {
    var air_date: String
    var episode_count: Int
    var name: String
    var poster_path: String?
    
    private enum CodingKeys: String, CodingKey{
        case air_date = "air_date"
        case episode_count = "episode_count"
        case name = "name"
        case poster_path = "poster_path"
     }
}

struct Production_companies: Decodable {
    var logo_path: String?
    var name: String

    
    private enum CodingKeys: String, CodingKey{
        case logo_path = "logo_path"
        case name = "name"
        
     }
}
