//
//  AccountViewController.swift
//  KasFood
//
//  Created by Aziz Zhandar on 06.08.2022.
//

import UIKit
import Firebase
import ProgressHUD
import IQKeyboardManagerSwift

class AccountViewController: UIViewController {

    let backgroundImage = UIImageView()
    let memberInfoLabel = UILabel()
    let memberLogin = UILabel()
    let memberName = UILabel()
    let memberPassword = UILabel()
    let helloLabel = UILabel()
    let logOutBarButtonItem = UIBarButtonItem()
    let auth = Auth.auth()

    let viewA = UIView()
    let viewArea = UIView()


    let viewAreaBonus = UIView()
    let bonusAmountLabel = UILabel()
    let bonusText = UILabel()
    let bonusAmount = 2

    let loginFields = LoginViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        let defaults = UserDefaults.standard

        Service.getUserInfo {
            self.helloLabel.text = "Hello, \(defaults.string(forKey: "userNameKey")!)"
            self.memberLogin.text = "Login: \(defaults.string(forKey: "userEmailKey")!)"
            self.memberPassword.text = "Password: \(defaults.string(forKey: "userPasswordKey")!)"
            self.memberName.text = "Name: \(defaults.string(forKey: "userNameKey")!)"
        } onError: { error in
            self.present(Service.createAlertController(title: "Error", message: error!.localizedDescription), animated: true, completion: nil)
        }

