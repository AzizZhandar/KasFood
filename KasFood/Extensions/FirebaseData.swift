//
//  FirebaseData.swift
//  KasFood
//
//  Created by Aziz Zhandar on 29.08.2022.
//

import Foundation
import Firebase
import FirebaseDatabase

var popularDishesCount = ""

class FirebaseData {
//    let name: String
//    let description: String
//    let imageURL: String
//    let price: Double
//
//    let ref: DatabaseReference? // ссылка на базу данных (посылать данные - получать данные)
//
//    init(name: String,
//         description: String,
//         imageURL: String,
//         price: Double) {
//
//        self.name = name
//        self.description = description
//        self.imageURL = imageURL
//        self.price = price
//
//        self.ref = nil
//    }
    
//    convenience init() {
    // подтягиваются данные для ячейки
//
//    }
//
//    // ответ из Firebase
//
//    init?(snapshot: DataSnapshot) {
//        guard let value = snapshot.value as? [String: Any] else { return nil }
//
//        guard let name = value["name"] as? String,
//              let description = value["description"] as ? String,
//              let imageURL = value["imageURL"] as? String,
//              let price = value["price"] as? Double else { return nil }
//
//        self.name = name
//        self.description = description
//        self.imageURL = imageURL
//        self.price = price
//
//        self.ref = snapshot.ref
//    }
//
//    init?(dict: [String: Any]) {
//        guard let name = dict["name"] as? String,
//              let description = dict["description"] as? String,
//              let imageURL = dict["imageURL"] as? String,
//              let price = dict["price"] as? Double else { return nil }
//
//        self.name = name
//        self.description = description
//        self.imageURL = imageURL
//        self.price = price
//
//        self.ref = nil
//    }
//
//}
//    static func signUpUser(email: String, password: String, name: String, onSuccess: @escaping () -> Void, onError: @escaping (_ error: Error?) -> Void) {
//        let auth = Auth.auth()
//
//        auth.createUser(withEmail: email, password: password) { (authResult, error) in
//            if error != nil {
//                onError(error!)
//            }
//            uploadCellsToDatabase(name: <#T##String#>, description: <#T##String#>, price: <#T##String#>, imageURL: <#T##String#>, onSuccess: <#T##() -> Void#>)
//        }
//    }

    static func registerCellsInfo(name: String, description: String, imageURL: String, price: Double, onSuccess: @escaping () -> Void, onError: @escaping (_ error: Error?) -> Void) {
        
        uploadCellsToDatabase(name: name, description: description, price: price, imageURL: imageURL, onSuccess: onSuccess)
    }
    
    static func getCellsInfo(onSuccess: @escaping (_ goodData: Discounts) -> Void, onError: @escaping (_ error: Error?) -> Void) {
        let ref: DatabaseReference? // ссылка на базу данных (посылать данные - получать данные)

        ref = Database.database().reference(withPath: "dishCatefory")
//        let defaults = UserDefaults.standard
        ref?.observe(.value) { (snapshot) in
            if let dictionary = snapshot.value as? [String: Any] {
                let name = dictionary["name"] as? String
                let description = dictionary["description"] as? String
                let price = dictionary["price"] as? Double
                let imageURL = dictionary["imageURL"] as? String
                
                let dishPortraitId = snapshot.key
                print(dishPortraitId)

                let item = Discounts(
                    name: name ?? "",
                    description: description ?? "",
                    imageURL: imageURL ?? "",
                    price: price ?? 0.0)
                
//                defaults.set(name, forKey: "nameKey")
//                defaults.set(description, forKey: "descriptionKey")
//                defaults.set(price, forKey: "priceKey")
//                defaults.set(imageURL, forKey: "imageURLKey")
                
                onSuccess(item)
            }
        } withCancel: { error in
            onError(error)
        }
    }

    
    static func uploadCellsToDatabase(name: String, description: String, price: Double, imageURL: String, onSuccess: @escaping () -> Void) {
        let ref = Database.database().reference(withPath: "dishCatefory")
//        let uid = Auth.auth().currentUser?.uid
        
        ref.setValue(["name" : name, "description" : description, "price" : price, "imageURL" : imageURL])
        onSuccess()
    }

}

struct Discounts {
    let name: String
    let description: String
    let imageURL: String
    let price: Double
}
