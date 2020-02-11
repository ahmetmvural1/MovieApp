//
//  MovieList.swift
//  MovieApp
//
//  Created by koineks teknoloji on 7.02.2020.
//  Copyright © 2020 Ahmet Muhammet Vural. All rights reserved.
//

import Foundation
import SimpleApiClient

struct MovieList: SimpleApi{
     
    var language: String
    var page: Int

    var path: String {
        return "/3/tv/popular"
    }
    
    var method: HTTPMethod {
        return .get
    }
    

    var parameters: Parameters {
        return ["api_key": apiKey,"language":language, "page": page ]
    }

}
extension SimpleApiClient {
    func listMovie(language: String, page: Int) -> Observable<List>  {
        return request(api: MovieList(language: language, page: page))
    }
}
