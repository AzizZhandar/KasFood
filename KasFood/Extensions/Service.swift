//
//  Service.swift
//  KasFood
//
//  Created by Aziz Zhandar on 08.08.2022.
//

import Foundation
import UIKit
import Firebase

class Service {

    static func signUpUser(email: String, password: String, name: String, phoneNumber: String, onSuccess: @escaping () -> Void, onError: @escaping (_ error: Error?) -> Void) {
        let auth = Auth.auth()

        auth.createUser(withEmail: email, password: password) { (authResult, error) in
            if error != nil {
                onError(error!)
            }
            uploadToDatabase(email: email, name: name, password: password, phoneNumber: phoneNumber, onSuccess: onSuccess)
        }
    }

    static func getUserInfo(onSuccess: @escaping () -> Void, onError: @escaping (_ error: Error?) -> Void) {
        let ref = Database.database().reference()
        let defaults = UserDefaults.standard

        guard let uid = Auth.auth().currentUser?.uid else {
            print("User not found")
            return
        }

        ref.child("users").child(uid).observe(.value) { (snapshot) in
            if let dictionary = snapshot.value as? [String : Any] {
                let email = dictionary["email"] as! String
                let name = dictionary["name"] as! String
                let password = dictionary["password"] as! String
                let phoneNumber = dictionary["phoneNumber"] as! String
//                let bonuses = dictionary["bonuses"] as! Int

                defaults.set(email, forKey: "userEmailKey")
                defaults.set(name, forKey: "userNameKey")
                defaults.set(password, forKey: "userPasswordKey")
                defaults.set(phoneNumber, forKey: "phoneNumberKey")
//                defaults.set(phoneNumber, forKey: "bonusesKey")

                onSuccess()
            }
        } withCancel: { error in
            onError(error)
        }
    }

    static func uploadToDatabase(email: String, name: String, password: String, phoneNumber: String, onSuccess: @escaping () -> Void) {
        let ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid

        ref.child("users").child(uid!).setValue(["email" : email, "name" : name, "password" : password, "phoneNumber" : phoneNumber])
        onSuccess()
    }

    static func createAlertController(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }

        alert.addAction(okAction)
        return alert
    }
}
