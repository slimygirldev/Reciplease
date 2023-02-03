//
//  RecipeDetailTableView.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 27/01/2023.
//

import Foundation
import UIKit

class RecipeDetailTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties

    private var viewModel: RecipeDetailViewModel

    // MARK: - Methods
    
    init(viewModel: RecipeDetailViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero, style: .insetGrouped)

        delegate = self
        dataSource = self

        self.register(RecipeImageDetailTableViewCell.self,
                      forCellReuseIdentifier: RecipeImageDetailTableViewCell.reuseIdentifier)

        self.register(ItemListTableViewCell.self,
                      forCellReuseIdentifier: ItemListTableViewCell.reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return viewModel.recipe.value.ingredientLines?.count ?? 1
        }
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 250
        }
        return 40
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeImageDetailTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? RecipeImageDetailTableViewCell else { return UITableViewCell() }
            cell.isUserInteractionEnabled = false
            cell.configure(image: viewModel.recipe.value.image)
            return cell
        }
        if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemListTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? ItemListTableViewCell else { return UITableViewCell() }
            cell.isUserInteractionEnabled = false
            cell.selectionStyle = .none
            guard let ingredientLines = viewModel.recipe.value.ingredientLines else {
                return UITableViewCell()
            }
            if indexPath.row < ingredientLines.count {
                cell.configure(item: ingredientLines[indexPath.row])
            } else {
                return UITableViewCell()
            }
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "List of ingredients :"
        }
        return ""
    }
}
