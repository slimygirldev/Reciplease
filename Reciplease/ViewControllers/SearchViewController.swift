//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 06/01/2023.
//

import UIKit
import Foundation

class SearchViewController: UIViewController {

    // MARK: - Properties

    var coordinator: MainCoordinator?

    private let alertProvider: AlertProvider = AlertProvider()

    private let viewModel: SearchViewModel

    private lazy var tableView: SearchTableView = SearchTableView(viewModel: viewModel)

    private let spinner: UIActivityIndicatorView = UIActivityIndicatorView()

    // MARK: - Button

    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Search recipes", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.backgroundColor = .systemMint
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(searchRecipesButtonDidTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Methods

    init(_ viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        tabBarItem.image = UIImage(systemName: "magnifyingglass")
        tabBarItem.title = "Search"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        view.backgroundColor = .systemBackground
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        setupViews()
        setupConstraints()
        setUpBinders()
    }

    func showActivityIndicatory() {
        let container: UIView = UIView()
        container.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        container.backgroundColor = .clear
        spinner.center = self.view.center
        container.addSubview(spinner)
        self.view.addSubview(container)
        spinner.startAnimating()
    }

    @objc func searchRecipesButtonDidTapped(sender: UIButton) {
        sender.isEnabled = false
        viewModel.request()
        if viewModel.ingredientsList.value.isEmpty {
            self.present(alertProvider.alertError(alertType: .noIngredients), animated: true, completion: nil)
            sender.isEnabled = true
        }
        self.showActivityIndicatory()
    }

    private func setUpBinders() {
        // setting all the listeners of search
        viewModel.error.bind { [weak self] error in
            if let error = error {
                print("received error failed to request: \(error)")
                DispatchQueue.main.async {
                    guard let alert = self?.alertProvider.alertError(alertType: .noData) else {
                        return
                    }
                    self?.spinner.stopAnimating()
                    self?.present(alert, animated: true, completion: nil)
                }
            }
            // Checking if recipes is empty / if not calling coordinator to present the recipes list received from request
            self?.viewModel.recipes.bind { [weak self] recipes in
                guard !recipes.isEmpty else {
                    return
                }
                DispatchQueue.main.async {
                    self?.spinner.stopAnimating()
                }
                self?.coordinator?.goToRecipePage(recipes)
            }
            // setting the listener to 
            self?.viewModel.isSearching.bind { [weak self] isSearching in
                self?.searchButton.isEnabled = !isSearching
            }
        }
    }

    // MARK: - Setup views & Constraints
    
    private func setupViews() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        view.addSubview(searchButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),

            searchButton.heightAnchor.constraint(equalToConstant: 44),
            searchButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16),
            searchButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            searchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
}

