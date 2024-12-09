//
//  LoginPageViewController.swift
//  UniRides
//
//  Created by Arielle Nudelman on 12/6/24.
//
import UIKit

class LoginPageViewController: UIViewController {
    let emailTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 255/255, green: 209/255, blue: 209/255, alpha: 1.0)
        
        self.navigationItem.hidesBackButton = true

        // Create a custom UIButton
        let backButton = UIButton(type: .system)
        backButton.setTitle("< Back", for: .normal) // Set custom text
        backButton.setTitleColor(.black, for: .normal) // Set text color
        backButton.titleLabel?.font = UIFont(name: "Anybody-Bold", size: 30) // Set font and size
        backButton.addTarget(self, action: #selector(backToLanding), for: .touchUpInside)

        // Add the UIButton as a UIBarButtonItem
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        // Email Text Field
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.layer.borderWidth = 2
        emailTextField.layer.cornerRadius = 10
        emailTextField.layer.borderColor = UIColor.black.cgColor
        emailTextField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        emailTextField.font = UIFont(name: "Anybody-Bold", size: 30)
        emailTextField.textColor = UIColor.black
        emailTextField.keyboardType = .emailAddress
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailTextField)
        
        // Password Text Field
        let passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.layer.borderWidth = 2
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        passwordTextField.font = UIFont(name: "Anybody-Bold", size: 30)
        passwordTextField.textColor = UIColor.black
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextField)
        
        // Login Button
        let loginButton = UIButton(type: .system)
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "Anybody-Bold", size: 40)
        loginButton.backgroundColor = UIColor(red: 162/255, green: 232/255, blue: 241/255, alpha: 1.0)
        loginButton.layer.borderWidth = 7
        loginButton.contentEdgeInsets = UIEdgeInsets(top: 20, left: 60, bottom: 20, right: 60)
        loginButton.layer.borderColor = UIColor.black.cgColor
        loginButton.layer.cornerRadius = 39
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        
        // Layout Constraints
        NSLayoutConstraint.activate([
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 220),
            emailTextField.widthAnchor.constraint(equalToConstant: 300),
            
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300),
            
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
        ])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRidesDetail", let destinationVC = segue.destination as? RideDetailViewController {
            destinationVC.email = self.emailTextField.text
        }
    }
    
    @objc func loginTapped() {
        // Add GET request logic to validate user
        let ridesVC = RidesViewController()
        ridesVC.email = self.emailTextField.text
        navigationController?.pushViewController(ridesVC, animated: true)
    }
    
    @objc func backToLanding() {
        navigationController?.popViewController(animated: true)
    }
}
