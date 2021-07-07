//
//  piyoInfoView.swift
//  TogglePage
//
//  Created by TomoKikuchi on 2021/06/19.
//

import SwiftUI

struct piyoInfoView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack{
            Image("piyo")
                .resizable()
                .scaledToFit()
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .overlay(Circle().stroke(Color.gray, lineWidth: 1)).padding(.bottom, 40)
            Text("Piyo APP").fontWeight(.medium)
            Text("Version : 0.0").fontWeight(.ultraLight)
            Text("Revision : 0.0").fontWeight(.ultraLight)
            if presentationMode.wrappedValue.isPresented {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Back to Main menu")
                }
            }
        }
    }
}

struct piyoInfoView_Previews: PreviewProvider {
    static var previews: some View {
        piyoInfoView()
    }
}
