//
//  RecipeListViewController.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 13/01/2023.
//

import UIKit

class RecipeListViewController: UIViewController {

    // MARK: - Properties

    var coordinator: MainCoordinator?

    private let viewModel: RecipeListViewModel

    private let collectionView: RecipeListCollectionView

    // MARK: - Methods

    init(_ viewModel: RecipeListViewModel) {
        self.viewModel = viewModel
        self.collectionView = RecipeListCollectionView(recipes: viewModel.recipeList.value)
        self.collectionView.onSelected = { recipe in
            viewModel.selectedRecipe.value = recipe
        }
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        view.backgroundColor = .systemBackground
        title = "Recipes List"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        setupViews()
        setupConstraints()
        setupBinder()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }

    private func setupBinder() {
        viewModel.selectedRecipe.bind { [weak self] selectedRecipe in
            guard let selectedRecipe = selectedRecipe else {
                return
                // present error
            }
            self?.coordinator?.goToRecipeDetailPage(selectedRecipe)
        }
    }

    // MARK: - Setup views & Constraints
    
    private func setupViews() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
