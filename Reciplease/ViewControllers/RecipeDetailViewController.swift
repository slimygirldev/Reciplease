//
//  RecipeDetailViewController.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 13/01/2023.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    // MARK: - Properties
    
    weak var coordinator: MainCoordinator?

//    var onFavorite: ((_ recipe: RecipeModel) -> Void)?

    private let alertProvider: AlertProvider = AlertProvider()

    private let viewModel: RecipeDetailViewModel

    private lazy var tableView: RecipeDetailTableView = RecipeDetailTableView(viewModel: viewModel)

    // MARK: - Buttons
    
    private lazy var favoriteButton: UIBarButtonItem = {
        let favoritButton = UIBarButtonItem(title: "favorite",
                                            style: .plain,
                                            target: self,
                                            action: #selector(handleFavoriteRecipe))
        favoritButton.image = UIImage(named: "heartIco")?.withRenderingMode(.alwaysTemplate)
        favoritButton.tintColor = .lightGray
        return favoritButton
    }()

    // MARK: - Methods

    init(_ viewModel: RecipeDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        view.backgroundColor = .systemBackground
        title = String(viewModel.recipe.value.title)
        navigationItem.rightBarButtonItem = favoriteButton
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        setupViews()
        setupConstraints()
        setUpBinders()
    }

    @objc func handleRecipeDirections() {

    }

    @objc func handleFavoriteRecipe() {
        viewModel.handleFavoriteState()
    }

    private func setUpBinders() {
        self.viewModel.isFavorite.bind(listener: { [weak self] isFavorite in
            self?.favoriteButton.isSelected = isFavorite
            self?.favoriteButton.tintColor = isFavorite ? .red : .lightGray
        })
    }

    // MARK: - Setup views & Constraints

    private func setupViews() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

    }

}
