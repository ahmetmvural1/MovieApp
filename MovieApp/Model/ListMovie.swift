//
//  ListMoview.swift
//  MovieApp
//
//  Created by koineks teknoloji on 7.02.2020.
//  Copyright © 2020 Ahmet Muhammet Vural. All rights reserved.
//

import Foundation


struct ListMovie: Decodable {
    
    var results: [Results]


    
    private enum CodingKeys: String, CodingKey{
        case results = "results"
    }
}

struct Results: Decodable {
    var id: Int
    var original_name: String
    var poster_path: String
    var vote_average: String
    var first_air_date: String
    var original_language: String
    var overview: String
    
    private enum CodingKeys: String, CodingKey{
        case id = "id"
        case original_name = "original_name"
        case poster_path = "poster_path"
        case vote_average = "vote_average"
        case first_air_date = "first_air_date"
        case original_language = "original_language"
        case overview = "overview"
        
     }
}
