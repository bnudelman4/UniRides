//
//  RecipeDetailViewController.swift
//  UniRides
//
//  Created by Arielle Nudelman on 11/25/24.
//

import UIKit
import SDWebImage

protocol RecipeDetailViewDelegate: AnyObject {
    func didUpdateBookmarks()
}

class RecipeDetailViewController: UIViewController {
    
    weak var delegate: RecipeDetailViewDelegate?
    
    // MARK: - Properties
    
    private var recipe: Recipe
    
    private let recipeImageView = UIImageView()
    private let recipeTitleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let bookmarkButton = UIButton(type: .system)
    
    // MARK: - Initialization
    
    init(recipe: Recipe) {
        self.recipe = recipe
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
        configure(with: recipe)
        setupCustomBackButton()
        setupBookmarkButton()
    }
    
    // MARK: - Configure with Recipe Data
    
    private func configure(with recipe: Recipe) {
        // Set image using SDWebImage
        if let imageUrl = URL(string: recipe.imageUrl) {
            recipeImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
        }
        
        // Set labels
        recipeTitleLabel.text = recipe.name
        descriptionLabel.text = recipe.description
        
        let bookmarked = UserDefaults.standard.array(forKey: "boomarked") as? [String] ?? []
        if bookmarked.contains(recipe.id) {
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
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.clipsToBounds = true
        recipeImageView.layer.cornerRadius = 12
        view.addSubview(recipeImageView)
        recipeImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(32)
            make.height.equalTo(329)
        }
        
        // Recipe Title Setup
        recipeTitleLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        recipeTitleLabel.numberOfLines = 0
        recipeTitleLabel.textAlignment = .left
        view.addSubview(recipeTitleLabel)
        recipeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(recipeImageView.snp.bottom).offset(32)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(32)
        }
        
        // Description Label Setup
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .lightGray
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(recipeTitleLabel.snp.bottom).offset(16)
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
        
        if bookmarked.contains(recipe.id) {
            bookmarked.removeAll { id in id == recipe.id }
            let bookmarkImage = UIImage(systemName: "bookmark")
            bookmarkButton.setImage(bookmarkImage, for: .normal)
            bookmarkButton.tintColor = .black
        } else {
            bookmarked.append(recipe.id)
            let bookmarkImage = UIImage(systemName: "bookmark.fill")
            bookmarkButton.setImage(bookmarkImage, for: .normal)
            bookmarkButton.tintColor = .black
        }
        
        UserDefaults.standard.setValue(bookmarked, forKey: "boomarked")
        
        // Notify the delegate
        delegate?.didUpdateBookmarks()
    }
}
