//
//  ContentView.swift
//  GridView
//
//  Created by Nishant Kumar on 17/03/24.
//

import SwiftUI

struct LazyGridView: View {
    
//    let gridItems = [
//        GridItem(.adaptive(minimum: 100, maximum: 150))]
        let gridItems = [
            GridItem(.flexible(minimum: 100, maximum: 150), alignment: .leading),
            GridItem(.flexible(minimum: 100, maximum: 150), spacing: 200)
        ]
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: gridItems, content: {
                ForEach(0..<13) {_ in
                    Circle()
                        .foregroundColor(.red)
                        .frame(width: 100)
                }
            })
        }
    }
}

#Preview {
    LazyGridView()
}
