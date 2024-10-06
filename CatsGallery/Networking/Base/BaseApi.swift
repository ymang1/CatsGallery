//
//  BaseApi.swift
//  CatsGallery
//
//  Created by Yukti on 06/10/24.
//

import Foundation

/// `BaseApi` holds the `URLSession` responsible for making API requests.
class BaseApi {
    let session: URLSession

    init(
        session: URLSession = {
            let configuration = URLSessionConfiguration.default
            
            // Create and return a `URLSession` with the configuration
            return URLSession(configuration: configuration)
        }()
    ) {
        self.session = session
    }
}
