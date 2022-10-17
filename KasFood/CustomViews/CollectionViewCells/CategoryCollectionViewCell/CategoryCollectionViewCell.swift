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
        categoryTitleLbl.text = category.category
        categoryImageView.image = UIImage(named: "\(category.imageExample)")
    }
    
//    func setupDatabase(dish: Discount) {
//        titleLbl.text = dish.name
//        descriptionLbl.text = dish.description
//        dishImageView.image = UIImage(named: "\(dish.imageURL)")
//        caloriesLbl.text = "\(dish.price)"
//    }

}
