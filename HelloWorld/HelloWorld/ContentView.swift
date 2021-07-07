//
//  ContentView.swift
//  HelloWorld
//
//  Created by TomoKikuchi on 2021/06/19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            SwiftUIView()
            SwiftUIViewText()
            Text("PIYO PIYO HIYOCAR")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
