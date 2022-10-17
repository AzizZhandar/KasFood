//
//  DishListTableViewCell.swift
//  KasFood
//
//  Created by Aziz Zhandar on 04.07.2022.
//

import UIKit

class DishListTableViewCell: UITableViewCell {

    static let identifier = "DishListTableViewCell"

    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var quantityNumber: UILabel!
    @IBOutlet weak var minusQuantityOutlet: UIButton!
    @IBOutlet weak var plusQuantityOutlet: UIButton!

    func setupOrder(order: Order) {
        titleLbl.text = order.name
        descriptionLbl.text = order.description
        dishImageView.kf.setImage(with: order.imageURL.asUrl)
        priceLbl.text = "$ \((order.price) * (Double(quantityNumber.text!)!))"
    }

    @IBAction func minusQuantity(_ sender: UIButton) {
        minusQuantityOutlet.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.minusQuantityOutlet.alpha = 1.0
        }
        print(quantityNumber.text!)

        if Int(quantityNumber.text!)! > 1 {
            let numberMinus = Int(quantityNumber.text!)
            quantityNumber.text = String(numberMinus! - 1)
            print(quantityNumber.text!)
//            priceLbl.text = "$ \(Double(priceLbl.text!)! * (Double(quantityNumber.text!)!))"
//            setupOrder(order: Order)
            
        }
    }

    @IBAction func plusQuantity(_ sender: UIButton) {
        plusQuantityOutlet.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.plusQuantityOutlet.alpha = 1.0
        }
        print(quantityNumber.text!)

        if Int(quantityNumber.text!)! > 1 || Int(quantityNumber.text!)! == 1 {
            let numberPlus = Int(quantityNumber.text!)
            quantityNumber.text = String(numberPlus! + 1)
            print(quantityNumber.text!)
//            priceLbl.text = "$ \(Double(priceLbl.text!)! * (Double(quantityNumber.text!)!))"
        }
    }
}
