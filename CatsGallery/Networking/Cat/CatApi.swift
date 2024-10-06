//
//  CatApi.swift
//  CatsGallery
//
//  Created by Yukti on 06/10/24.
//

import Foundation

/// Represents an API for all cat related endpoints.
/// Only responsible for using ``BaseApi/session`` to make requests
class CatApi: BaseApi, CatApiInterface {
    
    func getCats(tags: [String]?, skip: Int, limit: Int) async throws -> [CatModel] {
        
        let request = CatApiRouter.getCats(tags: tags, skip: skip, limit: limit)
        
        // Create URLRequest from the router
        let urlRequest = try request.asURLRequest()
        
        // Perform the network request
        let (data, response) = try await session.data(for: urlRequest)
        
        // Validate the response
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw ApiError.errorGettingCats
        }
        
        // Decode the data to [CatModel]
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let cats = try decoder.decode([CatModel].self, from: data)
        
        return cats
    }
}
