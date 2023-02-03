//
//  SceneDelegate.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 06/01/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Properties

    var window: UIWindow?

    // MARK: - Methods

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigation = TabBarViewController()
        let coordinator = TabBarCoordinator(navigation)
        coordinator.start()
        self.window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
    }
}
