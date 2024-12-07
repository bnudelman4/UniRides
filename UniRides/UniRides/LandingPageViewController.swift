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
        
        // App Name Label
        let appNameLabel = UILabel()
        appNameLabel.text = "UniRides"
        //appNameLabel.font = UIFont.boldSystemFont(ofSize: 36)
        appNameLabel.font = UIFont(name: "Anybody-Regular", size: 48)
        appNameLabel.textAlignment = .center
        appNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(appNameLabel)
        
        // Logo Image
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "app_icon") // Add your logo image to Assets
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)
        
        // Login Button
        let loginButton = UIButton(type: .system)
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        loginButton.addTarget(self, action: #selector(navigateToLogin), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        
        // Signup Button
        let signupButton = UIButton(type: .system)
        signupButton.setTitle("Sign Up", for: .normal)
        signupButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        signupButton.addTarget(self, action: #selector(navigateToSignup), for: .touchUpInside)
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signupButton)
        
        // Layout Constraints
        NSLayoutConstraint.activate([
            appNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            appNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 30),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 150),
            logoImageView.widthAnchor.constraint(equalToConstant: 150),
            
            loginButton.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
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
