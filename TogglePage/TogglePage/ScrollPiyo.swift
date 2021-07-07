//
//  ScrollPiyo.swift
//  TogglePage
//
//  Created by TomoKikuchi on 2021/06/19.
//

import SwiftUI

struct ScrollPiyo: View {
    var body: some View {
        ScrollView{
            VStack{
                ForEach(0..<30){ num in
                    Text("No. \(num) Hello World").padding(.all, 10)
                }
            }
        }
    }
}

struct ScrollPiyo_Previews: PreviewProvider {
    static var previews: some View {
        ScrollPiyo()
    }
}
