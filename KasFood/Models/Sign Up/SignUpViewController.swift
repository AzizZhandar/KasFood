//
//  SignUpViewController.swift
//  KasFood
//
//  Created by Aziz Zhandar on 04.08.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import IQKeyboardManagerSwift

class SignUpViewController: UIViewController, UITextFieldDelegate {

    let backgroundImage = UIImageView()
    let signUpLabel = UILabel()
    let nameTextField = UITextField()
    let loginTextField = UITextField()
    let passwordTextField = UITextField()
    let phoneNumber = UITextField()

    let enterButtonSignUp = UIButton()
    let haveAnAccount = UILabel()
    let signInButton = UIButton()

    let viewArea = UIView()

    let alert = SignUpAlertViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.delegate = self
        loginTextField.delegate = self
        passwordTextField.delegate = self
        phoneNumber.delegate = self

        style()
        layout()
        enterButtonSignUp.addTarget(self, action: #selector(enterButtonSignUpPressed), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
    }

    func style() {

        viewArea.translatesAutoresizingMaskIntoConstraints = false
        viewArea.backgroundColor = .systemBackground
        viewArea.alpha = 0.80
        viewArea.layer.cornerRadius = 25
        viewArea.dropShadow()

        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.image = UIImage(named: "SignUpScreen")
        backgroundImage.contentMode = .scaleAspectFill

        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        signUpLabel.text = "Sign Up"
        signUpLabel.font = UIFont.boldSystemFont(ofSize: 22)
        signUpLabel.textAlignment = .left
//        signUpLabel.textColor = .systemBlue
        signUpLabel.textColor = UIColor(red: 0.00, green: 0.22, blue: 0.40, alpha: 1.00)

        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.borderStyle = .roundedRect
        nameTextField.layer.cornerRadius = 10.0
        nameTextField.placeholder = "name"
        nameTextField.clearButtonMode = .always
        nameTextField.font = UIFont.systemFont(ofSize: 15)
        nameTextField.alpha = 0.8882

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

        phoneNumber.translatesAutoresizingMaskIntoConstraints = false
        phoneNumber.borderStyle = .roundedRect
        phoneNumber.layer.cornerRadius = 10.0
        phoneNumber.placeholder = "phone number"
        phoneNumber.clearButtonMode = .always
        phoneNumber.font = UIFont.systemFont(ofSize: 15)
        phoneNumber.alpha = 0.8882

        enterButtonSignUp.translatesAutoresizingMaskIntoConstraints = false
        enterButtonSignUp.setImage(UIImage(systemName: "arrow.right.circle.fill"), for: .normal)
        let config = UIImage.SymbolConfiguration(pointSize: 50)
        enterButtonSignUp.setImage(UIImage(systemName: "arrow.right.circle.fill", withConfiguration: config), for: .normal)
        enterButtonSignUp.tintColor = UIColor(red: 0.00, green: 0.22, blue: 0.40, alpha: 1.00)
        
        haveAnAccount.translatesAutoresizingMaskIntoConstraints = false
        haveAnAccount.text = "Have an account?"
        haveAnAccount.textColor = .systemGray
        haveAnAccount.font = UIFont.systemFont(ofSize: 12)
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        signInButton.setTitleColor(.systemBlue, for: .normal)
        
    }
    
    func layout() {
        
        view.addSubview(backgroundImage)
        view.addSubview(viewArea)
        view.addSubview(signUpLabel)
        viewArea.addSubview(nameTextField)
        viewArea.addSubview(loginTextField)
        viewArea.addSubview(passwordTextField)
        viewArea.addSubview(phoneNumber)
        view.addSubview(enterButtonSignUp)
        viewArea.addSubview(haveAnAccount)
        viewArea.addSubview(signInButton)
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            viewArea.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            viewArea.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
//            viewArea.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
//            viewArea.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -250),
            viewArea.heightAnchor.constraint(equalToConstant: 280),
            viewArea.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewArea.centerYAnchor.constraint(equalTo: view.centerYAnchor),

//            signInLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            signUpLabel.topAnchor.constraint(equalTo: viewArea.topAnchor, constant: -40),
            signUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            nameTextField.topAnchor.constraint(equalTo: viewArea.topAnchor, constant: 30),
            nameTextField.leadingAnchor.constraint(equalTo: viewArea.leadingAnchor, constant: 15),
            nameTextField.centerXAnchor.constraint(equalTo: viewArea.centerXAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: viewArea.trailingAnchor, constant: -15),

            loginTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            loginTextField.leadingAnchor.constraint(equalTo: viewArea.leadingAnchor, constant: 15),
            loginTextField.centerXAnchor.constraint(equalTo: viewArea.centerXAnchor),
            loginTextField.trailingAnchor.constraint(equalTo: viewArea.trailingAnchor, constant: -15),

            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: viewArea.leadingAnchor, constant: 15),
            passwordTextField.centerXAnchor.constraint(equalTo: viewArea.centerXAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: viewArea.trailingAnchor, constant: -15),

            phoneNumber.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            phoneNumber.leadingAnchor.constraint(equalTo: viewArea.leadingAnchor, constant: 15),
            phoneNumber.centerXAnchor.constraint(equalTo: viewArea.centerXAnchor),
            phoneNumber.trailingAnchor.constraint(equalTo: viewArea.trailingAnchor, constant: -15),

            enterButtonSignUp.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterButtonSignUp.topAnchor.constraint(equalTo: viewArea.bottomAnchor, constant: 20),
//            enterButton.heightAnchor.constraint(equalToConstant: 100),
//            enterButton.widthAnchor.constraint(equalToConstant: 100),

            haveAnAccount.topAnchor.constraint(equalTo: phoneNumber.bottomAnchor, constant: 18),
            haveAnAccount.centerXAnchor.constraint(equalTo: viewArea.centerXAnchor),

            signInButton.topAnchor.constraint(equalTo: haveAnAccount.bottomAnchor, constant: 1),
            signInButton.centerXAnchor.constraint(equalTo: viewArea.centerXAnchor)
        ])
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @objc func enterButtonSignUpPressed() {

        enterButtonSignUp.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.enterButtonSignUp.alpha = 1.0
        }

        let defaults = UserDefaults.standard
        if loginTextField.text!.isEmpty || passwordTextField.text!.isEmpty || nameTextField.text!.isEmpty {
            alert.showAlert(with: "Oups!", message: "Need to fill textfields", on: self)
        } else {
            Service.signUpUser(email: loginTextField.text!, password: passwordTextField.text!, name: nameTextField.text!, phoneNumber: phoneNumber.text!) {
                defaults.set(true, forKey: "isUserSignedIn")
                let controller = self.storyboard?.instantiateViewController(withIdentifier: "HomeNC") as! UINavigationController
                controller.modalPresentationStyle = .overFullScreen
                self.present(controller, animated: true, completion: nil)
            } onError: { error in
                self.present(Service.createAlertController(title: "Error", message: error!.localizedDescription), animated: true, completion: nil)
            }
        }
    }

    @objc func signInButtonPressed() {
        signInButton.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.signInButton.alpha = 1.0
        }
        let controller = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! UIViewController
        controller.modalPresentationStyle = .overFullScreen
//        controller.modalTransitionStyle = .flipHorizontal
        present(controller, animated: true, completion: nil)
    }
}
