//
//  AlertButton.swift
//  TogglePage
//
//  Created by TomoKikuchi on 2021/06/19.
//

import SwiftUI

struct AlertButton: View {
    @State private var showNow = false
    
    var body: some View {
        Button("Alert..."){
            self.showNow = true;
        }
        .alert(isPresented: $showNow){
                   Alert(title: Text("MORU CAR"),
                         message: Text("PUI PUI PUI PUI"),
                         primaryButton: .default(Text("OK")),
                         secondaryButton: .default(Text("NO"))
                   )
        } 
        
    }
}
