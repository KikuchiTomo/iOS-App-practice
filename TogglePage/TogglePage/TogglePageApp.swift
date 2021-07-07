//
//  TogglePageApp.swift
//  TogglePage
//
//  Created by TomoKikuchi on 2021/06/19.
//

import SwiftUI

@main
struct TogglePageApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(msg: UserDefaults.standard.string(forKey: "my_msg") ?? "None")
        }
    }
}
