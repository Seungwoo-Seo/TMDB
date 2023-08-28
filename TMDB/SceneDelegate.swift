//
//  SceneDelegate.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/15.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene)
        else { return }

        window = UIWindow(windowScene: windowScene)
        let vc = TabBarViewController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }

}

