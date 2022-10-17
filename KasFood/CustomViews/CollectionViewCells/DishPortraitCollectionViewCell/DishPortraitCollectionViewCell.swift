//
//  DishPortraitCollectionViewCell.swift
//  KasFood
//
//  Created by Aziz Zhandar on 30.06.2022.
//

import UIKit
import Kingfisher

class DishPortraitCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: DishPortraitCollectionViewCell.self)

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var caloriesLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!

    func setupDatabase(dish: Discount) {
        titleLbl.text = dish.name
        descriptionLbl.text = dish.description
        dishImageView.kf.setImage(with: dish.imageURL.asUrl)
        caloriesLbl.text = "$ \(dish.price)"
    }
}
