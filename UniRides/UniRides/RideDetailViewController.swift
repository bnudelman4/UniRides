//
//  RideDetailViewController.swift

import UIKit
import SDWebImage

protocol RideDetailViewDelegate: AnyObject {
    func didUpdateBookmarks()
}

class RideDetailViewController: UIViewController {
    
    weak var delegate: RideDetailViewDelegate?
    
    // MARK: - Properties
    
    private var ride: Ride
    var email: String?
    private let rideImageView = UIImageView()
    private let rideTitleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    let leaveRideButton = UIButton(type: .system)
    let joinRideButton = UIButton(type: .system)
    let pendingRideButton = UIButton(type: .system)
    let acceptButton = UIButton(type: .system)
    let declineButton = UIButton(type: .system)
    let deleteRideButton = UIButton(type: .system)
    
    // MARK: - Initialization
    
    init(ride: Ride) {
        self.ride = ride
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupCollectionView()
        configure(with: ride)
        setupCustomBackButton()
    }
    
    // MARK: - Configure with Recipe Data
    
    private func configure(with ride: Ride) {
        // Set image using SDWebImage
        if let imageUrl = URL(string: ride.image.url) {
            rideImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
        }
        rideImageView.layer.cornerRadius = 39
        rideImageView.layer.borderWidth = 7
        
        // Set labels
        rideTitleLabel.text = ride.startLocation + "→" + ride.endLocation
        rideTitleLabel.textColor = .black
        rideTitleLabel.font = UIFont(name: "Anybody-Bold", size: 27)
        descriptionLabel.text = "\(ride.startTime) • $\(ride.price) • \(ride.driver.firstName) \(ride.driver.lastName)"
        descriptionLabel.textColor = .black
        descriptionLabel.font = UIFont(name: "Anybody-Bold", size: 20)
        
        leaveRideButton.setTitle("Leave Ride", for: .normal)
        leaveRideButton.titleLabel?.font = UIFont(name: "Anybody-Bold", size: 27)
        leaveRideButton.backgroundColor = UIColor(red: 162/255, green: 232/255, blue: 241/255, alpha: 1.0)
        leaveRideButton.layer.borderWidth = 7
        leaveRideButton.contentEdgeInsets = UIEdgeInsets(top: 20, left: 40, bottom: 20, right: 40)
        leaveRideButton.layer.borderColor = UIColor.black.cgColor
        leaveRideButton.layer.cornerRadius = 39
        leaveRideButton.setTitleColor(.black, for: .normal)
        leaveRideButton.addTarget(self, action: #selector(backToDetailedView), for: .touchUpInside)
        leaveRideButton.translatesAutoresizingMaskIntoConstraints = false
        
        joinRideButton.setTitle("Join Ride", for: .normal)
        joinRideButton.titleLabel?.font = UIFont(name: "Anybody-Bold", size: 27)
        joinRideButton.backgroundColor = UIColor(red: 162/255, green: 232/255, blue: 241/255, alpha: 1.0)
        joinRideButton.layer.borderWidth = 7
        joinRideButton.contentEdgeInsets = UIEdgeInsets(top: 20, left: 40, bottom: 20, right: 40)
        joinRideButton.layer.borderColor = UIColor.black.cgColor
        joinRideButton.layer.cornerRadius = 39
        joinRideButton.setTitleColor(.black, for: .normal)
        joinRideButton.addTarget(self, action: #selector(backToDetailedView), for: .touchUpInside)
        joinRideButton.translatesAutoresizingMaskIntoConstraints = false
        
        pendingRideButton.setTitle("Pending Ride", for: .normal)
        pendingRideButton.titleLabel?.font = UIFont(name: "Anybody-Bold", size: 27)
        pendingRideButton.backgroundColor = UIColor(red: 162/255, green: 232/255, blue: 241/255, alpha: 1.0)
        pendingRideButton.layer.borderWidth = 7
        pendingRideButton.contentEdgeInsets = UIEdgeInsets(top: 20, left: 40, bottom: 20, right: 40)
        pendingRideButton.layer.borderColor = UIColor.black.cgColor
        pendingRideButton.layer.cornerRadius = 39
        pendingRideButton.setTitleColor(.black, for: .normal)
        leaveRideButton.addTarget(self, action: #selector(backToDetailedView), for: .touchUpInside)
        pendingRideButton.translatesAutoresizingMaskIntoConstraints = false
        
        deleteRideButton.setTitle("Delete Ride", for: .normal)
        deleteRideButton.titleLabel?.font = UIFont(name: "Anybody-Bold", size: 27)
        deleteRideButton.backgroundColor = UIColor(red: 162/255, green: 232/255, blue: 241/255, alpha: 1.0)
        deleteRideButton.layer.borderWidth = 7
        deleteRideButton.contentEdgeInsets = UIEdgeInsets(top: 20, left: 40, bottom: 20, right: 40)
        deleteRideButton.layer.borderColor = UIColor.black.cgColor
        deleteRideButton.layer.cornerRadius = 39
        deleteRideButton.setTitleColor(.black, for: .normal)
        leaveRideButton.addTarget(self, action: #selector(backToDetailedView), for: .touchUpInside)
        deleteRideButton.translatesAutoresizingMaskIntoConstraints = false
        
        var isContainedCurrent: Bool = false
        var isContainedPending: Bool = false
        
        for (_, rider) in ride.currentRiders.enumerated() {
            if rider.email == email{
                isContainedCurrent = true
            }
        }
        
        for (_, rider) in ride.pendingRiders.enumerated() {
            if rider.email == email{
                isContainedPending = true
            }
        }
        
        if (ride.currentRiders[0].email != email && isContainedCurrent){
            descriptionLabel.text! += "\n\(ride.driver.phoneNumber) • \(ride.driver.email)\n\(ride.carType) • \(ride.licensePlate)"
            descriptionLabel.text! += "Current Riders:\n"
            for (_, rider) in ride.currentRiders.enumerated() {
                descriptionLabel.text! += "\n\(rider.firstName) \(rider.lastName)"
            }
            view.addSubview(leaveRideButton)
            NSLayoutConstraint.activate([
                leaveRideButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                leaveRideButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            ])
            //ADD LEAVE RIDE BUTTON
        } else if (!isContainedCurrent && !isContainedPending && ride.currentRiders.count < ride.totalCapacity){
            view.addSubview(joinRideButton)
            NSLayoutConstraint.activate([
                joinRideButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                joinRideButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            ])
            //ADD JOIN RIDE BUTTON
        } else if (isContainedPending){
            view.addSubview(pendingRideButton)
            NSLayoutConstraint.activate([
                pendingRideButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                pendingRideButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            ])
            //ADD PENDING RIDE BUTTON
        } else if (ride.currentRiders[0].email == email){
            descriptionLabel.text! += "\n\(ride.driver.phoneNumber) • \(ride.driver.email)\n\(ride.carType) • \(ride.licensePlate)"
            descriptionLabel.text! += "Current Riders:\n"
            for (_, rider) in ride.currentRiders.enumerated() {
                descriptionLabel.text! += "\n\(rider.firstName) \(rider.lastName)"
            }
            descriptionLabel.text! += "Pending Riders:\n"
            for (_, rider) in ride.pendingRiders.enumerated() {
                descriptionLabel.text! += "\n\(rider.firstName) \(rider.lastName)"
                // ADD ACCEPT OR DECLINE BUTTON FOR EACH OF THESE
            }
            view.addSubview(deleteRideButton)
            NSLayoutConstraint.activate([
                deleteRideButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                deleteRideButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            ])
            //ADD DELETE RIDE BUTTON
        }
    }
    
    // MARK: - Setup UI
    
    private func setupCollectionView() {
        // Image View Setup
        rideImageView.contentMode = .scaleAspectFill
        rideImageView.clipsToBounds = true
        rideImageView.layer.cornerRadius = 12
        view.addSubview(rideImageView)
        rideImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(32)
            make.height.equalTo(329)
        }
        
        // Recipe Title Setup
        rideTitleLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        rideTitleLabel.numberOfLines = 0
        rideTitleLabel.textAlignment = .left
        view.addSubview(rideTitleLabel)
        rideTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(rideImageView.snp.bottom).offset(32)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(32)
        }
        
        // Description Label Setup
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .lightGray
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(rideTitleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(32)
        }
        
    }
    
    private func setupCustomBackButton() {
        let backImage = UIImage(systemName: "arrow.left")
        let backButton = UIButton(type: .system)
        backButton.setImage(backImage, for: .normal)
        backButton.tintColor = .black
        backButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        let backBarButtonItem = UIBarButtonItem(customView: backButton)

        navigationItem.leftBarButtonItem = backBarButtonItem
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func backToDetailedView() {
        navigationController?.popViewController(animated: true)
    }
    
}
