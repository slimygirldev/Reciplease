//
//  ViewController.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 06/01/2023.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        self.tabBar.backgroundColor = .systemBackground
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemBlue], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        setupVCs()
    }

    func setupVCs() {
        viewControllers = [
            UINavigationController(rootViewController: SearchViewController()),
            UINavigationController(rootViewController: FavoritesViewController())
        ]
        viewControllers?.forEach {
            $0.edgesForExtendedLayout = []
        }
    }
}

