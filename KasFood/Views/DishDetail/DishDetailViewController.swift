//
//  DishDetailViewController.swift
//  KasFood
//
//  Created by Aziz Zhandar on 02.07.2022.
//

import UIKit
import ProgressHUD
import Kingfisher
import Firebase

var summa: [Double] = []
var sum = Double()

class DishDetailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var caloriesLbl: UILabel!
    @IBOutlet weak var orderButton: UIButton!
    
    let bottomView = UIView()
    let orderText = UILabel()
//    let quantityOfOrder = UILabel()

    let priceOfOrder = UILabel()
    let myCartButton = UIButton()

//    let backButton = UIButton()
//    let bottomViewOfOrder = BottomOrderView()

    var dish: Dish!
    var disc: Discount!
    var order: Order!
    var orderFetch = OrderFetching()

    override func viewDidLoad() {
        super.viewDidLoad()
        populateView()

    }

    private func populateView() {
        dishImageView.kf.setImage(with: disc.imageURL.asUrl)
        titleLbl.text = disc.name
        descriptionLbl.text = disc.description
        caloriesLbl.text = "$ \(disc.price)"
    }

    @IBAction func placeOrderBtnClicked(_ sender: UIButton) {

        orderButton.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.orderButton.alpha = 1.0
        }

        if orderButton.titleLabel?.text == "Add to Cart" {

            orderButton.backgroundColor = .systemGreen
            orderButton.setTitle("Added", for: .normal)

            orderFetch.signUpOrder(name: disc.name,
                                      description: disc.description,
                                      imageURL: "\(disc.imageURL)",
                                      price: disc.price) {
                print("DONE")
                print(self.disc.price)
                summa.append(self.disc.price)
            } onError: { error in
                print("Error")
            }

        } else {

            orderButton.backgroundColor = .systemOrange
            orderButton.setTitle("Add to Cart", for: .normal)
            
            // need to add alert - Food deleted from order list
            // MARK: - Deleting dish from Order List
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//        backButton.translatesAutoresizingMaskIntoConstraints = false
//        backButton.setImage(UIImage(systemName: "arrow.backward.circle.fill"), for: .normal)
//        let config = UIImage.SymbolConfiguration(pointSize: 40)
//        backButton.setImage(UIImage(systemName: "arrow.backward.circle.fill", withConfiguration: config), for: .normal)
//        backButton.tintColor = .systemOrange
//
//        layout()
//
//        backButton.addTarget(self, action: #selector(backButtonPressedDetail), for: .touchUpInside)

//    func setupBottomView(){
//
//        bottomView.translatesAutoresizingMaskIntoConstraints = false
//        bottomView.backgroundColor = .systemBackground
//        bottomView.alpha = 1.00
//        bottomView.layer.borderWidth = 1
//        bottomView.layer.borderColor = UIColor.systemOrange.cgColor//UIColor(red: 0.99, green: 0.52, blue: 0.12, alpha: 1)
//        bottomView.layer.cornerRadius = 25
//
//        orderText.translatesAutoresizingMaskIntoConstraints = false
//        orderText.text = "My Cart"
//        orderText.font = UIFont.boldSystemFont(ofSize: 15)
//        orderText.textAlignment = .center
//        orderText.textColor = .systemOrange
//
//        priceOfOrder.translatesAutoresizingMaskIntoConstraints = false
//        myCartButton.translatesAutoresizingMaskIntoConstraints = false
//
//        view.addSubview(bottomView)
//        bottomView.addSubview(orderText)
////        view.addSubview(myCartButton)
//
//        NSLayoutConstraint.activate([
//            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
//            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
//            bottomView.heightAnchor.constraint(equalToConstant: 60),
//            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
//
//            orderText.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10),
//            orderText.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
//        ])
//    }
//
//    @objc func backButtonPressedDetail() {
//        let controller = storyboard?.instantiateViewController(withIdentifier: "HomeNC") as! UIViewController
//        controller.modalPresentationStyle = .fullScreen
//        controller.modalTransitionStyle = .crossDissolve
//        present(controller, animated: true, completion: nil)
//    }
//
//    func layout() {
//        view.addSubview(backButton)
//
//        NSLayoutConstraint.activate([
//            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 1),
//            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//        ])
//    }
