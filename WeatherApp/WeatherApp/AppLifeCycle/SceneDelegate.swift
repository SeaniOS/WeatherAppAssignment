//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 17/12/25.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    /// Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    /// If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    /// This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let homeViewController = Scene().makeHomeViewController()
        let rootViewController = UINavigationController(rootViewController: homeViewController)
        
        window.rootViewController = rootViewController
        
        self.window = window
        window.makeKeyAndVisible()
    }
}
