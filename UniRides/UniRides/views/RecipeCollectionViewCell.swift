import UIKit
import SnapKit
import SDWebImage

class RecipeCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties (view)

    private let recipeImage = UIImageView()
    private let recipeName = UILabel()
    private let recipeRatingDifficulty = UILabel()
    var bookmarkImageView: UIImageView!

    static let reuse = "RecipeCollectionViewCellReuse"

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupRecipeImage()
        setupRecipeName()
        setupRecipeRatingDifficulty()
        setupBookmark()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configure

    func configure(recipe: Recipe) {
        recipeImage.sd_setImage(with: URL(string: recipe.imageUrl))
        recipeName.text = recipe.name
        recipeRatingDifficulty.text = "\(recipe.rating) • \(recipe.difficulty)"
        
        let bookmarked = UserDefaults.standard.array(forKey: "boomarked") as? [String] ?? []
        if bookmarked.contains(recipe.id) {
            bookmarkImageView.image = UIImage(systemName: "bookmark.fill")
            bookmarkImageView.tintColor = UIColor.systemOrange.withAlphaComponent(0.8)
            bookmarkImageView.isHidden = false
        } else {
            bookmarkImageView.isHidden = true
        }
    }

    // MARK: - Set Up Views
    private func setupBookmark(){
        bookmarkImageView = UIImageView()
        bookmarkImageView.contentMode = .scaleAspectFit
               
        contentView.addSubview(bookmarkImageView)
               
        bookmarkImageView.snp.makeConstraints { make in
            make.top.equalTo(recipeName.snp.top).offset(0)
            make.trailing.equalTo(contentView.snp.trailing).offset(0)
            make.width.height.equalTo(24)
        }
        
        bookmarkImageView.image = UIImage(systemName: "bookmark")
    }

    private func setupRecipeImage() {
        recipeImage.contentMode = .scaleAspectFill
        recipeImage.clipsToBounds = true
        recipeImage.layer.cornerRadius = 12

        contentView.addSubview(recipeImage)
        recipeImage.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(148)
        }
    }

    private func setupRecipeName() {
        recipeName.textColor = .black
        recipeName.font = .systemFont(ofSize: 14, weight: .semibold)
        recipeName.numberOfLines = 2
        recipeName.lineBreakMode = .byTruncatingTail
        recipeName.textAlignment = .left

        contentView.addSubview(recipeName)
        
        recipeName.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(recipeImage.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(0)
        }
    }

    private func setupRecipeRatingDifficulty() {
        recipeRatingDifficulty.textColor = .gray
        recipeRatingDifficulty.font = .systemFont(ofSize: 12, weight: .regular)
        recipeRatingDifficulty.numberOfLines = 2
        recipeRatingDifficulty.lineBreakMode = .byTruncatingTail
        recipeName.textAlignment = .left

        contentView.addSubview(recipeRatingDifficulty)
        recipeRatingDifficulty.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(recipeName.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(0)
        }
    }
}
