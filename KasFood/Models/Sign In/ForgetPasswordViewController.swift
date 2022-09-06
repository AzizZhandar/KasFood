//
//  ForgetPasswordViewController.swift
//  KasFood
//
//  Created by Aziz Zhandar on 20.08.2022.
//

import UIKit
import Firebase

class ForgetPasswordViewController: UIViewController, UITextFieldDelegate {

    let backgroundImage = UIImageView()
    let forgetLabel = UILabel()
    let emailTextField = UITextField()
    let sendButton = UIButton()
    let backButton = UIButton()
    
    let viewArea = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        
        style()
        layout()
        sendButton.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    func style() {
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.image = UIImage(named: "forget")
        
        forgetLabel.translatesAutoresizingMaskIntoConstraints = false
        forgetLabel.text = "Forget password? Type an email below"
        forgetLabel.font = UIFont.systemFont(ofSize: 20)
        forgetLabel.textAlignment = .center
        forgetLabel.textColor = .systemGray
        forgetLabel.numberOfLines = 0

        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.borderStyle = .roundedRect
        emailTextField.layer.cornerRadius = 10.0
        emailTextField.placeholder = "email"
        emailTextField.clearButtonMode = .always
        emailTextField.font = UIFont.systemFont(ofSize: 15)
        emailTextField.alpha = 0.8882

        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.setTitle("Send", for: .normal)
        sendButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        sendButton.setTitleColor(.systemBackground, for: .normal)
        sendButton.layer.cornerRadius = 10
        sendButton.backgroundColor = UIColor.systemOrange

        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(UIImage(systemName: "arrow.backward.circle.fill"), for: .normal)
        let config = UIImage.SymbolConfiguration(pointSize: 50)
        backButton.setImage(UIImage(systemName: "arrow.backward.circle.fill", withConfiguration: config), for: .normal)
        backButton.tintColor = .systemOrange

        
        viewArea.translatesAutoresizingMaskIntoConstraints = false
        viewArea.backgroundColor = .systemBackground
        viewArea.alpha = 0.85

        viewArea.layer.cornerRadius = 25
        viewArea.dropShadowTwo()

        
    }
    
    func layout() {
        view.addSubview(backgroundImage)
        view.addSubview(viewArea)
        view.addSubview(backButton)
        view.addSubview(forgetLabel)
        viewArea.addSubview(emailTextField)
        viewArea.addSubview(sendButton)
        
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            viewArea.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewArea.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            viewArea.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            viewArea.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            viewArea.heightAnchor.constraint(equalToConstant: 120),
            
            forgetLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            forgetLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            forgetLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            forgetLabel.bottomAnchor.constraint(equalTo: viewArea.topAnchor, constant: -20),
            
            emailTextField.leadingAnchor.constraint(equalTo: viewArea.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: viewArea.trailingAnchor, constant: -20),
            emailTextField.topAnchor.constraint(equalTo: viewArea.topAnchor, constant: 20),
            
            sendButton.bottomAnchor.constraint(equalTo: viewArea.bottomAnchor, constant: -20),
            sendButton.leadingAnchor.constraint(equalTo: viewArea.leadingAnchor, constant: 20),
            sendButton.trailingAnchor.constraint(equalTo: viewArea.trailingAnchor, constant: -20),
                        
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
        ])

    }
    
    @objc func sendButtonPressed() {
        sendButton.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.sendButton.alpha = 1.0
        }
        
        let auth = Auth.auth()
        
        auth.sendPasswordReset(withEmail: emailTextField.text!) { (error) in
            if let error = error {
                let alert = Service.createAlertController(title: "Error", message: error.localizedDescription)
                self.present(alert, animated: true, completion: nil)
                
                return
            }
            
            let alert = Service.createAlertController(title: "Cool", message: "Message to reset your password is sent to your email")
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    @objc func backButtonPressed() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! UIViewController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        present(controller, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
}
