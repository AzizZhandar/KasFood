//
//  ListDishesViewController.swift
//  KasFood
//
//  Created by Aziz Zhandar on 04.07.2022.
//

import UIKit
import Foundation
import Stripe
import ProgressHUD

class ListDishesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var category: DishCategory!
    var dishes: DishCategories = []
    let requestData = FirebaseData()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = category.category
        
        requestData.getCategoryDishes { goodData in
            self.dishes = goodData
            self.tableView.reloadData()
        } onError: { error in
            print(error)
        }

        
        registerCells()
    }

    private func registerCells() {
        tableView.register(UINib(nibName: DishListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DishListTableViewCell.identifier)
    }

}

extension ListDishesViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DishListTableViewCell.identifier) as! DishListTableViewCell
//        cell.setup(dish: dishes[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DishDetailViewController.instantiate()
//        controller.disc = dishes[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }

}
