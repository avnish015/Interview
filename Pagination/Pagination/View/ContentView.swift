//
//  ContentView.swift
//  Pagination
//
//  Created by Nishant Kumar on 14/03/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = PostListViewModel()
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
                    .progressViewStyle(.circular)
                
            case .error:
                ContentUnavailableView("Server error", systemImage: "warning", description: Text("There is some error from server"))
            case .loaded:
                List(viewModel.posts) { post in
                    ForEach(0..<viewModel.posts.count, id: \.self) { index in
                        Text(viewModel.posts[index].title)
                            .onAppear {
                                viewModel.loadPosts(index: index)
                            }
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadPosts(index: 0)
        }
    }
}

#Preview {
    ContentView()
}
