//
//  DetailMovie.swift
//  MovieApp
//
//  Created by koineks teknoloji on 10.02.2020.
//  Copyright © 2020 Ahmet Muhammet Vural. All rights reserved.
//

import Foundation
import SimpleApiClient

struct DetailMovie: SimpleApi{
     
    var language: String
    var movieID: Int

    var path: String {
        return "/3/tv/\(movieID)"
    }
    
    var method: HTTPMethod {
        return .get
    }
    

    var parameters: Parameters {
        return ["api_key": apiKey,"language":language]
    }

}
extension SimpleApiClient {
    func movieDetail(language: String, movieID: Int) -> Observable<Detail>  {
        return request(api: DetailMovie(language: language, movieID: movieID))
    }
}
