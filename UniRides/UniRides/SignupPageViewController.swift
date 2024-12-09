//
//  SignupPageViewController.swift
//  UniRides
//
//  Created by Arielle Nudelman on 12/6/24.
//

import UIKit

class SignupPageViewController: UIViewController {
    let firstNameTextField = UITextField()
    let lastNameTextField = UITextField()
    let emailTextField = UITextField()
    let usernameTextField = UITextField()
    let phoneNumberTextField = UITextField()
    let passwordTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 255/255, green: 209/255, blue: 209/255, alpha: 1.0)
        
        self.navigationItem.hidesBackButton = true
        
        // First Name Text Field
        firstNameTextField.placeholder = "First Name"
        firstNameTextField.borderStyle = .roundedRect
        firstNameTextField.layer.borderWidth = 2
        firstNameTextField.layer.cornerRadius = 10
        firstNameTextField.layer.borderColor = UIColor.black.cgColor
        firstNameTextField.attributedPlaceholder = NSAttributedString(
            string: "First Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        firstNameTextField.font = UIFont(name: "Anybody-Bold", size: 30)
        firstNameTextField.textColor = UIColor.black
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(firstNameTextField)
        
        // Last Name Text Field
        lastNameTextField.placeholder = "Last Name"
        lastNameTextField.borderStyle = .roundedRect
        lastNameTextField.layer.borderWidth = 2
        lastNameTextField.layer.cornerRadius = 10
        lastNameTextField.layer.borderColor = UIColor.black.cgColor
        lastNameTextField.attributedPlaceholder = NSAttributedString(
            string: "Last Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        lastNameTextField.font = UIFont(name: "Anybody-Bold", size: 30)
        lastNameTextField.textColor = UIColor.black
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lastNameTextField)

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
        
        // Username Text Field
        usernameTextField.placeholder = "Username"
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.layer.borderWidth = 2
        usernameTextField.layer.cornerRadius = 10
        usernameTextField.layer.borderColor = UIColor.black.cgColor
        usernameTextField.attributedPlaceholder = NSAttributedString(
            string: "Username",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        usernameTextField.font = UIFont(name: "Anybody-Bold", size: 30)
        usernameTextField.textColor = UIColor.black
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(usernameTextField)
        
        // Phone Number Text Field
        phoneNumberTextField.placeholder = "Phone Number"
        phoneNumberTextField.borderStyle = .roundedRect
        phoneNumberTextField.layer.borderWidth = 2
        phoneNumberTextField.layer.cornerRadius = 10
        phoneNumberTextField.layer.borderColor = UIColor.black.cgColor
        phoneNumberTextField.attributedPlaceholder = NSAttributedString(
            string: "Phone Number",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        phoneNumberTextField.font = UIFont(name: "Anybody-Bold", size: 30)
        phoneNumberTextField.textColor = UIColor.black
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(phoneNumberTextField)

        // Password Text Field
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
        
        // Signup Button
        let signupButton = UIButton(type: .system)
        signupButton.setTitle("Sign Up", for: .normal)
        signupButton.titleLabel?.font = UIFont(name: "Anybody-Bold", size: 40)
        signupButton.backgroundColor = UIColor(red: 162/255, green: 232/255, blue: 241/255, alpha: 1.0)
        signupButton.layer.borderWidth = 7
        signupButton.contentEdgeInsets = UIEdgeInsets(top: 20, left: 60, bottom: 20, right: 60)
        signupButton.layer.borderColor = UIColor.black.cgColor
        signupButton.layer.cornerRadius = 39
        signupButton.setTitleColor(.black, for: .normal)
        signupButton.addTarget(self, action: #selector(signupTapped), for: .touchUpInside)
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signupButton)
        self.navigationItem.hidesBackButton = true

        // Create a custom UIButton
        let backButton = UIButton(type: .system)
        backButton.setTitle("< Back", for: .normal) // Set custom text
        backButton.setTitleColor(.black, for: .normal) // Set text color
        backButton.titleLabel?.font = UIFont(name: "Anybody-Bold", size: 30) // Set font and size
        backButton.addTarget(self, action: #selector(backToLanding), for: .touchUpInside)

        // Add the UIButton as a UIBarButtonItem
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        // Layout Constraints
        NSLayoutConstraint.activate([
            firstNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            firstNameTextField.widthAnchor.constraint(equalToConstant: 300),
            lastNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 20),
            lastNameTextField.widthAnchor.constraint(equalToConstant: 300),
            phoneNumberTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phoneNumberTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 20),
            phoneNumberTextField.widthAnchor.constraint(equalToConstant: 300),
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 20),
            usernameTextField.widthAnchor.constraint(equalToConstant: 300),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            emailTextField.widthAnchor.constraint(equalToConstant: 300),
            
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300),
            
            signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signupButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            
        ])
    }
    
    @objc func signupTapped() {
        let ridesVC = RidesViewController()
        ridesVC.email = self.emailTextField.text
        let newUser = User(email: emailTextField.text!, firstName: firstNameTextField.text!, id: abs(UUID().hashValue), lastName: lastNameTextField.text!, phoneNumber: phoneNumberTextField.text!)
        NetworkManager.shared.addToUsers(user: newUser){ [weak self] user in
                    guard let self = self else {return}
                    print("\(user.id) was added")
                }
        navigationController?.pushViewController(ridesVC, animated: true)
    }
    
    @objc func backToLanding() {
        navigationController?.popViewController(animated: true)
    }
}
