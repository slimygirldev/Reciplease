//
//  FavoritesViewController.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 06/01/2023.
//

import UIKit

class FavoritesViewController: UIViewController {
    var coordinator: FavoritesCoordinator?

    private let viewModel: FavoriteViewModel

    init(_ viewModel: FavoriteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        tabBarItem.image = UIImage(systemName: "heart.fill")
        tabBarItem.title = "Favorites"

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
}