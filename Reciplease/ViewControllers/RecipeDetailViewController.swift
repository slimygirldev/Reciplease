//
//  RecipeDetailViewController.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 13/01/2023.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    weak var coordinator: MainCoordinator?

    private let alertProvider: AlertProvider = AlertProvider()

    private let viewModel: RecipeDetailViewModel

    private lazy var tableView: RecipeDetailTableView = RecipeDetailTableView(viewModel: viewModel)
    
    private lazy var goToDirectionButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Go to recipe directions", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(goToRecipeDirections), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

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
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        setupViews()
        setupConstraints()
    }

    @objc func goToRecipeDirections() {

    }

    @objc func addToFavoriteRecipes() {

    }

    private func setUpBinders() {
        
    }

    private func setupViews() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        view.addSubview(goToDirectionButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),

            goToDirectionButton.heightAnchor.constraint(equalToConstant: 44),
            goToDirectionButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16),
            goToDirectionButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            goToDirectionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            goToDirectionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])

    }

}
