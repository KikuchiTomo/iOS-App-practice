//
//  AppDelegate.swift
//  Practice
//
//  Created by TomoKikuchi on 2021/06/19.
//
import UserNotifications
import os
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate{
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // 通知の許可を取得する
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]){ (granted, _) in
            if granted{
                UNUserNotificationCenter.current().delegate = self
            } else {
                print("not notification")
            }
        }
        
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

// 通知を受け取ったときの処理
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
 
        os_log("Notified")
        // アプリ起動時も通知を行う
        completionHandler([.sound, .banner, .list])
    }
}
//extension AppDelegate: UNUserNotificationCenterDelegate {
//func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void){
// アプリ起動時も通知を行う
//        completionHandler([ .badge, .sound, .alert ])
//    }
//}
