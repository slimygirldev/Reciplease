//
//  SearchTableView.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 10/01/2023.
//

import UIKit

class SearchTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)

        delegate = self
        dataSource = self

        self.register(SearchBarTableViewCell.self,
                      forCellReuseIdentifier: SearchBarTableViewCell.reuseIdentifier)
        self.register(ItemListTableViewCell.self,
                      forCellReuseIdentifier: ItemListTableViewCell.reuseIdentifier)
        self.register(SearchButtonTableViewCell.self,
                      forCellReuseIdentifier: SearchButtonTableViewCell.reuseIdentifier)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.addGestureRecognizer(tapGesture)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func hideKeyboard() {
        self.endEditing(true)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchBarTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? SearchBarTableViewCell else { return UITableViewCell() }
            return cell
        } else if indexPath.section == 1 && indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemListTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? ItemListTableViewCell else { return UITableViewCell() }
            return cell
        } else if indexPath.section == 2 && indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchButtonTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? SearchButtonTableViewCell else { return UITableViewCell() }
            return cell
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

