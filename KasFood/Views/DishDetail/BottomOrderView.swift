//
//  BottomOrderView.swift
//  KasFood
//
//  Created by Aziz Zhandar on 02.10.2022.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage

class BottomOrderView: UIView {

//    let totalPrice = DishDetailViewController()

    let bottomView = UIView()
    let orderText = UILabel()
//    let quantityOfOrder = UILabel()

    let priceOfOrder = UILabel()
    let myCartButton = UIButton()

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }

    func setupBottomView(){

        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.backgroundColor = .systemBackground
        bottomView.alpha = 0.85
        bottomView.layer.cornerRadius = 25

        orderText.translatesAutoresizingMaskIntoConstraints = false
        orderText.text = "My Cart"
        orderText.font = UIFont.boldSystemFont(ofSize: 12)
        orderText.textAlignment = .center
        orderText.textColor = .systemOrange

        priceOfOrder.translatesAutoresizingMaskIntoConstraints = false
        myCartButton.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(bottomView)
        bottomView.addSubview(orderText)
        self.addSubview(myCartButton)

        NSLayoutConstraint.activate([
            bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            bottomView.heightAnchor.constraint(equalToConstant: 30),
            bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),

            orderText.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10),
            orderText.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
        ])
    }
}

