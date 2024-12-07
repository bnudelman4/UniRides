//
//  FilterCollectionViewCell.swift
//
import UIKit
import SnapKit
import SDWebImage

class FilterCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    let filterButton = UIButton()

    static let reuse = "FilterCollectionViewCellReuse"

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFilterButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration
    func configure(with title: String, isSelected: Bool) {
        filterButton.setTitle(title, for: .normal)
        filterButton.backgroundColor = isSelected ? UIColor.systemOrange.withAlphaComponent(0.8) : .systemGray6
        filterButton.setTitleColor(isSelected ? .white : .black, for: .normal)
    }

    // MARK: - Setup
    private func setupFilterButton() {
            filterButton.layer.cornerRadius = 16
            filterButton.layer.masksToBounds = true
            filterButton.backgroundColor = .white
            filterButton.setTitleColor(.black, for: .normal)
            filterButton.titleLabel?.font = .systemFont(ofSize: 12, weight: .medium)
            filterButton.isUserInteractionEnabled = false
            contentView.addSubview(filterButton)
            
            filterButton.snp.makeConstraints{ make in
                make.edges.equalToSuperview()
            }
        }
}
