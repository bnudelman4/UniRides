//
//
//  CreateRidePageViewController.swift
//  UniRides
//
//  Created by Arielle Nudelman on 12/7/24.
//

import UIKit

class CreateRidePageViewController: UIViewController {
    // Fields for user input
    let imageTextField = UITextField() // Placeholder for an image picker
    let startLocationTextField = UITextField()
    let endLocationTextField = UITextField()
    let startTimeTextField = UITextField()
    let totalCapacityTextField = UITextField()
    let priceTextField = UITextField()
    let carTypeTextField = UITextField()
    let licensePlateTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        view.backgroundColor = UIColor(red: 162/255, green: 232/255, blue: 241/255, alpha: 1.0)
        setupFields()
        setupSubmitButton()
    
        let backButton = UIButton(type: .system)
        backButton.setTitle("< Back", for: .normal) // Set custom text
        backButton.setTitleColor(.black, for: .normal) // Set text color
        backButton.titleLabel?.font = UIFont(name: "Anybody-Bold", size: 30) // Set font and size
        backButton.addTarget(self, action: #selector(backToRides), for: .touchUpInside)

        // Add the UIButton as a UIBarButtonItem
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    func setupFields() {
        // Create array of fields
        let fields: [(UITextField, String)] = [
            (imageTextField, "Image (URL)"),
            (startLocationTextField, "Start Location"),
            (endLocationTextField, "End Location"),
            (startTimeTextField, "Start Time"),
            (totalCapacityTextField, "Total Capacity"),
            (priceTextField, "Price (USD)"),
            (carTypeTextField, "Type of Car"),
            (licensePlateTextField, "License Plate #")
        ]
        
        var lastField: UITextField? = nil
        
        for (field, placeholder) in fields {
            // Configure each text field
            field.placeholder = placeholder
            field.borderStyle = .roundedRect
            field.layer.borderWidth = 2
            field.layer.cornerRadius = 10
            field.layer.borderColor = UIColor.black.cgColor
            field.attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
            )
            field.font = UIFont(name: "Anybody-Bold", size: 30)
            field.textColor = UIColor.black
            field.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(field)
            
            // Layout constraints
            NSLayoutConstraint.activate([
                field.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                field.widthAnchor.constraint(equalToConstant: 300),
                field.topAnchor.constraint(equalTo: lastField?.bottomAnchor ?? view.safeAreaLayoutGuide.topAnchor, constant: lastField == nil ? 20 : 10)
            ])
            lastField = field
        }
    }
    
    func setupSubmitButton() {
        // Submit Button
        let submitButton = UIButton(type: .system)
        submitButton.setTitle("Sign Up", for: .normal)
        submitButton.titleLabel?.font = UIFont(name: "Anybody-Bold", size: 38)
        submitButton.backgroundColor = UIColor.white
        submitButton.layer.borderWidth = 7
        submitButton.contentEdgeInsets = UIEdgeInsets(top: 20, left: 40, bottom: 20, right: 40)
        submitButton.layer.borderColor = UIColor.black.cgColor
        submitButton.layer.cornerRadius = 39
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.addTarget(self, action: #selector(submitRide), for: .touchUpInside)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(submitButton)
        
        // Layout for the button
        NSLayoutConstraint.activate([
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.topAnchor.constraint(equalTo: licensePlateTextField.bottomAnchor, constant: 30)
        ])
    }
    
    @objc func submitRide() {
        // Get values from text fields
        let image = imageTextField.text ?? ""
        let startLocation = startLocationTextField.text ?? ""
        let endLocation = endLocationTextField.text ?? ""
        let startTime = startTimeTextField.text ?? ""
        let totalCapacity = Int(totalCapacityTextField.text ?? "") ?? 0
        let price = Double(priceTextField.text ?? "") ?? 0.0
        let carType = carTypeTextField.text ?? ""
        let licensePlate = licensePlateTextField.text ?? ""
        
        // Create the ride object
        let ride: [String: Any] = [
            //"name": name,
            "image": image,
            "start_location": startLocation,
            "end_location": endLocation,
            "start_time": startTime,
            "total_capacity": totalCapacity,
            "price": price,
            //"phone_number": phoneNumber,
            //"email": email,
            "car_type": carType,
            "license_plate": licensePlate,
            //"current_riders": [email], // Ride creator's email
            "pending_riders": []    // Empty initially
        ]
        
        // Convert the ride object to JSON and send a POST request
        createRide(ride: ride)
    }
    
    @objc func backToRides() {
        navigationController?.popViewController(animated: false)
    }
        
    func createRide(ride: [String: Any]) {
        guard let url = URL(string: "https://example.com/api/rides") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: ride, options: [])
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error creating ride: \(error.localizedDescription)")
                    return
                }
                
                if let response = response as? HTTPURLResponse, response.statusCode == 201 {
                    print("Ride created successfully!")
                } else {
                    print("Failed to create ride")
                }
            }
            task.resume()
        } catch {
            print("Error encoding ride data: \(error.localizedDescription)")
        }
    }
}


   
