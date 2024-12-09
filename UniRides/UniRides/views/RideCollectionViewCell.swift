import UIKit
import SnapKit
import SDWebImage

class RideCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties (view)

    private let carImage = UIImageView()
    private let rideDestination = UILabel()
    private let rideDetails = UILabel()

    static let reuse = "RecipeCollectionViewCellReuse"

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupCarImage()
        setupRideDestination()
        setupRideDetails()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configure

    func configure(ride: Ride) {
        carImage.sd_setImage(with: URL(string: ride.image.url))
        rideDestination.text = "\(ride.startLocation) → \(ride.endLocation)"
        rideDetails.text = "\(ride.startTime) • \(ride.driver.firstName) \(ride.driver.lastName) • $\(ride.price)"
        
    }

    // MARK: - Set Up Views

    private func setupCarImage() {
        carImage.contentMode = .scaleAspectFill
        carImage.clipsToBounds = true
        carImage.layer.cornerRadius = 12

        contentView.addSubview(carImage)
        carImage.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(148)
        }
    }

    private func setupRideDestination() {
        rideDestination.textColor = .black
        rideDestination.font = .systemFont(ofSize: 14, weight: .semibold)
        rideDestination.numberOfLines = 2
        rideDestination.lineBreakMode = .byTruncatingTail
        rideDestination.textAlignment = .left

        contentView.addSubview(rideDestination)
        
        rideDestination.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(carImage.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(0)
        }
    }

    private func setupRideDetails() {
        rideDetails.textColor = .gray
        rideDetails.font = .systemFont(ofSize: 12, weight: .regular)
        rideDetails.numberOfLines = 2
        rideDetails.lineBreakMode = .byTruncatingTail
        rideDestination.textAlignment = .left

        contentView.addSubview(rideDetails)
        rideDetails.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(rideDestination.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(0)
        }
    }
}
