//
//  PostListRepository.swift
//  Pagination
//
//  Created by Nishant Kumar on 14/03/24.
//

import Combine
import Foundation

struct Post: Decodable, Identifiable {
    let id: Int
    let title: String
    let body: String
}

protocol PostListRepositoryProtocol {
    func fetchPosts(page: Int, limit: Int) -> AnyPublisher<[Post], HTTPError>
}

struct PostListResource: Resource {
    var endPoint: EndPoint
    var method: Method = .GET
    var body: Data? = nil
    
    func decode<Model>(type: Model.Type, data: Data?, response: URLResponse) throws -> Model where Model : Decodable {
        guard let response = response as? HTTPURLResponse, let data = data else {
            throw HTTPError.unknown
        }
        if response.statusCode >= 200 && response.statusCode <= 400 {
            let decoder = JSONDecoder()
            do {
                let objects = try decoder.decode(Model.self, from: data)
                return objects
            } catch {
                throw HTTPError.decodable
            }
        } else if response.statusCode >= 400 && response.statusCode < 500 {
            throw HTTPError.wronRequest
        } else if response.statusCode > 500 {
            throw HTTPError.noResponse
        } else {
            throw HTTPError.unknown
        }
    }
}

class PostListRepository: PostListRepositoryProtocol {
    
    let apiClient: ApiClient = URLSessionApiClient()

    func fetchPosts(page: Int, limit: Int) -> AnyPublisher<[Post], HTTPError> {
        let resource = PostListResource(endPoint: EndPoint.postList(page: page, limit: limit))
        return apiClient.callApi(resource: resource)
            .mapError({$0 as? HTTPError ?? .unknown})
            .eraseToAnyPublisher()
    }
}
