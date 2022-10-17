//
//  HomeViewController.swift
//  KasFood
//
//  Created by Aziz Zhandar on 27.06.2022.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class HomeViewController: UIViewController {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var specialCollectionView: UICollectionView!

    var categories: DishCategories = []
    var categoryName: CategorieNames = []
    var populars: Discounts = []
    var specials: Discounts = []

    let requestData = FirebaseData()
    let alert = AlertAsAdViewController()
    let deletingOrder = OrderFetching()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "KasFood"

        requestData.getCategoryDishes { goodData in
            self.categories = goodData
            self.categoryCollectionView.reloadData()
        } onError: { error in
            print(error)
        }

        requestData.getCategoryDishesToListDishes { goodData in
            self.categoryName = goodData
            print("This is the categorie names - \(self.categoryName)")
//            self.categoryCollectionView.reloadData()
        } onError: { error in
            print(error)
        }

        requestData.getCellsInfo { discounts in
            self.populars = discounts
            self.popularCollectionView.reloadData()
        } onError: { error in
            print(error)
        }

        requestData.getActionsDishesOfTheDay { goodData in
            self.specials = goodData
            self.specialCollectionView.reloadData()
        } onError: { error in
            print(error)
        }

        registerCells()

        alert.showAlert(with: "", message: "", on: self)
        
    }

    private func registerCells() {
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        popularCollectionView.register(UINib(nibName: DishPortraitCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DishPortraitCollectionViewCell.identifier)
        specialCollectionView.register(UINib(nibName: DishLandscapeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DishLandscapeCollectionViewCell.identifier)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoryCollectionView:
            return categories.count
        case popularCollectionView:
            return populars.count
        case specialCollectionView:
            return specials.count
        default: return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case categoryCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
            cell.setup(category: categories[indexPath.row])
            return cell
        case popularCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishPortraitCollectionViewCell.identifier, for: indexPath) as! DishPortraitCollectionViewCell
            cell.setupDatabase(dish: populars[indexPath.row])
            return cell
        case specialCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishLandscapeCollectionViewCell.identifier, for: indexPath) as! DishLandscapeCollectionViewCell
            cell.setup(dish: specials[indexPath.row])
            return cell
        default: return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            let controller = ListDishesViewController.instantiate()
            controller.category = categories[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        } else {
            let controller = DishDetailViewController.instantiate()
            controller.disc = collectionView == popularCollectionView ? populars[indexPath.row] : specials[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}
