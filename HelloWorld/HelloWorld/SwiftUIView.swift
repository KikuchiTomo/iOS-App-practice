//
//  SwiftUIView.swift
//  HelloWorld
//
//  Created by TomoKikuchi on 2021/06/19.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        Image("piyo").clipShape(Circle())
            .overlay(Circle().stroke(Color.gray, lineWidth: 0.5))
            .shadow(radius: 30).padding(.all, 50)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
