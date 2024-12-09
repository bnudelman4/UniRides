import UIKit
import SnapKit

extension RidesViewController: RideDetailViewDelegate {
    func didUpdateBookmarks() {
        // Reload the collection view to reflect bookmark changes
        rideCollectionView.reloadData()
    }
}

class RidesViewController: UIViewController {
    

    // MARK: - Properties (view)
    var email: String?
    private var rideCollectionView: UICollectionView!
    private var filterCollectionView: UICollectionView!
    private let leftTitle = UILabel()
    let topContainerView = UIView()
    let addRideButton = UIButton()
    private var selectedFilters: Set<String> = []
    private var filteredRides: [Ride] = []

    // MARK: - Properties (data)
    let filters = ["All", "My Rides", "Pending Rides", "Joined Rides"]
    
    private var rides : [Ride] = [Ride(id: 1, startLocation: "Cornell University", endLocation: "NYC Penn Station", startTime: "2024-12-30 00:00:00", totalCapacity: 4, spacesLeft: 3, price: 27.50, carType: "Toyota Camry", licensePlate: "ABC123", image: Img(timeCreated: "2024-12-07 00:42:07.563125", id: 1, url: "https://hips.hearstapps.com/hmg-prod/images/2024-toyota-camry-102-64cbc4858e198.jpg?crop=0.544xw:0.461xh;0.293xw,0.234xh&resize=1200:*"), driver: User(email: "zcr5@cornell.edu", firstName: "Long", id: 1, lastName: "Wong", phoneNumber: "727-420-6090"), currentRiders: [User(email: "zcr5@cornell.edu", firstName: "Long", id: 1, lastName: "Wong", phoneNumber: "727-420-6090")], pendingRiders: []),Ride(id: 1, startLocation: "Cornell University", endLocation: "New Jersey Port Authority", startTime: "2024-12-30 00:00:00", totalCapacity: 4, spacesLeft: 3, price: 25.5, carType: "Bugatti Veyron", licensePlate: "ABC123", image: Img(timeCreated: "2024-12-07 00:42:07.563125", id: 1, url: "https://images.squarespace-cdn.com/content/v1/5caed8960cf57d49530e8c60/1726681197589-KBSR99Z4DO6V1TIE3OCU/01.jpg"), driver: User(email: "edhfd@gvjv", firstName: "Long", id: 1, lastName: "Wong", phoneNumber: "727-420-6090"), currentRiders: [User(email: "edhfd@gvjv", firstName: "Long", id: 1, lastName: "Wong", phoneNumber: "727-420-6090")], pendingRiders: []),Ride(id: 1, startLocation: "Cornell University", endLocation: "Washington Bridge Bus Terminal", startTime: "2024-12-30 00:00:00", totalCapacity: 4, spacesLeft: 3, price: 25.5, carType: "Honda Civic", licensePlate: "ABC123", image: Img(timeCreated: "2024-12-07 00:42:07.563125", id: 1, url: "https://i.kinja-img.com/image/upload/c_fill,h_675,pg_1,q_80,w_1200/af14869bd108d2bc5592931bc4f7d4d9.jpg"), driver: User(email: "edhfd@gvjv", firstName: "Long", id: 1, lastName: "Wong", phoneNumber: "727-420-6090"), currentRiders: [User(email: "edhfd@gvjv", firstName: "Long", id: 1, lastName: "Wong", phoneNumber: "727-420-6090")], pendingRiders: []),Ride(id: 1, startLocation: "Cornell University", endLocation: "Toronto Pearson International Airport", startTime: "2024-12-30 00:00:00", totalCapacity: 4, spacesLeft: 3, price: 25.5, carType: "Mercedes C300", licensePlate: "ABC123", image: Img(timeCreated: "2024-12-07 00:42:07.563125", id: 1, url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWtyoKr8-EgU3I8xH4GlEJiPOqPszxHJLWcw&s"), driver: User(email: "edhfd@gvjv", firstName: "Long", id: 1, lastName: "Wong", phoneNumber: "727-420-6090"), currentRiders: [User(email: "edhfd@gvjv", firstName: "Long", id: 1, lastName: "Wong", phoneNumber: "727-420-6090")], pendingRiders: []),Ride(id: 1, startLocation: "Cornell University", endLocation: "Miami Trump Towers", startTime: "2024-12-30 00:00:00", totalCapacity: 4, spacesLeft: 3, price: 25.5, carType: "BMW M4", licensePlate: "ABC123", image: Img(timeCreated: "2024-12-07 00:42:07.563125", id: 1, url: "https://images.prismic.io/exclusiveresorts/521030be-64d1-4525-a2d0-1fbab564218f_BMW+M4+001_ut2z6l-FullBleed_2880x1620.jpg?auto=compress,format&w=2560&q=70"), driver: User(email: "edhfd@gvjv", firstName: "Long", id: 1, lastName: "Wong", phoneNumber: "727-420-6090"), currentRiders: [User(email: "edhfd@gvjv", firstName: "Long", id: 1, lastName: "Wong", phoneNumber: "727-420-6090")], pendingRiders: []),Ride(id: 1, startLocation: "Cornell University", endLocation: "NYC Penn Station", startTime: "2024-12-30 00:00:00", totalCapacity: 4, spacesLeft: 3, price: 25.5, carType: "Mazda CX5", licensePlate: "ABC123", image: Img(timeCreated: "2024-12-07 00:42:07.563125", id: 1, url: "https://live.staticflickr.com/795/40544968005_6451dd1d96.jpg"), driver: User(email: "edhfd@gvjv", firstName: "Long", id: 1, lastName: "Wong", phoneNumber: "727-420-6090"), currentRiders: [User(email: "edhfd@gvjv", firstName: "Long", id: 1, lastName: "Wong", phoneNumber: "727-420-6090")], pendingRiders: []),Ride(id: 1, startLocation: "Cornell University", endLocation: "NYC Penn Station", startTime: "2024-12-30 00:00:00", totalCapacity: 4, spacesLeft: 3, price: 25.5, carType: "Aston Martin Valhalla", licensePlate: "ABC123", image: Img(timeCreated: "2024-12-07 00:42:07.563125", id: 1, url: "https://hips.hearstapps.com/hmg-prod/images/aston-martin-valhalla-101-1626200852.jpg"), driver: User(email: "edhfd@gvjv", firstName: "Long", id: 1, lastName: "Wong", phoneNumber: "727-420-6090"), currentRiders: [User(email: "edhfd@gvjv", firstName: "Long", id: 1, lastName: "Wong", phoneNumber: "727-420-6090")], pendingRiders: [])]

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        view.backgroundColor = .white
        filteredRides = rides
        selectedFilters = ["All"]
        
        setupLeftTitle()
        setupAddRideButton()
        setupFilterCollectionView()
        setupRideCollectionView()
//        fetchAllRides()
    }
    
    // MARK: - Networking
    
    @objc private func fetchAllRides(){
        NetworkManager.shared.fetchAllRides { [weak self] (rides: [Ride]) in
            guard let self else {return}
            self.rides = rides
            self.filteredRides = rides
            
            DispatchQueue.main.async {
                self.rideCollectionView.reloadData()
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
        
        topContainerView.backgroundColor = UIColor(red: 162.0/255, green: 232.0/255, blue: 241.0/255, alpha: 1)
        view.addSubview(topContainerView)
        topContainerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.snp.top) //change to top of the screen
            make.height.equalTo(120) //change this
        }
            
        // Configure the title label
        leftTitle.text = "UniRides"
        leftTitle.textColor = .black
        leftTitle.font = UIFont(name: "Anybody-SemiBold", size: 32)
        leftTitle.translatesAutoresizingMaskIntoConstraints = false
        leftTitle.textAlignment = .left
        topContainerView.addSubview(leftTitle)
        view.sendSubviewToBack(topContainerView)
        print(topContainerView.frame)
        leftTitle.snp.makeConstraints { make in
            make.leading.equalTo(topContainerView).offset(32)
            make.top.equalTo(topContainerView).offset(70)
        }

    }
    
    private func setupAddRideButton() {
        addRideButton.layer.cornerRadius = 16
        addRideButton.layer.masksToBounds = true
        addRideButton.backgroundColor = .white
        addRideButton.setTitleColor(.black, for: .normal)
        addRideButton.setTitle("+" , for: .normal)
        addRideButton.addTarget(self, action: #selector(navigateToCreateRide), for: .touchUpInside)
        addRideButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addRideButton)
        //view.layoutIfNeeded()
//        print(addRideButton.frame)
        //print(addRideButton.frame)
//        addRideButton.snp.makeConstraints{ make in
//            make.top.equalTo(topContainerView).offset(70)
//            make.trailing.equalTo(topContainerView).offset(-30)
//            make.width.equalTo(32)
//            make.height.equalTo(32)
//        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addRideButton)
    }
    
    @objc func navigateToCreateRide() {
        let addRideVC = CreateRidePageViewController()
        print("button tapped")
        navigationController?.pushViewController(addRideVC, animated: false)
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

        view.addSubview(rideCollectionView)
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
//        filterRides()
    }
}

// MARK: - UICollectionView Delegate
extension RidesViewController: UICollectionViewDelegate {
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

//            filterRides()
            
            filterCollectionView.reloadData()
            rideCollectionView.reloadData()
        }
        
        if collectionView == rideCollectionView {
            let selectedRide = filteredRides[indexPath.row]
            let detailVC = RideDetailViewController(ride: selectedRide)
            detailVC.email = self.email
            
            navigationController?.pushViewController(detailVC, animated: true)
            detailVC.delegate = self
            
            filterCollectionView.reloadData()
            rideCollectionView.reloadData()
        }
    }

//    private func filterRides() {
//        // If "All" is selected, show all recipes
//        if selectedFilters.contains("All") {
//            filteredRides = rides
//        } else {
//            // Otherwise, filter recipes based on selected difficulties
//            filteredRides = rides.filter { ride in
//                selectedFilters.contains(ride.emailAddress)
//            }
//        }
//        rideCollectionView.reloadData()
//    }
}

// MARK: - UICollectionView DataSource

extension RidesViewController: UICollectionViewDataSource {

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
        } else if collectionView == rideCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RideCollectionViewCell.reuse, for: indexPath) as! RideCollectionViewCell
            let ride = filteredRides[indexPath.row]
            cell.configure(ride: ride)
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension RidesViewController: UICollectionViewDelegateFlowLayout {

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




