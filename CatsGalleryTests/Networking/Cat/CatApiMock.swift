//
//  CatApiMock.swift
//  CatsGalleryTests
//
//  Created by Yukti on 06/10/24.
//

@testable import CatsGallery

class CatApiMock: CatApiInterface {
    
    var getCatsCalled = false
    var getCatsError: Error?
    var getCatsResponse: [CatModel] = []

    func getCats(tags: [String]?, skip: Int, limit: Int) async throws -> [CatModel] {
        getCatsCalled = true

        if let error = getCatsError {
            throw error
        }
        return getCatsResponse
    }
}
