//
//  AppDelegate.swift
//  MyAudioEngine
//
//  Created by TomoKikuchi on 2021/06/26.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        /* 通知の許可を取得 */
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]){ (granted, _) in
            if granted{
                UNUserNotificationCenter.current().delegate = self
            } else {
                print("not notification")
            }
        }
        
        /* iOS12以前で有効 */
        if #available(iOS 13, *) {
        } else {
            let window = UIWindow(frame: UIScreen.main.bounds)
            self.window = window
            window.makeKeyAndVisible()
            window.rootViewController = UINavigationController(rootViewController: ViewController())
            window.rootViewController?.modalPresentationStyle = .fullScreen
            window.rootViewController = ViewController()
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

/* 起動中のローカル通知も行う */
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .banner, .list])
    }
}
