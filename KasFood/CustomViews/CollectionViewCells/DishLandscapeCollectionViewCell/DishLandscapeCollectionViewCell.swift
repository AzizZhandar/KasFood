//
//  DishLandscapeCollectionViewCell.swift
//  KasFood
//
//  Created by Aziz Zhandar on 02.07.2022.
//

import UIKit

class DishLandscapeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: DishLandscapeCollectionViewCell.self)
    
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var caloriesLbl: UILabel!
    
    func setup(dish: Discount) {
        dishImageView.kf.setImage(with: dish.imageURL.asUrl)
//        dishImageView.image = UIImage(named: "\(dish.imageURL)")
        titleLbl.text = dish.name
        descriptionLbl.text = dish.description
        caloriesLbl.text = "$ \(dish.price)"
    }
    
//    func setupDatabase(dish: Discount) {
//        titleLbl.text = dish.name
//        descriptionLbl.text = dish.description
//        dishImageView.image = UIImage(named: "\(dish.imageURL)")
//        caloriesLbl.text = "\(dish.price)"
//    }

}
