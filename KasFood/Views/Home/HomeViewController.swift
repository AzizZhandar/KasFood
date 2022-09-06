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

    
//    let defaults = UserDefaults.standard
//
//    if loginTextField.text!.isEmpty || passwordTextField.text!.isEmpty || nameTextField.text!.isEmpty {
//        alert.showAlert(with: "Oups!", message: "Need to fill textfields", on: self)
//    } else {
//        Service.signUpUser(email: loginTextField.text!, password: passwordTextField.text!, name: nameTextField.text!) {
//            defaults.set(true, forKey: "isUserSignedIn")
//            let controller = self.storyboard?.instantiateViewController(withIdentifier: "HomeNC") as! UINavigationController
//            controller.modalPresentationStyle = .overFullScreen
//            self.present(controller, animated: true, completion: nil)
//        } onError: { error in
//            self.present(Service.createAlertController(title: "Error", message: error!.localizedDescription), animated: true, completion: nil)
//        }
//    }

//    private func registerCellsInfoToHVC() {
//        FirebaseData.registerCellsInfo(name: "Filete de res", description: "Con papas fritas, patacones o papas western", imageURL: "", price: 8.0) {
//            var categories: [DishCategory] = [
//                .init(name: "Filete de res", image: "")
//            ]
//        } onError: { error in
//            self.present(Service.createAlertController(title: "Error", message: error!.localizedDescription), animated: true, completion: nil)
//        }
//    }
    
//    var categories: [DishCategory] = [
//        .init(name: "Burgers", image: ""),
//        .init(name: "Chicken", image: ""),
//        .init(name: "Bebidas", image: ""),
//        .init(name: "Guarniciones", image: ""),
//    ]

    var categories: [DishCategory] = [
        .init(name: "Burgers", imageExample: UIImage(named: "04_KAS BURGER")),
        .init(name: "Chicken", imageExample: UIImage(named: "03_KAS CHICKEN 1.2")),
        .init(name: "Bebidas", imageExample: UIImage(named: "")),
        .init(name: "Guarniciones", imageExample: UIImage(named: "")),
//        .init(id: "id1", name: "Panama 5", image: "", imageExample: UIImage(named: "")),
    ]

    //    var populars: [Dish] = [
    //        .init(id: "id1", name: "Filete de res", description: "Con papas fritas, patacones o papas western", imageExample: UIImage(named: "11_FILETE DE RES"), calories: 8.0),
    //        .init(id: "id1", name: "Chuleta Fresca", description: "Con papas western o patacones", imageExample: UIImage(named: "12_CHULETA FRESCA"), calories: 8.0),
    //        .init(id: "id1", name: "Picada de carne", description: "Pollo, cerdo y res", imageExample: UIImage(named: "13_PICADA DE CARNE"), calories: 14.0),
    //        .init(id: "id1", name: "Costillas en salsa", description: "Con papas salteadas o papas western", imageExample: UIImage(named: "14_COSTILLAS EN SALSA"), calories: 7.50),
    //        .init(id: "id1", name: "Brochetas de resr", description: "Con papas fritas o patacones", imageExample: UIImage(named: "15_BROCHETAS DE RESR"), calories: 5.50),
    //    ]


