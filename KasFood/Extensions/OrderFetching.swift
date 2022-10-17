//
//  OrderFetching.swift
//  KasFood
//
//  Created by Aziz Zhandar on 21.09.2022.
//

import Foundation
import UIKit
import Firebase

class OrderFetching {

    var sumOfPrice = Double()

// MARK: - SignUp and Uploading Order in Firebase

    func signUpOrder(name: String, description: String, imageURL: String, price: Double, onSuccess: @escaping () -> Void, onError: @escaping (_ error: Error?) -> Void) {
        uploadOrderToDatabase(name: name, description: description, imageURL: imageURL, price: price, onSuccess: onSuccess)
        sumOfPrice = price
        sum = price
    }

    func uploadOrderToDatabase(name: String, description: String, imageURL: String, price: Double, onSuccess: @escaping () -> Void) {
        let ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid

        let uuid = UUID().uuidString

        ref.child("users").child(uid!).child("orders").child(uuid).setValue(["name": name,
                                                                             "description": description,
                                                                             "imageURL": imageURL,
                                                                             "price": price,
                                                                            ])
        onSuccess()
    }

// MARK: - Getting Order from Firebase

    func getOrderInfo(onSuccess: @escaping (_ goodData: Orders) -> Void, onError: @escaping (_ error: Error?) -> Void) {

//        var sumOfPrice:[Double] = []

        let defaults = UserDefaults.standard
        let ref: DatabaseReference?
        ref = Database.database().reference()

        guard let uid = Auth.auth().currentUser?.uid else {
            print("User not found")
            return
        }

        ref?.child("users").child(uid).child("orders").observeSingleEvent(of: .value, with: { response in
            var orders = Orders()
            for child in response.children {
                guard let snap = child as? DataSnapshot else { return }
                guard let value = snap.value as? NSDictionary else { return }
                guard let name = value["name"] as? String,
                      let description = value["description"] as? String,
                      let imageURL = value["imageURL"] as? String,
                      let price = value["price"] as? Double else { return }

                let order = Order(
                    name: name,
                    description: description,
                    price: price,
                    imageURL: imageURL
                )
                orders.append(order)
                
//                self.sumOfPrice = [price]
            }
        
            onSuccess(orders)
        }) { error in
            onError(error)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    func signUpPriceOfOrders(price: Double, onSuccess: @escaping () -> Void, onError: @escaping (_ error: Error?) -> Void) {
        
        uploadPriceOfOrdersToDatabase(price: price, onSuccess: onSuccess)
//        sumOfPrice = price
//        sum = price
        
    }

    func uploadPriceOfOrdersToDatabase(price: Double, onSuccess: @escaping () -> Void) {
        
        let ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid

        let uuid = UUID().uuidString

        ref.child("users").child(uid!).child("priceOfOrder").child(uuid).setValue(["price": price])
        
        sum = price
        onSuccess()
        
    }
    
    func getPrices(onSuccess: @escaping (_ goodData: PriceOfOrders) -> Void, onError: @escaping (_ error: Error?) -> Void) {
        let defaults = UserDefaults.standard
        let ref: DatabaseReference?
        ref = Database.database().reference()

        guard let uid = Auth.auth().currentUser?.uid else {
            print("User not found")
            return
        }

        ref?.child("users").child(uid).child("priceOfOrder").observeSingleEvent(of: .value, with: { response in
            var priceOfOrders = PriceOfOrders()
            for child in response.children {
                guard let snap = child as? DataSnapshot else { return }
                guard let value = snap.value as? NSDictionary else { return }
                guard let price = value["price"] as? Double else { return }

                let priceOfOrder = PriceOfOrder(price: price)
                priceOfOrders.append(priceOfOrder)
            }
            onSuccess(priceOfOrders)
        }) { error in
            onError(error)
        }
    }
        
    func deletePriceOrderInfo(onSuccess: @escaping (_ goodData: PriceOfOrders) -> Void, onError: @escaping (_ error: Error?) -> Void) {

        let defaults = UserDefaults.standard
        let ref: DatabaseReference?
        ref = Database.database().reference()

        guard let uid = Auth.auth().currentUser?.uid else {
            print("User not found")
            return
        }

        ref?.child("users").child(uid).child("priceOfOrder").removeValue()
    }

    
    

    

// MARK: - Deleting Previous Order in Firebase

    func deleteOrderInfo(onSuccess: @escaping (_ goodData: Orders) -> Void, onError: @escaping (_ error: Error?) -> Void) {

        let defaults = UserDefaults.standard
        let ref: DatabaseReference?
        ref = Database.database().reference()

        guard let uid = Auth.auth().currentUser?.uid else {
            print("User not found")
            return
        }

        ref?.child("users").child(uid).child("orders").removeValue()
    }
}
