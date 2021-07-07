//
//  AppDelegate.swift
//  audioEngine
//
//  Created by TomoKikuchi on 2021/06/26.
//

import UserNotifications
import os
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate{
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
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
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
 
        // アプリ起動時も通知を行う
        completionHandler([.sound, .banner, .list])
    }
}
