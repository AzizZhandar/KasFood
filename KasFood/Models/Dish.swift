//
//  Dish.swift
//  KasFood
//
//  Created by Aziz Zhandar on 30.06.2022.
//

import Foundation
import UIKit

struct Dish {
    let image, name, description: String?
//    let imageExample: UIImage?
    let calories: Double?
    
//    private var toAnyObject: Any {
//        return [
//            "image": image,
//            "name": name,
//            "description": description,
//        ]
//    }
    
    var formattedCalories: String {
        return "$ \(calories ?? 0)"
    }
}
