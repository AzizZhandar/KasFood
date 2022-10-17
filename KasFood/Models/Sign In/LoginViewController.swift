//
//  LoginViewController.swift
//  KasFood
//
//  Created by Aziz Zhandar on 27.07.2022.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let backgroundImage = UIImageView()
    let signInLabel = UILabel()
    let loginTextField = UITextField()
    let passwordTextField = UITextField()
    let enterButton = UIButton()
    let forgetPassword = UIButton()
    let doNotHave = UILabel()
    let signUpButton = UIButton()
    
    let viewArea = UIView()
    
    let alert = AlertViewController()
    let deleteOrder = OrderFetching()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
        let defaults = UserDefaults.standard
        
        if defaults.bool(forKey: "isUserSignedIn") {
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeNC") as! UINavigationController
            viewController.modalTransitionStyle = .crossDissolve
            viewController.modalPresentationStyle = .overFullScreen
            self.present(viewController, animated: true, completion: nil)
        }
        
        style()
        layout()
        enterButton.addTarget(self, action: #selector(enterButtonPressed), for: .touchUpInside)
        forgetPassword.addTarget(self, action: #selector(forgetPasswordPressed), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
    }
    
    func validateFields() {
        login()
    }

    func login() {
        let defaults = UserDefaults.standard
        
        Auth.auth().signIn(withEmail: loginTextField.text!, password: passwordTextField.text!) { (authResult, error) in
            if error != nil {
                self.present(Service.createAlertController(title: "Error", message: error!.localizedDescription), animated: true, completion: nil)
                return
            }
//            self.checkUserInfo()
            defaults.set(true, forKey: "isUserSignedIn")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "HomeNC")
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }
        
        // Need to delete Orders in Realtime Database
        deleteOrder.deleteOrderInfo { goodData in
            print(goodData)
        } onError: { error in
            print(error)
        }
    }


    func checkUserInfo() {
        if Auth.auth().currentUser != nil {
            print(Auth.auth().currentUser?.uid)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "HomeNC")
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        }
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        checkUserInfo()
//    }
    
    func style() {
        
        viewArea.translatesAutoresizingMaskIntoConstraints = false
        viewArea.backgroundColor = .systemBackground
        viewArea.alpha = 0.85

        viewArea.layer.cornerRadius = 25
        viewArea.dropShadow()

        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.image = UIImage(named: "LoginScreen")
        backgroundImage.contentMode = .scaleAspectFill
        
        signInLabel.translatesAutoresizingMaskIntoConstraints = false
        signInLabel.text = "Sign In"
        signInLabel.font = UIFont.boldSystemFont(ofSize: 22)
        signInLabel.textAlignment = .left
        signInLabel.textColor = .systemOrange
        
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.borderStyle = .roundedRect
        loginTextField.layer.cornerRadius = 10.0
        loginTextField.placeholder = "email"
        loginTextField.clearButtonMode = .always
        loginTextField.font = UIFont.systemFont(ofSize: 15)
        loginTextField.alpha = 0.8882
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.layer.cornerRadius = 10.0
        passwordTextField.placeholder = "password"
        passwordTextField.clearButtonMode = .always
        passwordTextField.font = UIFont.systemFont(ofSize: 15)
        passwordTextField.alpha = 0.8882
        passwordTextField.isSecureTextEntry = true
        
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        enterButton.setImage(UIImage(systemName: "arrow.right.circle.fill"), for: .normal)
        let config = UIImage.SymbolConfiguration(pointSize: 50)
        enterButton.setImage(UIImage(systemName: "arrow.right.circle.fill", withConfiguration: config), for: .normal)
        enterButton.tintColor = .systemOrange
        
        forgetPassword.translatesAutoresizingMaskIntoConstraints = false
        forgetPassword.setTitle("Forget password?", for: .normal)
        forgetPassword.setTitleColor(.link, for: .normal)
        forgetPassword.contentHorizontalAlignment = .right
        forgetPassword.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        
        doNotHave.translatesAutoresizingMaskIntoConstraints = false
        doNotHave.text = "Do not have an account?"
        doNotHave.textColor = .systemGray
        doNotHave.font = UIFont.systemFont(ofSize: 12)
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        signUpButton.setTitleColor(.systemOrange, for: .normal)
    }
    
    func layout() {
        view.addSubview(backgroundImage)
        view.addSubview(viewArea)
        view.addSubview(signInLabel)
        viewArea.addSubview(loginTextField)
        viewArea.addSubview(passwordTextField)
        view.addSubview(enterButton)
        viewArea.addSubview(forgetPassword)
        viewArea.addSubview(doNotHave)
        viewArea.addSubview(signUpButton)
        
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            viewArea.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            viewArea.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
//            viewArea.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
//            viewArea.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -250),
            viewArea.heightAnchor.constraint(equalToConstant: 220),

            viewArea.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewArea.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
//            signInLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            signInLabel.topAnchor.constraint(equalTo: viewArea.topAnchor, constant: -40),
            signInLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginTextField.topAnchor.constraint(equalTo: viewArea.topAnchor, constant: 40),
            loginTextField.leadingAnchor.constraint(equalTo: viewArea.leadingAnchor, constant: 15),
            loginTextField.centerXAnchor.constraint(equalTo: viewArea.centerXAnchor),
            loginTextField.trailingAnchor.constraint(equalTo: viewArea.trailingAnchor, constant: -15),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: viewArea.leadingAnchor, constant: 15),
            passwordTextField.centerXAnchor.constraint(equalTo: viewArea.centerXAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: viewArea.trailingAnchor, constant: -15),
            
            enterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterButton.topAnchor.constraint(equalTo: viewArea.bottomAnchor, constant: 20),
//            enterButton.heightAnchor.constraint(equalToConstant: 100),
//            enterButton.widthAnchor.constraint(equalToConstant: 100),
            
            forgetPassword.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 8),
            forgetPassword.trailingAnchor.constraint(equalTo: viewArea.trailingAnchor, constant: -15),
            
            doNotHave.topAnchor.constraint(equalTo: forgetPassword.bottomAnchor, constant: 5),
            doNotHave.centerXAnchor.constraint(equalTo: viewArea.centerXAnchor),
            
            signUpButton.topAnchor.constraint(equalTo: doNotHave.bottomAnchor, constant: 1),
            signUpButton.centerXAnchor.constraint(equalTo: viewArea.centerXAnchor)

        
        ])
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    @objc func enterButtonPressed() {

        enterButton.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.enterButton.alpha = 1.0
        }
        
        validateFields()
    }
    
    @objc func forgetPasswordPressed() {
        forgetPassword.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.forgetPassword.alpha = 1.0
        }
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "ForgetPasswordView") as! UIViewController
        controller.modalPresentationStyle = .overFullScreen
        present(controller, animated: true, completion: nil)
        
        
        
    }
    
    @objc func signUpButtonPressed() {
        signUpButton.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.signUpButton.alpha = 1.0
        }
        let controller = storyboard?.instantiateViewController(withIdentifier: "SignUpView") as! UIViewController
        controller.modalPresentationStyle = .overFullScreen
//        controller.modalTransitionStyle = .flipHorizontal
        present(controller, animated: true, completion: nil)
    }
}

extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 10
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension UIView {
    func dropShadowTwo(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 10
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 0.3
    }
}
