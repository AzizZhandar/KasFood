//
//  Order.swift
//  KasFood
//
//  Created by Aziz Zhandar on 05.07.2022.
//

import Foundation
import UIKit
import Stripe
import Alamofire

struct Order {
    let name: String
    let description: String
    let price: Double
    let imageURL: String
}
typealias Orders = [Order]






struct PriceOfOrder {
    let price: Double
}
typealias PriceOfOrders = [PriceOfOrder]







// MARK: - Implementing Card (Stripe)

class OrderViewController: UIViewController {

    var productStackView = UIStackView()
    var paymentStackView = UIStackView()
    var productImageView = UIImageView()
    var productLabel = UILabel()
    var payButton = UIButton()
    var loadingSpinner = UIActivityIndicatorView()
    var outputTextView = UITextView()
    var paymentTextField = STPPaymentCardTextField()
    let backButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }

    func setupUI() {

        setupProductImage()
        setupProductLabel()
        setupLoadingSpinner()
        setupPaymentTextField()
        setupPayButton()
        setupOutputTextView()

        self.productStackView.frame = CGRect(x: 0, y: 70, width: 330, height: 150)
        self.productStackView.center.x = self.view.center.x
        self.productStackView.alignment = .center
        self.productStackView.axis = .vertical
        self.productStackView.distribution = .equalSpacing

        self.productStackView.addArrangedSubview(self.productImageView)
        self.productStackView.setCustomSpacing(10, after: self.productImageView)
        self.productStackView.addArrangedSubview(self.productLabel)

        self.view.addSubview(self.productStackView)

        self.paymentStackView.frame = CGRect(x: 0, y: 260, width: 300, height: 100)
        self.paymentStackView.center.x = self.view.center.x
        self.paymentStackView.alignment = .fill
        self.paymentStackView.axis = .vertical
        self.paymentStackView.distribution = .equalSpacing

        self.paymentStackView.addArrangedSubview(self.paymentTextField)
        self.paymentStackView.addArrangedSubview(self.payButton)

        self.view.addSubview(self.paymentStackView)
    }

    func setupProductImage() {
        self.productImageView = UIImageView(frame: CGRect(x: 50, y: 50, width: 275, height: 200))
        self.productImageView.image = UIImage(named: "")
        self.productImageView.contentMode = .scaleAspectFit
    }

    func setupProductLabel() {
        self.productLabel.frame = CGRect(x: 0, y: 270, width: self.view.frame.width, height: 50)
        self.productLabel.text = ""
        self.productLabel.textAlignment = .center
    }

    func setupOutputTextView() {
        self.outputTextView.frame = CGRect(x: 0, y: 420, width: self.view.frame.width-50, height: 100)
        self.outputTextView.center.x = self.view.center.x
        self.outputTextView.textAlignment = .left
        self.outputTextView.font = UIFont.systemFont(ofSize: 18)
        self.outputTextView.text = ""
        self.outputTextView.layer.borderColor = UIColor.purple.cgColor
        self.outputTextView.layer.borderWidth = 1.0
        self.outputTextView.isEditable = false

        self.view.addSubview(outputTextView)
    }

    func setupPaymentTextField() {
        self.paymentTextField.frame = CGRect(x: 0, y: 0, width: 330, height: 60)
    }

    func setupPayButton() {
        self.payButton.frame = CGRect(x: 60, y: 480, width: 150, height: 40)
        self.payButton.setTitle("Submit Payment", for: .normal)
        self.payButton.setTitleColor(UIColor.white, for: .normal)
        self.payButton.layer.cornerRadius = 5.0
        self.payButton.backgroundColor = UIColor.init(red: 50/255, green: 50/255, blue: 93/255, alpha: 1.0)
        self.payButton.layer.borderWidth = 1.0
        self.payButton.addTarget(self, action: #selector(pay), for: .touchUpInside)
    }

    func setupLoadingSpinner() {
        self.loadingSpinner.color = UIColor.darkGray
        self.loadingSpinner.frame = CGRect(x: 0, y: 300, width: 25, height: 25)
        self.loadingSpinner.center.x = self.view.center.x

        self.view.addSubview(self.loadingSpinner)
    }

    func startLoading() {
        DispatchQueue.main.async {
            self.loadingSpinner.startAnimating()
            self.loadingSpinner.isHidden = false
        }
    }

    func stopLoading() {
        DispatchQueue.main.async {
            self.loadingSpinner.stopAnimating()
            self.loadingSpinner.isHidden = true
        }
    }

    func displayStatus(_ message: String) {
        DispatchQueue.main.async {
            self.outputTextView.text! += message + " \n"
            self.outputTextView.scrollRangeToVisible(NSMakeRange(self.outputTextView.text.count - 1, 1))
        }
    }

    @objc func pay() {

    }
}
