//
//  SceneDelegate.swift
//  audioEngine
//
//  Created by TomoKikuchi on 2021/06/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
              let window = UIWindow(windowScene: scene)
              self.window = window
              window.makeKeyAndVisible()
              window.rootViewController?.modalPresentationStyle = .fullScreen
              window.rootViewController = UINavigationController(rootViewController: ViewController())
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}
