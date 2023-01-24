//
//  RecipeListViewController.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 13/01/2023.
//

import UIKit

class RecipeListViewController: UIViewController {
    weak var coordinator: MainCoordinator?

    private let viewModel: SearchViewModel = SearchViewModel()

    var recipeList: [RecipeModel]

    var collectionView = RecipeListCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    init(_ recipeList: [RecipeModel]) {
        self.recipeList = recipeList
        super.init(nibName: nil, bundle: nil)
        collectionView.models = recipeList
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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }

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
