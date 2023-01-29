//
//  SearchTableView.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 10/01/2023.
//

import UIKit

class SearchTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    private var viewModel: SearchViewModel

    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero, style: .insetGrouped)

        delegate = self
        dataSource = self

        self.register(SearchBarTableViewCell.self,
                      forCellReuseIdentifier: SearchBarTableViewCell.reuseIdentifier)
        self.register(ItemListTableViewCell.self,
                      forCellReuseIdentifier: ItemListTableViewCell.reuseIdentifier)
        self.register(ClearButtonTableViewCell.self,
                      forCellReuseIdentifier: ClearButtonTableViewCell.reuseIdentifier)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.addGestureRecognizer(tapGesture)

        setupBindings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func hideKeyboard() {
        self.endEditing(true)
    }

    private func setupBindings() {
        viewModel.ingredientsList.bind { [weak self] enteredIngredients in
            self?.reloadData()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 2 {
            // increment section regarding of items inside the array stocking ingredients
            return viewModel.ingredientsList.value.count
        }
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // section search bar + add button row
        if indexPath.section == 0 && indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchBarTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? SearchBarTableViewCell else { return UITableViewCell() }
            // Closure reception ingredient
            cell.addIngredient = { [weak self] ingredient in
                self?.viewModel.addIngredient(ingredient)
            }

            cell.selectionStyle = .none
            return cell
            // Section of clear button
        } else if indexPath.section == 1 && indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ClearButtonTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? ClearButtonTableViewCell else { return UITableViewCell() }

            cell.clearIngredientsList = { [weak self]  in
                self?.viewModel.clearItemList()
            }
            cell.isUserInteractionEnabled = true
            return cell
        // Section of list of items row
        } else if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemListTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? ItemListTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = false

            let numberOfIngredients = viewModel.ingredientsList.value.count
            if indexPath.row < numberOfIngredients {
                cell.configure(item: viewModel.ingredientsList.value[indexPath.row])
            }
            return cell
        // Generic row
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemListTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? ItemListTableViewCell else { return UITableViewCell() }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "What's in your fridge ?"
        } else if section == 1 {
            return "List of ingredients :"
        }
        return ""
    }
}

