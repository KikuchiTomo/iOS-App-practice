//
//  ScrollView.swift
//  TogglePage
//
//  Created by TomoKikuchi on 2021/06/19.
//

import SwiftUI

struct ScrollView: View {
    var body: some View {
        
        List{
            ForEach(0..<100) { index in
               Text("\(index) Hello World")
            }
        }
        
    }
}

struct ScrollView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView()
    }
}
