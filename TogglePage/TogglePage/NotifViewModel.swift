//
//  NotifViewModel.swift
//  TogglePage
//
//  Created by TomoKikuchi on 2021/06/19.
//

import SwiftUI

struct NotifViewModel: View {
    @State private var showNow = false
    
    func sendNotif (){
        let trg = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let con = UNMutableNotificationContent()
        con.title = "通知！"
        con.body  = "こんにちは!"
        con.sound = UNNotificationSound.default
        
        let req = UNNotificationRequest(identifier: "no001", content: con, trigger: trg)
        UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
    }
    
    var body: some View {
        Button(action: {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]){
                (granted, error) in
                if granted {
                    sendNotif()
                }else{
                    self.showNow = true
                    alert(isPresented: $showNow){
                        Alert(title: Text("通知の許可"),
                              message: Text("通知の権限がありません．"),
                              primaryButton: .default(Text("OK")),
                              secondaryButton: .default(Text("NO"))
                        )
                    }
                }
                    
            }
        }){
            Text("Notification")
        }
    }
}
