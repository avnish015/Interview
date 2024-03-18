//
//  ScrollViewiOS17.swift
//  GridView
//
//  Created by Nishant Kumar on 18/03/24.
//

import SwiftUI

struct ScrollViewiOS17: View {
    
    let texts = ["Avnish", "Manish", "Nishant", "Nitu"]
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(texts, id: \.self) { text in
                    Text(text)
                        .frame(width: 300, height: 30)
                        .foregroundStyle(.white)
                        .background(Color.blue)
                        .padding()
                        .background(Color.red)
                        .padding()
                        .background(Color.green)
                        .rotation3DEffect(
                            .degrees(45), axis: (x: 1.0, y: 0.0, z: 0.0)
                        )
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
    }
}

#Preview {
    ScrollViewiOS17()
}
