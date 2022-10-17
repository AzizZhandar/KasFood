//
//  ListOrdersViewController.swift
//  KasFood
//
//  Created by Aziz Zhandar on 05.07.2022.
//

import UIKit

class ListOrdersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var payButton: UIButton!
    
    let cell = DishListTableViewCell()

    var sumOf = Double()

    var orders: Orders = []
    let requestOrders = OrderFetching()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Orders"

        registerCells()


        requestOrders.getOrderInfo { goodData in
            self.orders = goodData
            self.tableView.reloadData()
            self.sumOf = summa.reduce(0, +)
            
        } onError: { error in
            print(error)
        }

        sumOf = summa.reduce(0, +)
        print(sumOf)
//        cell.priceLbl.text = "$ \(Double(cell.priceLbl.text!)!*Double(cell.quantityNumber.text!)!)"

        payButton.setTitle("Pay - $ \(self.sumOf)", for: .normal)
    }

    private func registerCells() {
        tableView.register(UINib(nibName: DishListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DishListTableViewCell.identifier)
    }

    @IBAction func payButtonPressed(_ sender: UIButton) {
        

    }


}


extension ListOrdersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DishListTableViewCell.identifier) as! DishListTableViewCell
        cell.setupOrder(order: orders[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DishDetailViewController.instantiate()
        controller.order = orders[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}
