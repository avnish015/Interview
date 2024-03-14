//
//  PostListViewModel.swift
//  Pagination
//
//  Created by Nishant Kumar on 15/03/24.
//

import Foundation
import Combine

enum State {
    case loading
    case loaded
    case error
}
class PostListViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    @Published var state: State = .loading
    
    let repository: PostListRepositoryProtocol = PostListRepository()
    let pageLimit = 10
    var currentPage: Int = 0
    
    var cancellables: [AnyCancellable] = []
    
    func loadPosts(index: Int) {
        if index == posts.count - 1 && currentPage < pageLimit || posts.count == 0 {
            state = .loading
            currentPage += 1
            repository.fetchPosts(page: currentPage, limit: pageLimit)
                .receive(on: RunLoop.main)
                .sink { completion in
                    switch completion {
                    case .finished: break
                    case .failure(_): self.state = .error
                    }
                } receiveValue: { posts in
                    self.state = .loaded
                    self.posts = posts
                }
                .store(in: &cancellables)
        }
    }
}
