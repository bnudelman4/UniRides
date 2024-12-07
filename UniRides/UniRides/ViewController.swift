import UIKit
import SnapKit

extension ViewController: RecipeDetailViewDelegate {
    func didUpdateBookmarks() {
        // Reload the collection view to reflect bookmark changes
        rideCollectionView.reloadData()
    }
}

class ViewController: UIViewController {

    // MARK: - Properties (view)

    private var rideCollectionView: UICollectionView!
    private var filterCollectionView: UICollectionView!
    private let leftTitle = UILabel()
    let topContainerView = UIView()
    private var selectedFilters: Set<String> = []
    private var filteredRides: [Car] = []

    // MARK: - Properties (data)
    let filters = ["All", "My Rides", "Pending Rides", "Joined Rides"]
    
    private var rides : [Car] = []

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        filteredRides = rides
        selectedFilters = ["All"]
        
        setupLeftTitle()
        setupFilterCollectionView()
        setupRideCollectionView()
        
        fetchAllRides()
    }
    
    // MARK: - Networking
    
    @objc private func fetchAllRides(){
        NetworkManager.shared.fetchAllRides { [weak self] (rides: [Car]) in
            guard let self else {return}
            self.rides = rides
            self.filteredRides = rides
            
            DispatchQueue.main.async {
                self.recipeCollectionView.reloadData()
                self.filterCollectionView.reloadData()
            }
        }
    }

    // MARK: - Set Up Views
    
    private func setupLeftTitle() {
//        leftTitle.text = "UniRides"
//        leftTitle.textColor = .black
//        leftTitle.backgroundColor = .blue
//        leftTitle.font = .systemFont(ofSize: 32, weight: .semibold)
//        leftTitle.textAlignment = .left
//
//        view.addSubview(leftTitle)
//        leftTitle.snp.makeConstraints { make in
//            make.leading.equalTo(view.safeAreaLayoutGuide).offset(32)
//            make.top.equalTo(view.safeAreaLayoutGuide)
//        }
//
        // Create a container view with a blue background
        
        topContainerView.backgroundColor = .blue
        view.addSubview(topContainerView)
        topContainerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.snp_topMargin) //change to top of the screen
            make.height.equalTo(80) //change this
        }
            
        // Configure the title label
        leftTitle.text = "UniRides"
        leftTitle.textColor = .black
        leftTitle.font = .systemFont(ofSize: 32, weight: .semibold)
        leftTitle.textAlignment = .left
            
        topContainerView.addSubview(leftTitle)
        leftTitle.snp.makeConstraints { make in
            make.leading.equalTo(topContainerView).offset(32)
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
            make.top.equalTo(topContainerView.snp.bottom).offset(16)
            make.height.equalTo(32)
        }
    }

    private func setupRideCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 8

        rideCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        rideCollectionView.backgroundColor = .white
        rideCollectionView.register(RideCollectionViewCell.self, forCellWithReuseIdentifier: RideCollectionViewCell.reuse)
        rideCollectionView.delegate = self
        rideCollectionView.dataSource = self
        rideCollectionView.alwaysBounceVertical = true
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
        rideCollectionView.collectionViewLayout = layout

        view.addSubview(recipeCollectionView)
        rideCollectionView.snp.makeConstraints { make in
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
        filterRides()
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

            filterRides()
            
            filterCollectionView.reloadData()
            recipeCollectionView.reloadData()
        }
        
        if collectionView == rideCollectionView {
            let selectedRide = filteredRides[indexPath.row]
            let detailVC = RecipeDetailViewController(recipe: selectedRide)
            
            navigationController?.pushViewController(detailVC, animated: true)
            detailVC.delegate = self
            
            filterCollectionView.reloadData()
            rideCollectionView.reloadData()
        }
    }

    private func filterRides() {
        // If "All" is selected, show all recipes
        if selectedFilters.contains("All") {
            filteredRides = rides
        } else {
            // Otherwise, filter recipes based on selected difficulties
            filteredRides = rides.filter { ride in
                selectedFilters.contains(ride.difficulty)
            }
        }
        rideCollectionView.reloadData()
    }
}

// MARK: - UICollectionView DataSource

extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == rideCollectionView {
            return filteredRides.count
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RideCollectionViewCell.reuse, for: indexPath) as! RideCollectionViewCell
            let ride = filteredRides[indexPath.row]
            cell.configure(ride: ride)
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




