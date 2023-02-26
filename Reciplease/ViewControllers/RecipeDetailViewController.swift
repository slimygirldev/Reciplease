//
//  RecipeDetailViewController.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 13/01/2023.
//

import UIKit
import WebKit

class RecipeDetailViewController: UIViewController {

    // MARK: - Properties
    
    weak var coordinator: MainCoordinator?

    private lazy var webView: WKWebView = WKWebView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))

    private let alertProvider: AlertProvider = AlertProvider()

    private let viewModel: RecipeDetailViewModel

    private lazy var tableView: RecipeDetailTableView = RecipeDetailTableView(viewModel: viewModel)

    // MARK: - Buttons

    private lazy var goToDirectionhButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Go to directions", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.accessibilityHint = ""
        button.accessibilityLabel = ""
        button.addTarget(self, action: #selector(goToDirection), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var favoriteButton: UIBarButtonItem = {
        let favoritButton = UIBarButtonItem(title: "favorite",
                                            style: .plain,
                                            target: self,
                                            action: #selector(handleFavoriteRecipe))
        favoritButton.image = UIImage(named: "heartIco")?.withRenderingMode(.alwaysTemplate)
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

    @objc func goToDirection() {
        let recipeUrl: String = viewModel.recipe.value.url
        guard recipeUrl.contains("https") else {
            return
            //present alert
        }
        view.addSubview(webView)
        guard let url = URL(string: recipeUrl) else {
            return
            //present alert
        }
        DispatchQueue.main.async { [weak self] in
            self?.webView.load(URLRequest(url: url))
        }
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
        view.addSubview(goToDirectionhButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),

            goToDirectionhButton.heightAnchor.constraint(equalToConstant: 44),
            goToDirectionhButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16),
            goToDirectionhButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            goToDirectionhButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            goToDirectionhButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])

    }

}
