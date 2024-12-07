import UIKit
import SnapKit

extension ViewController: RecipeDetailViewDelegate {
    func didUpdateBookmarks() {
        // Reload the collection view to reflect bookmark changes
        recipeCollectionView.reloadData()
    }
}

class ViewController: UIViewController {

    // MARK: - Properties (view)

    private var recipeCollectionView: UICollectionView!
    private var filterCollectionView: UICollectionView!
    private let leftTitle = UILabel()
    private var selectedFilters: Set<String> = []
    private var filteredRecipes: [Recipe] = []

    // MARK: - Properties (data)
    let filters = ["All", "Beginner", "Intermediate", "Advanced"]
    
    private var recipes : [Recipe] = []

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        filteredRecipes = recipes
        selectedFilters = ["All"]
        
        setupLeftTitle()
        setupFilterCollectionView()
        setupRecipeCollectionView()
        
        fetchAllRecipes()
    }
    
    // MARK: - Networking
    
    @objc private func fetchAllRecipes(){
        NetworkManager.shared.fetchAllRecipes { [weak self] recipes in
            guard let self else {return}
            self.recipes = recipes
            self.filteredRecipes = recipes
            
            DispatchQueue.main.async {
                self.recipeCollectionView.reloadData()
                self.filterCollectionView.reloadData()
            }
        }
    }

    // MARK: - Set Up Views
    
    private func setupLeftTitle() {
        leftTitle.text = "ChefOS"
        leftTitle.textColor = .black
        leftTitle.font = .systemFont(ofSize: 32, weight: .semibold)
        leftTitle.textAlignment = .left

        view.addSubview(leftTitle)
        leftTitle.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(32)
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupFilterCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12

        filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        filterCollectionView.backgroundColor = .white
        filterCollectionView.showsHorizontalScrollIndicator = false
        filterCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.reuse)
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        filterCollectionView.alwaysBounceHorizontal = true
        
        filterCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 64)
        
        view.addSubview(filterCollectionView)
        filterCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).offset(32)
            make.top.equalTo(leftTitle.snp.bottom).offset(16)
            make.height.equalTo(32)
        }
    }

    private func setupRecipeCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 8

        recipeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        recipeCollectionView.backgroundColor = .white
        recipeCollectionView.register(RecipeCollectionViewCell.self, forCellWithReuseIdentifier: RecipeCollectionViewCell.reuse)
        recipeCollectionView.delegate = self
        recipeCollectionView.dataSource = self
        recipeCollectionView.alwaysBounceVertical = true
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
        recipeCollectionView.collectionViewLayout = layout

        view.addSubview(recipeCollectionView)
        recipeCollectionView.snp.makeConstraints { make in
            make.top.equalTo(filterCollectionView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
    }
    
    @objc private func filterButtonTapped(_ sender: UIButton) {
        let selectedFilter = filters[sender.tag]

        if selectedFilters.contains(selectedFilter) {
            selectedFilters.remove(selectedFilter)
        } else {
            selectedFilters.insert(selectedFilter)
        }

        filterCollectionView.reloadData()
        filterRecipes()
    }
}

// MARK: - UICollectionView Delegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == filterCollectionView {
            let selectedFilter = filters[indexPath.row]

            // If "All" is tapped, toggle it and reset the filters
            if selectedFilter == "All" {
                if selectedFilters.contains("All") {
                    // If "All" is already selected, deselect everything else
                    selectedFilters.removeAll()
                } else {
                    // If it's not selected, select it and deselect all other filters
                    selectedFilters = ["All"]
                }
            } else {
                // If a filter other than "All" is selected, deselect "All"
                if selectedFilters.contains("All") {
                    selectedFilters.remove("All")
                }

                // Toggle the specific filter
                if selectedFilters.contains(selectedFilter) {
                    selectedFilters.remove(selectedFilter)
                } else {
                    selectedFilters.insert(selectedFilter)
                }
            }

            filterRecipes()
            
            filterCollectionView.reloadData()
            recipeCollectionView.reloadData()
        }
        
        if collectionView == recipeCollectionView {
            let selectedRecipe = filteredRecipes[indexPath.row]
            let detailVC = RecipeDetailViewController(recipe: selectedRecipe)
            
            navigationController?.pushViewController(detailVC, animated: true)
            detailVC.delegate = self
            
            filterCollectionView.reloadData()
            recipeCollectionView.reloadData()
        }
    }

    private func filterRecipes() {
        // If "All" is selected, show all recipes
        if selectedFilters.contains("All") {
            filteredRecipes = recipes
        } else {
            // Otherwise, filter recipes based on selected difficulties
            filteredRecipes = recipes.filter { recipe in
                selectedFilters.contains(recipe.difficulty)
            }
        }
        recipeCollectionView.reloadData()
    }
}

// MARK: - UICollectionView DataSource

extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == recipeCollectionView {
            return filteredRecipes.count
        }
        return filters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == filterCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.reuse, for: indexPath) as! FilterCollectionViewCell
            let filter = filters[indexPath.row]

            // Check if the filter is selected
            let isSelected = selectedFilters.contains(filter)
            cell.configure(with: filter, isSelected: isSelected)

            return cell
        } else if collectionView == recipeCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCollectionViewCell.reuse, for: indexPath) as! RecipeCollectionViewCell
            let recipe = filteredRecipes[indexPath.row]
            cell.configure(recipe: recipe)
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == filterCollectionView {
            let filter = filters[indexPath.row]
                    
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
            label.text = filter
            label.sizeToFit()
                    
            let width = label.frame.width + 48
            let height: CGFloat = 32
                    
            return CGSize(width: width, height: height)
            
        } else {
            let size = (collectionView.frame.width - 104) / 2
            return CGSize(width: size, height: 216)
        }
    }
}




