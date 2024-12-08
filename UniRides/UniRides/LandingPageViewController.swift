//
//  LandingPageViewController.swift
//  UniRides
//
//  Created by Arielle Nudelman on 12/6/24.
//

import UIKit

class LandingPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Background
        view.backgroundColor = UIColor.systemBackground
        let backgroundImage = UIImage(named: "background")
        let backgroundView = UIImageView(frame: self.view.bounds)  // Create an image view with the same size as the view
        backgroundView.image = backgroundImage  // Set the image
        backgroundView.contentMode = .scaleAspectFill  // Scale the image to fill the view
        backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]  // Ensure the image resizes with the view
        view.addSubview(backgroundView)
        view.sendSubviewToBack(backgroundView)
        
        // Rectangle background view
        let rectangleView = UIView()
        rectangleView.translatesAutoresizingMaskIntoConstraints = false
        rectangleView.backgroundColor = UIColor(red: 162/255, green: 232/255, blue: 241/255, alpha: 1.0) // Light blue color
        rectangleView.layer.cornerRadius = 39 // Rounded corners
        rectangleView.layer.borderWidth = 7 // Optional border
        rectangleView.layer.borderColor = UIColor.black.cgColor // Black border
        rectangleView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rectangleView)
            
        
        // App Name Label
        let appNameLabel = UILabel()
        appNameLabel.text = "UniRides"
        //appNameLabel.font = UIFont.boldSystemFont(ofSize: 36)
        appNameLabel.font = UIFont(name: "Anybody-Bold", size: 48)
        appNameLabel.textAlignment = .center
        appNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(appNameLabel)
        
        // Logo Image
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "app_icon") // Add your logo image to Assets
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.layer.cornerRadius = 25 // Rounded corners
        logoImageView.layer.borderWidth = 5 // Optional border
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)
        
        // Login Button
        let loginButton = UIButton(type: .system)
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "Anybody-Bold", size: 48)
        loginButton.backgroundColor = UIColor(red: 162/255, green: 232/255, blue: 241/255, alpha: 1.0)
        loginButton.layer.borderWidth = 7
        loginButton.contentEdgeInsets = UIEdgeInsets(top: 20, left: 60, bottom: 20, right: 60)
        loginButton.layer.borderColor = UIColor.black.cgColor
        loginButton.layer.cornerRadius = 39
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.addTarget(self, action: #selector(navigateToLogin), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        
        // Signup Button
        let signupButton = UIButton(type: .system)
        signupButton.setTitle("Sign Up", for: .normal)
        signupButton.titleLabel?.font = UIFont(name: "Anybody-Bold", size: 48)
        signupButton.backgroundColor = UIColor(red: 162/255, green: 232/255, blue: 241/255, alpha: 1.0)
        signupButton.contentEdgeInsets = UIEdgeInsets(top: 20, left: 60, bottom: 20, right: 60)
        signupButton.layer.borderWidth = 7
        signupButton.layer.cornerRadius = 39
        signupButton.layer.borderColor = UIColor.black.cgColor
        signupButton.setTitleColor(.black, for: .normal)
        signupButton.addTarget(self, action: #selector(navigateToSignup), for: .touchUpInside)
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signupButton)
        
        // Layout Constraints
        NSLayoutConstraint.activate([
            rectangleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            rectangleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rectangleView.heightAnchor.constraint(equalToConstant: 300),
            rectangleView.widthAnchor.constraint(equalToConstant: 300),
            appNameLabel.topAnchor.constraint(equalTo: rectangleView.topAnchor, constant: 20),
            appNameLabel.centerXAnchor.constraint(equalTo: rectangleView.centerXAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 10),
            logoImageView.centerXAnchor.constraint(equalTo: rectangleView.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 185),
            logoImageView.widthAnchor.constraint(equalToConstant: 185),
            
            loginButton.topAnchor.constraint(equalTo: rectangleView.bottomAnchor, constant: 50),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func navigateToLogin() {
        let loginVC = LoginPageViewController()
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @objc func navigateToSignup() {
        let signupVC = SignupPageViewController()
        navigationController?.pushViewController(signupVC, animated: true)
    }
}
