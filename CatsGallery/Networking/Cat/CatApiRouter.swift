//
//  CatApiRouter.swift
//  CatsGallery
//
//  Created by Yukti on 06/10/24.
//

/// An API router for cat related endpoints
enum CatApiRouter: BaseApiRouter {
    
    case getCats(tags: [String]?, skip: Int, limit: Int)
    
    var method: String {
        switch self {
        case .getCats:
            return HTTPMethod.GET.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .getCats:
            return Constants.Api.CatsPath
        }
    }
    
    // Provide the concrete type for Body as nil since this request has no body
    typealias Body = EmptyRequestBody
    
    var body: EmptyRequestBody? {
        nil // No body for this endpoint
    }
    
    var queryParams: [String: AnyHashable]? {
        switch self {
        case .getCats(let tags, let skip, let limit):
            var query: [String: AnyHashable] = [
                "skip": skip,
                "limit": limit
            ]
            if let tags = tags {
                query["tags"] = tags.joined(separator: ",")
            }
            
            return query
        }
    }
}

// Define an empty struct for requests that have no body
struct EmptyRequestBody: Encodable {}
