//
//  BaseApiRouter.swift
//  CatsGallery
//
//  Created by Yukti on 06/10/24.
//

import Foundation

/// An API router used to construct a `URLRequest` for different endpoints
protocol BaseApiRouter {
    /// The base URL of the API endpoint
    var baseUrl: URL { get }
    
    /// The `HTTPMethod` of the API endpoint
    var method: String { get }
    
    /// The path of the API endpoint
    var path: String { get }
    
    /// A type used to define how a set of parameters are applied to a `URLRequest` for the API endpoint
    var parameterEncoding: ParameterEncoding { get }
    
    /// The body of the API endpoint
    associatedtype Body: Encodable // Using associated type for the body
    
    var body: Body? { get }
    
    /// The query params of the API endpoint
    var queryParams: [String: AnyHashable]? { get }
    
    /// Timeout for the `URLRequest`
    var timeout: TimeInterval { get }
    
    /// Any additional headers to add to the URLRequest
    var headers: [String: String]? { get }
}

/// Enum to handle different parameter encodings
enum ParameterEncoding {
    case json
    case url
    
    func encode<T: Encodable>(_ request: inout URLRequest, with parameters: T?) throws {
        guard let parameters = parameters else { return }
        
        switch self {
        case .json:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase // Customize key encoding if needed
            let data = try encoder.encode(parameters)
            request.httpBody = data
            
        case .url:
            // URL encoding assumes parameters are key-value pairs
            let parametersDict = parameters as? [String: Any] ?? [:]
            let queryItems = parametersDict.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            var components = URLComponents(string: request.url?.absoluteString ?? "")
            components?.queryItems = queryItems
            request.url = components?.url
        }
    }
}

extension BaseApiRouter {
    var baseUrl: URL {
        URL(string: Constants.Api.BaseUrl)!
    }
    
    var body: Body? {
        nil
    }
    
    var queryParams: [String: AnyHashable]? {
        nil
    }
    
    var timeout: TimeInterval {
        URLSessionConfiguration.default.timeoutIntervalForRequest
    }
    
    var headers: [String: String]? {
        nil
    }
    
    var parameterEncoding: ParameterEncoding {
        .json
    }
    
    func asURLRequest() throws -> URLRequest {
        // Construct the full URL
        let url = baseUrl.appendingPathComponent(path)
        
        // Create URLComponents from the URL and add query params
        var components = URLComponents(string: url.absoluteString)
        components?.queryItems = queryParams?.map { URLQueryItem(name: $0.key, value: $0.value.description) }
        
        // Create the URLRequest
        var urlRequest = URLRequest(url: components?.url ?? url)
        urlRequest.httpMethod = method
        urlRequest.timeoutInterval = timeout
        
        // Add additional headers if they exist
        headers?.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        // Encode the parameters
        try parameterEncoding.encode(&urlRequest, with: body)
        
        return urlRequest
    }
}
