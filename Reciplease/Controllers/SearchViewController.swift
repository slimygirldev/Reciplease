//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 06/01/2023.
//

import UIKit

class SearchViewController: UIViewController {

    private let viewModel: SearchViewModel = SearchViewModel()

    var tableView: SearchTableView = SearchTableView(frame: .zero, style: .insetGrouped)

    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem.image = UIImage(systemName: "magnifyingglass")
        tabBarItem.title = "Search"

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        viewModel.request()
        setUpBinders()

        setupViews()
        setupConstraints()
    }

    private func setUpBinders() {
        viewModel.error.bind { [ weak self ] error in
            if let error = error {
                print(error)
            }
        }
        viewModel.recipes.bind { [ weak self ] recipes in
            print(recipes)
            self?.goToRecipePage(recipes)
        }
    }

    private func goToRecipePage(_ recipeList: [RecipeModel] ) {
        let controller = RecipeListViewController()
        self.navigationController?.present(controller, animated: true)
    }

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

