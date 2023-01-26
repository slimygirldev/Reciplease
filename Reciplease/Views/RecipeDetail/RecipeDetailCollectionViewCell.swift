//
//  RecipeDetailTableViewCell.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 11/01/2023.
//

import UIKit

class RecipeDetailView: UIView {
    static let reuseIdentifier = "RecipeDetailTableViewCell"

    let favButton: UIButton = {
        let favButton = UIButton()
        favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        return favButton
    }()

}