        styleAccount()
        setupAccount()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOutBarButtonItemPressed))
        navigationItem.rightBarButtonItem?.tintColor = .systemBackground
        navigationItem.leftBarButtonItem?.tintColor = .systemBackground
    }

    func styleAccount() {
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        memberInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        memberLogin.translatesAutoresizingMaskIntoConstraints = false
        memberPassword.translatesAutoresizingMaskIntoConstraints = false
        helloLabel.translatesAutoresizingMaskIntoConstraints = false
        bonusAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        bonusText.translatesAutoresizingMaskIntoConstraints = false
    
        viewA.translatesAutoresizingMaskIntoConstraints = false
        viewA.backgroundColor = .systemOrange
        viewA.alpha = 0.80

        viewArea.translatesAutoresizingMaskIntoConstraints = false
        viewArea.backgroundColor = .white
        viewArea.alpha = 0.80
        viewArea.layer.cornerRadius = 25
        viewArea.dropShadowTwo()

        viewAreaBonus.translatesAutoresizingMaskIntoConstraints = false
        viewAreaBonus.backgroundColor = .white
        viewAreaBonus.alpha = 0.80
        viewAreaBonus.layer.cornerRadius = 25
        viewAreaBonus.dropShadowTwo()

        memberInfoLabel.text = "Member info"
        memberInfoLabel.font = UIFont.boldSystemFont(ofSize: 18)
        memberInfoLabel.textAlignment = .left
        memberInfoLabel.textColor = UIColor(red: 0.00, green: 0.22, blue: 0.40, alpha: 1.00)

        memberLogin.text = "Login: \(loginFields.loginTextField.text!)"
        memberLogin.font = UIFont.systemFont(ofSize: 12)
        memberLogin.textAlignment = .left
        memberLogin.textColor = UIColor(red: 0.00, green: 0.22, blue: 0.40, alpha: 1.00)

        helloLabel.font = UIFont.boldSystemFont(ofSize: 24)
        helloLabel.textAlignment = .left
        helloLabel.numberOfLines = 0
        helloLabel.textColor = UIColor(red: 0.00, green: 0.22, blue: 0.40, alpha: 1.00)
        
        memberName.translatesAutoresizingMaskIntoConstraints = false
        memberName.font = UIFont.systemFont(ofSize: 12)
        memberName.textAlignment = .left
        memberName.textColor = UIColor(red: 0.00, green: 0.22, blue: 0.40, alpha: 1.00)

        memberPassword.text = "Password: \(loginFields.passwordTextField.text!)"
        memberPassword.font = UIFont.systemFont(ofSize: 12)
        memberPassword.textAlignment = .left
        memberPassword.textColor = UIColor(red: 0.00, green: 0.22, blue: 0.40, alpha: 1.00)

        backgroundImage.image = UIImage(named: "account-1")
        backgroundImage.contentMode = .scaleAspectFill
        
        bonusAmountLabel.text = "$\(String(bonusAmount))"
        bonusAmountLabel.font = UIFont.systemFont(ofSize: 40)
        bonusAmountLabel.textAlignment = .left
        bonusAmountLabel.textColor = UIColor(red: 0.00, green: 0.22, blue: 0.40, alpha: 1.00)
        
        bonusText.text = "bonuses"
        bonusText.font = UIFont.systemFont(ofSize: 20)
        bonusText.textAlignment = .left
        bonusText.textColor = UIColor(red: 0.00, green: 0.22, blue: 0.40, alpha: 1.00)

    }
    
    func setupAccount() {
        
//        view.addSubview(backgroundImage)
        view.addSubview(viewA)
        viewA.addSubview(helloLabel)
        view.addSubview(viewArea)
        view.addSubview(viewAreaBonus)
        viewArea.addSubview(memberInfoLabel)
        viewArea.addSubview(memberLogin)
        viewArea.addSubview(memberName)
        viewArea.addSubview(memberPassword)
        
        viewAreaBonus.addSubview(bonusAmountLabel)
        viewAreaBonus.addSubview(bonusText)
//
//
        NSLayoutConstraint.activate([
            
            viewA.topAnchor.constraint(equalTo: view.topAnchor),
            viewA.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewA.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewA.heightAnchor.constraint(equalToConstant: 200),
//            viewA.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            helloLabel.leadingAnchor.constraint(equalTo: viewA.leadingAnchor, constant: 20),
            helloLabel.trailingAnchor.constraint(equalTo: viewA.trailingAnchor, constant: -20),
//            helloLabel.centerYAnchor.constraint(equalTo: viewA.centerYAnchor),
            helloLabel.bottomAnchor.constraint(equalTo: viewA.bottomAnchor, constant: -20),
            
            viewArea.topAnchor.constraint(equalTo: viewA.safeAreaLayoutGuide.bottomAnchor, constant: 20),
            viewArea.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            viewArea.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            viewArea.heightAnchor.constraint(equalToConstant: 120),

            memberInfoLabel.topAnchor.constraint(equalTo: viewArea.topAnchor, constant: 20),
            memberInfoLabel.leadingAnchor.constraint(equalTo: viewArea.leadingAnchor, constant: 20),
            
            memberLogin.topAnchor.constraint(equalTo: memberInfoLabel.bottomAnchor, constant: 5),
            memberLogin.leadingAnchor.constraint(equalTo: viewArea.leadingAnchor, constant: 20),
            memberLogin.trailingAnchor.constraint(equalTo: viewArea.trailingAnchor, constant: -20),
            
            memberName.topAnchor.constraint(equalTo: memberLogin.bottomAnchor, constant: 5),
            memberName.leadingAnchor.constraint(equalTo: viewArea.leadingAnchor, constant: 20),
            memberName.trailingAnchor.constraint(equalTo: viewArea.trailingAnchor, constant: -20),

            memberPassword.topAnchor.constraint(equalTo: memberName.bottomAnchor, constant: 5),
            memberPassword.leadingAnchor.constraint(equalTo: viewArea.leadingAnchor, constant: 20),
            memberPassword.trailingAnchor.constraint(equalTo: viewArea.trailingAnchor, constant: -20),
            
            viewAreaBonus.topAnchor.constraint(equalTo: viewArea.bottomAnchor, constant: 20),
            viewAreaBonus.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            viewAreaBonus.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            viewAreaBonus.heightAnchor.constraint(equalToConstant: 100),
            
            bonusAmountLabel.leadingAnchor.constraint(equalTo: viewAreaBonus.leadingAnchor, constant: 20),
            bonusAmountLabel.topAnchor.constraint(equalTo: viewAreaBonus.topAnchor, constant: 20),
            bonusAmountLabel.bottomAnchor.constraint(equalTo: viewAreaBonus.bottomAnchor, constant: -20),
            
            bonusText.leadingAnchor.constraint(equalTo: bonusAmountLabel.trailingAnchor, constant: 7),
            bonusText.centerYAnchor.constraint(equalTo: viewAreaBonus.centerYAnchor),
            

        ])
    }
    
    @objc func logOutBarButtonItemPressed() {
        
//        let auth = Auth.auth()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC")
        
        do {
            try auth.signOut()
            let defaults = UserDefaults.standard
            defaults.set(false, forKey: "isUserSignedIn")
//            self.dismiss(animated: true, completion: nil)
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true, completion: nil)
        } catch let signOutError {
            self.present(Service.createAlertController(title: "Error", message: signOutError.localizedDescription), animated: true, completion: nil)
        }
    }
}
