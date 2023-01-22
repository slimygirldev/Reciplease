//
//  RecipeListCollectionView.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 13/01/2023.
//

import UIKit

class RecipeListCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {

    var models: [RecipeModel] = []
    let horizontalPadding: Int = 16

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = .systemBackground

        delegate = self
        dataSource = self

        self.register(RecipeMiniatureCollectionViewCell.self,
                      forCellWithReuseIdentifier: RecipeMiniatureCollectionViewCell.reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeMiniatureCollectionViewCell.reuseIdentifier,
                                                            for: indexPath) as? RecipeMiniatureCollectionViewCell else {
            return UICollectionViewCell()
        }
        if indexPath.row < models.count {
            let model = models[indexPath.row]
            cell.configure(model: model)
        }
        return cell
    }
}
