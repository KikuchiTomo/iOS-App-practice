//
//  UserPage.swift
//  TogglePage
//
//  Created by TomoKikuchi on 2021/06/19.
//

import SwiftUI

struct UserPage: View {
    let name: String
    var body: some View {
        Text("Welcome to \(name)!")
    }
}

struct UserPage_Previews: PreviewProvider {
    static var previews: some View {
        UserPage(name: "未設定")
    }
}
