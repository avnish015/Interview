//
//  UserView.swift
//  SwiftUIToUIKIKit
//
//  Created by Nishant Kumar on 12/03/24.
//

import SwiftUI

struct UserView: View {
    
    @State var isSheetPresented = false
    @State var image = Image(systemName: "person")
    
    var body: some View {
        VStack {
            image
                .resizable()
                .frame(width: 100, height: 100)
                .scaledToFill()
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.blue, lineWidth: 4.0))
                .onTapGesture {
                    isSheetPresented = true
                }
            Text("Tap on image to change it")
            HStack {
                VStack(alignment: .leading) {
                    Text("Person Name")
                    Text("Person Address")
                }
                Spacer()
            }
        }
        .sheet(isPresented: $isSheetPresented, content: {
            ImagePickerView(selectedImage: $image)
        })
    }
}
