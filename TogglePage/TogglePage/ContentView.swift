//
//  ContentView.swift
//  TogglePage
//
//  Created by TomoKikuchi on 2021/06/19.
//

import SwiftUI


struct ContentView: View {
    
    @State public var msg: String
    @State private var isEdit = false
    
    var body: some View {
        NavigationView{
            VStack{
                //Image(uiImage: img_net.img).resizable().scaledToFill()
                NetImageView(viewModel: .init(url: "https://bmcomp.co.jp/img/logo.png"))
                    .scaledToFit().padding()
                AlertButton()
                NavigationLink(destination: piyoInfoView()){
                    Text("Piyo App Info...")
                }
                NavigationLink(destination: ScrollPiyo()){
                    Text("Scroll Page...")
                }
                TextField("PIYO PIYO　モルカー", text: $msg).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                Text("ようこそ, \(msg) さん.")
                NavigationLink(destination: UserPage(name: msg)){
                    Text("Go to User Page...")
                }
                Button(action:  {
                    UserDefaults.standard.set(msg, forKey: "my_msg")
                }){
                    Text("Save value")
                }
                NotifViewModel()
            }
        }
    }
}

/*class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    
}*/

struct ContentView_Previews: PreviewProvider {
    //@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    static var previews: some View {
        ContentView(msg: UserDefaults.standard.string(forKey: "my_msg") ?? "None")
    }
}

