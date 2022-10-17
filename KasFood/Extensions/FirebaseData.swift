//
//  FirebaseData.swift
//  KasFood
//
//  Created by Aziz Zhandar on 29.08.2022.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage
import UIKit

var popularDishesCount = ""

class FirebaseData {
    
    static func registerCellsInfo(name: String, description: String, imageURL: String, price: Double, onSuccess: @escaping () -> Void, onError: @escaping (_ error: Error?) -> Void) {
    }
    
// MARK: - Get data from database to PopularDishes

    func getCellsInfo(onSuccess: @escaping (_ goodData: Discounts) -> Void, onError: @escaping (_ error: Error?) -> Void) {
        let ref: DatabaseReference? // ссылка на базу данных (посылать данные - получать данные)
        
        ref = Database.database().reference()
        ref?.child("dishCategory").observeSingleEvent(of: .value, with: { response in
            var discounts = Discounts()
            for child in response.children {
                guard let snap = child as? DataSnapshot else { return }
                guard let value = snap.value as? NSDictionary else { return }
                guard let name = value["name"] as? String,
                      let description = value["description"] as? String,
                      let price = value["price"] as? Double,
                      let imageURL = value["imageURL"] as? String else { return }
                
                let discount = Discount(
                    name: name,
                    description: description,
                    imageURL: imageURL,
                    price: price
                )
                discounts.append(discount)
            }

            onSuccess(discounts)
        }) { error in
            onError(error)
        }
    }

// MARK: - Get data from database to SpecialDoshes

    func getActionsDishesOfTheDay(onSuccess: @escaping (_ goodData: Discounts) -> Void, onError: @escaping (_ error: Error?) -> Void) {
        let ref: DatabaseReference? // ссылка на базу данных (посылать данные - получать данные)

        ref = Database.database().reference()
        ref?.child("actionsDishesOfTheDay").observeSingleEvent(of: .value, with: { response in
            var discounts = Discounts()
            for child in response.children {
                guard let snap = child as? DataSnapshot else { return }
                guard let value = snap.value as? NSDictionary else { return }
                guard let name = value["name"] as? String,
                      let description = value["description"] as? String,
                      let price = value["price"] as? Double,
                      let imageURL = value["imageURL"] as? String else { return }

                let discount = Discount(
                    name: name,
                    description: description,
                    imageURL: imageURL,
                    price: price
                )
                discounts.append(discount)
            }

            onSuccess(discounts)
        }) { error in
            onError(error)
        }
    }

// MARK: - Get data from database to Categories

    func getCategoryDishes(onSuccess: @escaping (_ goodData: DishCategories) -> Void, onError: @escaping (_ error: Error?) -> Void) {
        let ref: DatabaseReference? // ссылка на базу данных (посылать данные - получать данные)

        ref = Database.database().reference()
        ref?.child("categories").observeSingleEvent(of: .value, with: { response in
            var categories = DishCategories()
            for child in response.children {
                guard let snap = child as? DataSnapshot else { return }
                guard let value = snap.value as? NSDictionary else { return }
                guard let category = value["categorie"] as? String,
                      let imageCategorie = value["imageCategorie"] as? String else { return }

                let categorie = DishCategory(
                    category: category,
                    imageExample: imageCategorie
                )
                categories.append(categorie)
            }

            onSuccess(categories)
        }) { error in
            onError(error)
        }
    }


// MARK: - Get data from database to CategoryListDishes - Specific

    func getCategoryDishesToListDishes(onSuccess: @escaping (_ goodData: CategorieNames) -> Void, onError: @escaping (_ error: Error?) -> Void) {
        let ref: DatabaseReference? // ссылка на базу данных (посылать данные - получать данные)

        ref = Database.database().reference()
        ref?.child("testCategory").child("category").observeSingleEvent(of: .value, with: { response in
            var categories = CategorieNames()
            for child in response.children {
                guard let snap = child as? DataSnapshot else { return }
                guard let value = snap.value as? NSDictionary else { return }
                guard let categoryName = snap.key as? String else { return }

                let categorie = CategoryName(
                    categoryName: categoryName
                )
                categories.append(categorie)
                print(categoryName)
            }

            onSuccess(categories)
        }) { error in
            onError(error)
        }
    }




}
