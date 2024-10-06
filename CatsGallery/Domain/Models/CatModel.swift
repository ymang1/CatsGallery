//
//  CatModel.swift
//  CatsGallery
//
//  Created by Yukti on 05/10/24.
//

import Foundation

struct CatModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        
        case id = "_id"
        
        case tags
    }
    
    var id: String
    var tags: [String]

    func getImageUrl(width: Int?, height: Int?) -> URL {
        
        var urlString = "\(Constants.Api.BaseUrl)/cat/\(id)"
        
        if let width = width, width > 0, let height = height, height > 0 {
            urlString += "?height=\(height)&width=\(width)"
        } else if let width = width, width > 0 {
            urlString += "?width=\(width)"
        } else if let height = height, height > 0 {
            urlString += "?height=\(height)"
        }
        
        return URL(string: urlString)!
    }
}
