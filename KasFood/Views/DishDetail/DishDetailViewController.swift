//
//  DishDetailViewController.swift
//  KasFood
//
//  Created by Aziz Zhandar on 02.07.2022.
//

import UIKit

class DishDetailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var caloriesLbl: UILabel!
    
    let backButton = UIButton()

    var dish: Dish!

    override func viewDidLoad() {
        super.viewDidLoad()

        populateView()
    }

    private func populateView() {
//        dishImageView.kf.setImage(with: dish.image?.asUrl)
//        dishImageView.image = dish.imageExample
        titleLbl.text = dish.name
        descriptionLbl.text = dish.description
        caloriesLbl.text = dish.formattedCalories
    }

    @IBAction func placeOrderBtnClicked(_ sender: UIButton) {
        
        guard let name = nameField.text?.trimmingCharacters(in: .whitespaces),
              !name.isEmpty else {
            // add AlertController as error
            print("Error, Please Enter your name")
            return
        }
        
        print("Hello, \(name)")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
