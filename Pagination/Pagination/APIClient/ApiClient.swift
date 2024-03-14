//
//  APIClient.swift
//  Pagination
//
//  Created by Nishant Kumar on 14/03/24.
//

import Foundation
import Combine

extension URL {
    static func createURL(endPoint: EndPoint) -> URL? {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "jsonplaceholder.typicode.com"
        urlComponent.path = endPoint.path
        let queries = endPoint.query 
            .map { key, value in
                    return URLQueryItem(name: key, value: value)
                }
        urlComponent.queryItems = queries
        return urlComponent.url
    }
}

struct EndPoint {
    let path: String
    let query: [String: String]
}

extension EndPoint {
    
    var url: URL? {
        return URL.createURL(endPoint: self)
    }
    
    static func postList(page: Int, limit: Int) -> EndPoint {
        EndPoint(path: "/posts", query: ["page": "\(page)", "limit": "\(limit)"])
    }
}

enum Method: String {
    case GET
    case POST
    case PUT
    case DELETE
    
    var name: String {
        return rawValue
    }
}

protocol Resource {
    var endPoint: EndPoint { get }
    var method: Method { get }
    var body: Data? { get }
    var timeoutInterval: Double { get }
    
    func decode<Model: Decodable>(type: Model.Type, data: Data?, response: URLResponse)throws -> Model
}

extension Resource {
    var contentType: String {
        "application/json"
    }
    
    var timeoutInterval: Double {
        return 1.0
    }
}

enum HTTPError: Error {
    case wrongURL
    case noResponse
    case wronRequest
    case decodable
    case unknown
}

protocol ApiClient {
    func callApi<Model: Decodable>(resource: Resource) -> AnyPublisher<Model, Error>
}


class URLSessionApiClient: ApiClient {
    
    let urlSession: URLSession = URLSession.shared
    
    func callApi<Model: Decodable>(resource: Resource) -> AnyPublisher<Model, Error> {
        
        guard let request = makeURLRequest(resource: resource) else {
            return Fail(error: HTTPError.wrongURL)
                .eraseToAnyPublisher()
        }
        return urlSession.dataTaskPublisher(for: request)
            .tryMap { data, response in
                try resource.decode(type: Model.self, data: data, response: response)
            }
            .eraseToAnyPublisher()
    }
    
    func makeURLRequest(resource: Resource) -> URLRequest? {
        guard let url = resource.endPoint.url else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = resource.method.rawValue
        urlRequest.httpBody = resource.body
        urlRequest.addValue(resource.contentType, forHTTPHeaderField: "Accept")
        urlRequest.addValue(resource.contentType, forHTTPHeaderField: "Content-Type")
        urlRequest.timeoutInterval = resource.timeoutInterval
        return urlRequest
    }
}
