//
//  FavoritesViewController.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 06/01/2023.
//

import UIKit

class FavoritesViewController: UIViewController {

    // MARK: - Properties

    var coordinator: FavoritesCoordinator?

    private let viewModel: FavoriteViewModel

    private lazy var recipeListCollectionView: RecipeListCollectionView = {
        let collectionView = RecipeListCollectionView(recipes: viewModel.recipeList.value)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.onSelected = { [weak self] recipe in
            self?.coordinator?.goToRecipeDetailPage(recipe)
        }
        collectionView.isHidden = true
        return collectionView
    }()

    private lazy var emptyMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "No favorites recipe yet.\n Go to search to add your first recipe to the list."
        label.font = .systemFont(ofSize: 16)
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Methods

    init(_ viewModel: FavoriteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        tabBarItem.image = UIImage(systemName: "heart.fill")
        tabBarItem.title = "Favorites"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadFavorites()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        setupSubviews()
        setupConstraints()
        setupBindings()
    }

    private func setupSubviews() {
        view.addSubview(emptyMessageLabel)
        view.addSubview(recipeListCollectionView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            recipeListCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recipeListCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recipeListCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            recipeListCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            emptyMessageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyMessageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyMessageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyMessageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func setupBindings() {
        viewModel.recipeList.bind { [weak self] recipeList in
            DispatchQueue.main.async {
                if !recipeList.isEmpty {
                    self?.emptyMessageLabel.isHidden = true
                    self?.recipeListCollectionView.isHidden = false
                }
                self?.recipeListCollectionView.recipes = recipeList
                self?.recipeListCollectionView.reloadData()
            }
        }
    }
}
