//
//  CatApiInterface.swift
//  CatsGallery
//
//  Created by Yukti on 06/10/24.
//

/// CatApi protocol for defining api methods
protocol CatApiInterface {
    
    func getCats(tags: [String]?, skip: Int, limit: Int) async throws -> [CatModel]
}
