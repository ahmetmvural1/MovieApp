//
//  ApiClient.swift
//  MovieApp
//
//  Created by koineks teknoloji on 7.02.2020.
//  Copyright © 2020 Ahmet Muhammet Vural. All rights reserved.
//


import UIKit
import SimpleApiClient

class ApiClient: SimpleApiClient {
    static var shared: ApiClient = {
        let config = SimpleApiClient.Config(
            baseUrl: apiURL,
            timeout: 30,
            errorMessageKeyPath: "error",
            jsonDecoder: JSONDecoder(),
            isMockResponseEnabled: true,
            logHandler: { request, response in
               
        },
            errorHandler: { error in
                switch error {
                case .authenticationError(let code, let message):
                    print("authenticationError: \(code) \(message)")
                case .clientError(let code, let message):
                    print("clientError: \(code) \(message)")
                case .serverError(let code, let message):
                    print("serverError: \(code) \(message)")
                case .networkError(let source):
                    print("networkError")
                case .sslError(let source):
                    print("sslError")
                case .uncategorizedError(let source):
                    print("uncategorizedError")
                }
        }
        )
        return ApiClient(config: config)
    }()
}
