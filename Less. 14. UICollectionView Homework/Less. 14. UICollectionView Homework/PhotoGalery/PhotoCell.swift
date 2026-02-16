//
//  PhotoCell.swift
//  Less. 14. UICollectionView Homework
//
//  Created by Виктория Дисбаланс on 14.02.26.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "PhotoCell"
    
    // MARK: - Subviews
    let imageView = UIImageView()
    let imageLabel = UILabel()
    let imageDate = UILabel()
    let likeButton = UIButton()
    let favouriteButton = UIButton()
    
    // MARK: - Closures
    var likeTapped: (() -> Void)?
    var favouriteTapped: (() -> Void)?
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewProperties()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        imageLabel.text = nil
        imageDate.text = nil
        
        // Обнуляем замыкания, чтобы не вызвать устаревшие
        likeTapped = nil
        favouriteTapped = nil
    }
    
    
    // MARK: - Layout
    private func setupViewProperties() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 12
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4
    }
    
    private func setupSubviews() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray4
        
        imageLabel.font = .systemFont(ofSize: 10, weight: .semibold)
        imageLabel.numberOfLines = 2
        imageLabel.textAlignment = .center
        
        imageDate.font = .systemFont(ofSize: 8)
        imageDate.textAlignment = .right
        
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        likeButton.addTarget(self, action: #selector(likePressed), for: .touchUpInside)
        
        favouriteButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        favouriteButton.setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
        favouriteButton.addTarget(self, action: #selector(favouritePressed), for: .touchUpInside)
        
        [imageView, imageLabel, imageDate, likeButton, favouriteButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
                    imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                    imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                    imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                    imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
                    
                    imageDate.topAnchor.constraint(equalTo: imageView.bottomAnchor),
                    imageDate.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
                    imageDate.leadingAnchor.constraint(greaterThanOrEqualTo: imageView.leadingAnchor),
                    
                    imageLabel.topAnchor.constraint(equalTo: imageDate.bottomAnchor, constant: 5),
                    imageLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
                    imageLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
                    
                    likeButton.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
                    likeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                    likeButton.topAnchor.constraint(greaterThanOrEqualTo: imageLabel.bottomAnchor, constant: 10),
                    
                    favouriteButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
                    favouriteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                    favouriteButton.topAnchor.constraint(greaterThanOrEqualTo: imageLabel.bottomAnchor, constant: 10)
        ])
    }

    
    // MARK: - Actions
    @objc private func likePressed() {
        // Переключаем состояние и цвет, затем вызываем замыкание
        likeButton.isSelected.toggle()
        updateLikeColor()
        likeTapped?()
    }
    
    @objc private func favouritePressed() {
        // Переключаем состояние и цвет, затем вызываем замыкание
        favouriteButton.isSelected.toggle()
        updateFavouriteColor()
        favouriteTapped?()
    }
    
    
    // MARK: - Update buttons colour methods
    private func updateLikeColor() {
        likeButton.tintColor = likeButton.isSelected ? .systemRed : .systemGray3
    }
    
    private func updateFavouriteColor() {
        favouriteButton.tintColor = favouriteButton.isSelected ? .systemYellow : .systemGray3
    }
    
    
    
    // MARK: - Configuration
    func configure(with model: PhotoCellModel) {
        imageView.image = UIImage(named: model.image)
        imageLabel.text = model.imageName
        imageDate.text = model.creationDate
        
        // Устанавливаем состояния кнопок согласно модели
        updateLikeButton(isLiked: model.isLiked)
        updateFavouriteButton(isFavourite: model.isFavourite)
    }
    
    // MARK: - Update state like and favourite methods
    func updateLikeButton(isLiked: Bool) {
        likeButton.isSelected = isLiked
        updateLikeColor()
    }
    
    func updateFavouriteButton(isFavourite: Bool) {
        favouriteButton.isSelected = isFavourite
        updateFavouriteColor()
    }
    
    
}
