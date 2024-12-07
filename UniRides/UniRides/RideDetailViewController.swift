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
    
    private let rideImageView = UIImageView()
    private let rideTitleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let bookmarkButton = UIButton(type: .system)
    
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
        setupBookmarkButton()
    }
    
    // MARK: - Configure with Recipe Data
    
    private func configure(with ride: Ride) {
        // Set image using SDWebImage
        if let imageUrl = URL(string: ride.imageUrl) {
            rideImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
        }
        
        // Set labels
        rideTitleLabel.text = ride.name
        descriptionLabel.text = ride.description
        
        let bookmarked = UserDefaults.standard.array(forKey: "boomarked") as? [String] ?? []
        if bookmarked.contains(ride.id) {
            let bookmarkImage = UIImage(systemName: "bookmark.fill")
            bookmarkButton.setImage(bookmarkImage, for: .normal)
            bookmarkButton.tintColor = .black
        } else {
            let bookmarkImage = UIImage(systemName: "bookmark")
            bookmarkButton.setImage(bookmarkImage, for: .normal)
            bookmarkButton.tintColor = .black
        }
    }
    
    // MARK: - Setup UI
    
    private func setupBookmarkButton(){
        bookmarkButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right:16)
        bookmarkButton.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)

        let bookmarkBarButtonItem = UIBarButtonItem(customView: bookmarkButton)

        navigationItem.rightBarButtonItem = bookmarkBarButtonItem
    }
    
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
    
    @objc private func bookmarkButtonTapped() {
        var bookmarked = UserDefaults.standard.array(forKey: "boomarked") as? [String] ?? []
        
        if bookmarked.contains(ride.id) {
            bookmarked.removeAll { id in id == ride.id }
            let bookmarkImage = UIImage(systemName: "bookmark")
            bookmarkButton.setImage(bookmarkImage, for: .normal)
            bookmarkButton.tintColor = .black
        } else {
            bookmarked.append(ride.id)
            let bookmarkImage = UIImage(systemName: "bookmark.fill")
            bookmarkButton.setImage(bookmarkImage, for: .normal)
            bookmarkButton.tintColor = .black
        }
        
        UserDefaults.standard.setValue(bookmarked, forKey: "boomarked")
        
        // Notify the delegate
        delegate?.didUpdateBookmarks()
    }
}
