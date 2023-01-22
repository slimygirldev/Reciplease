//
//  RecipeDetailCollectionViewCell.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 11/01/2023.
//

import UIKit

class RecipeDetailCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "RecipeDetailCollectionViewCell"

    let favButton: UIButton = {
        let favButton = UIButton()
        favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        return favButton
    }()
}
