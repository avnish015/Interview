//
//  GridView.swift
//  GridView
//
//  Created by Nishant Kumar on 17/03/24.
//

import SwiftUI

struct GridView: View {
    var body: some View {
        ScrollView {
            Grid(alignment: .leading, horizontalSpacing: 12, verticalSpacing: 20) {
                GridRow {
                    Text("R1")
                    ForEach(0..<3) {_ in
                        Circle()
                            .foregroundColor(.red)
                            .frame(width: 75)
                    }
                }
                GridRow {
                    Text("R2")
                        Circle()
                            .foregroundColor(.red)
                            .frame(width: 75)
                    Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])
                    Circle()
                        .foregroundColor(.red)
                        .frame(width: 75)

                    }
            }
        }
    }
}

#Preview {
    GridView()
}
