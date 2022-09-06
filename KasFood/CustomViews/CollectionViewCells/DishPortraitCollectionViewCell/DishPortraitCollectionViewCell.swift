//
//  DishPortraitCollectionViewCell.swift
//  KasFood
//
//  Created by Aziz Zhandar on 30.06.2022.
//

import UIKit

class DishPortraitCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: DishPortraitCollectionViewCell.self)

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var caloriesLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    func setup(dish: Dish) {
        titleLbl.text = dish.name
//        dishImageView.image = dish.imageExample
//        dishImageView.kf.setImage(with: dish.image?.asUrl)
        descriptionLbl.text = dish.description
        caloriesLbl.text = dish.formattedCalories
    }

    func setupDatabase(dish: Discounts) {
        titleLbl.text = dish.name
        descriptionLbl.text = dish.description
        dishImageView.image = UIImage(named: "\(dish.imageURL)")
        caloriesLbl.text = "\(dish.price)"
    }
}
