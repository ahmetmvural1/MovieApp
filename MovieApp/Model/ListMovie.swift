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
    var total_pages: Int

    
    private enum CodingKeys: String, CodingKey{
        case results = "results"
        case total_pages = "total_pages"
    }
}

struct Results: Decodable {
    var id: Int
    var name: String
    var poster_path: String
    var vote_average: Float
    
    private enum CodingKeys: String, CodingKey{
        case id = "id"
        case name = "name"
        case poster_path = "poster_path"
        case vote_average = "vote_average"
        
     }
}