//    var discountOfTheDay: [Dish] = [
//        .init(image: "", name: "Filete de res", description: "Con papas fritas, patacones o papas western", calories: 8.0),
//        .init(image: "", name: "Chuleta Fresca", description: "Con papas western o patacones", calories: 8.0),
//        .init(image: "", name: "Picada de carne", description: "Pollo, cerdo y res", calories: 14.0),
//        .init(image: "", name: "Costillas en salsa", description: "Con papas salteadas o papas western", calories: 7.50),
//        .init(image: "", name: "Brochetas de resr", description: "Con papas fritas o patacones", calories: 5.50),
//    ]

    var discounts: [Discounts] = [
        getCellsInfo(onSuccess: { <#Discounts#> in
            <#code#>
        }, onError: <#T##(Error?) -> Void#>)
    ]
    var discountOfTheDay: [Discounts] = [
        .init(name: "", description: "", imageURL: "", price: 0.0),
        
    ]
    var actionOfTheDay: [Dish] = [
        .init(image: "", name: "Kas Chicken 1/4", description: "Un cuarto de pollo con papas o patacones", calories: 5.0),
        .init(image: "", name: "Boneless apanado", description: "6 unidades apanado con salsa papas y soda", calories: 5.0),
        .init(image: "", name: "Kas Chicken 1/2", description: "(Mitad de pollo con papas o pataones)", calories: 7.0),
        .init(image: "", name: "Kas Burger", description: "Carne mixta de cerdo y res receta artesanal", calories: 6.50),
        .init(image: "", name: "Kas Crispy", description: "(Carne de pollo apanado) Lechuga, Cebolla, Tomate queso", calories: 7.50),
    ]

//    var specials: [Dish] = [
//        .init(id: "id1", name: "Kas Chicken 1/4", description: "Un cuarto de pollo con papas o patacones", imageExample: UIImage(named: "01_KAS CHICKEN 1.4"), calories: 5.0),
//        .init(id: "id1", name: "Boneless apanado", description: "6 unidades apanado con salsa papas y soda", imageExample: UIImage(named: "02_BONELESS APANADO"), calories: 5.0),
//        .init(id: "id1", name: "Kas Chicken 1/2", description: "(Mitad de pollo con papas o pataones)", imageExample: UIImage(named: "03_KAS CHICKEN 1.2"), calories: 7.0),
//        .init(id: "id1", name: "Kas Burger", description: "Carne mixta de cerdo y res receta artesanal", imageExample: UIImage(named: "04_KAS BURGER"), calories: 6.50),
//        .init(id: "id1", name: "Kas Crispy", description: "(Carne de pollo apanado) Lechuga, Cebolla, Tomate queso", imageExample: UIImage(named: "05_KAS CRISPY"), calories: 7.50),
//    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "KasFood"
//        let defaults = UserDefaults.standard
//        FirebaseData.getCellsInfo {goodData in
//            self.discountOfTheDay = [
//                .init(image: defaults.string(forKey: "imageURLKey")!, name: defaults.string(forKey: "nameKey")!, description: defaults.string(forKey: "descriptionKey")!, calories: defaults.double(forKey: "priceKey"))
//
//            ]
//        } onError: { error in
//            self.present(Service.createAlertController(title: "Error", message: error!.localizedDescription), animated: true, completion: nil)
//        }

        NetworkService.shared.myFirstRequest { (result) in
            switch result{
            case .success(let data):
                print("The decoded data is: \(data)")
            case.failure(let error):
                print("The error is: \(error.localizedDescription)")
            }
        }
        
        registerCells()
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
//            return populars.count
//            return discountOfTheDay.count
            return popularDishesCount.count
        case specialCollectionView:
//            return specials.count
            return actionOfTheDay.count
        default: return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case categoryCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
//            cell.setup(category: categories[indexPath.row])
            cell.setup(category: categories[indexPath.row])
            return cell
        case popularCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishPortraitCollectionViewCell.identifier, for: indexPath) as! DishPortraitCollectionViewCell
//            cell.setup(dish: populars[indexPath.row])
//            cell.setup(dish: discountOfTheDay[indexPath.row])
//            cell.setupDatabase(dish: popularDishesCount[indexPath.row])
            return cell
        case specialCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishLandscapeCollectionViewCell.identifier, for: indexPath) as! DishLandscapeCollectionViewCell
//            cell.setup(dish: specials[indexPath.row])
            cell.setup(dish: actionOfTheDay[indexPath.row])
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
//            controller.dish = collectionView == popularCollectionView ? populars[indexPath.row] : specials[indexPath.row]
//            controller.dish = collectionView == popularCollectionView ? discountOfTheDay[indexPath.row] : actionOfTheDay[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}
