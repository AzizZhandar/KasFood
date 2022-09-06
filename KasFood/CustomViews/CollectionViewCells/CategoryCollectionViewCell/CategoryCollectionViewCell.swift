//
//  CategoryCollectionViewCell.swift
//  KasFood
//
//  Created by Aziz Zhandar on 28.06.2022.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    static let identifier = String(describing: CategoryCollectionViewCell.self)

    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryTitleLbl: UILabel!

    func setup(category: DishCategory) {
        categoryTitleLbl.text = category.name
        categoryImageView.image = category.imageExample
//        categoryImageView.kf.setImage(with: category.image?.asUrl)
    }
}
