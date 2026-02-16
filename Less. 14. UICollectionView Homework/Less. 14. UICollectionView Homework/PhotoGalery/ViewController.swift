//
//  ViewController.swift
//  Less. 14. UICollectionView Homework
//
//  Created by Виктория Дисбаланс on 14.02.26.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Properties
    private var photos: [PhotoCellModel] = [
        PhotoCellModel(image: "1", imageName: "Lake in mountains", creationDate: "01.01.2026"),
        PhotoCellModel(image: "2", imageName: "Another lake in mountains", creationDate: "01.02.2025"),
        PhotoCellModel(image: "3", imageName: "Evening sea", creationDate: "01.03.2024"),
        PhotoCellModel(image: "4", imageName: "Forest", creationDate: "01.04.2023"),
        PhotoCellModel(image: "5", imageName: "Beautiful lake", creationDate: "01.05.2022"),
        PhotoCellModel(image: "6", imageName: "Sunset sea", creationDate: "01.06.2021"),
        PhotoCellModel(image: "7", imageName: "Road", creationDate: "05.02.2026"),
        PhotoCellModel(image: "8", imageName: "Raccon", creationDate: "15.07.2025"),
        PhotoCellModel(image: "9", imageName: "Dark swan", creationDate: "12.12.2024"),
        PhotoCellModel(image: "10", imageName: "Lavender", creationDate: "31.12.2023"),
        PhotoCellModel(image: "11", imageName: "Another lavender", creationDate: "01.07.2015"),
        PhotoCellModel(image: "12", imageName: "Sunset road", creationDate: "11.11.2020"),
        PhotoCellModel(image: "14", imageName: "Some road", creationDate: "11.10.2023"),
        PhotoCellModel(image: "15", imageName: "Some view", creationDate: "02.02.2020"),
        PhotoCellModel(image: "16", imageName: "Beautiful", creationDate: "12.12.2012"),
        PhotoCellModel(image: "17", imageName: "Mom, i am photographer", creationDate: "11.01.2020"),
        PhotoCellModel(image: "18", imageName: "Picture of something", creationDate: "13.01.2010"),
        PhotoCellModel(image: "19", imageName: "Nature", creationDate: "11.11.2020"),
        PhotoCellModel(image: "20", imageName: "Nature again", creationDate: "11.09.2020"),
        PhotoCellModel(image: "21", imageName: "Something blue", creationDate: "11.08.2024"),
        PhotoCellModel(image: "22", imageName: "Wow", creationDate: "11.04.2023"),
        PhotoCellModel(image: "23", imageName: "Trip", creationDate: "11.05.2021"),
        PhotoCellModel(image: "24", imageName: "It is forest", creationDate: "11.01.2022"),
    ]
    
    // MARK: - Subviews
    private let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray6
        return collectionView
    }()
    
    private let watchFavouritesButton = UIButton(type: .system)
    private let addPictureButton = UIButton(type: .system)
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
    }
    
    // MARK: - Layout
    private func setupViewProperties() {
        view.backgroundColor = .systemBackground
        title = "My photo gallery"
    }
    
    private func setupSubviews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)

        watchFavouritesButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        watchFavouritesButton.tintColor = .systemGray3
        watchFavouritesButton.addTarget(self, action: #selector(showFavorites), for: .touchUpInside)
        
        addPictureButton.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        addPictureButton.tintColor = .systemGray3
        addPictureButton.addTarget(self, action: #selector(addPictureButtonTapped), for: .touchUpInside)
        
        [collectionView, watchFavouritesButton, addPictureButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            watchFavouritesButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            watchFavouritesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            addPictureButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            addPictureButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            collectionView.topAnchor.constraint(equalTo: watchFavouritesButton.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Actions
    @objc private func addPictureButtonTapped() {
        let newCellModel = PhotoCellModel(
            image: "13",
            imageName: "New photo \(photos.count + 1)",
            creationDate: "01.01.2026"
        )
        
        photos.append(newCellModel)
        
        let newIndexPath = IndexPath(item: photos.count - 1, section: 0)
        collectionView.insertItems(at: [newIndexPath])
        collectionView.scrollToItem(at: newIndexPath, at: .bottom, animated: true)
    }
    
    
    @objc private func showFavorites() {
        let favPhotos = photos.filter { $0.isFavourite}
        let favoritesVC = FavoritesViewController()
        favoritesVC.favouritePhotos = favPhotos
        navigationController?.pushViewController(favoritesVC, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
    UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as! PhotoCell
        
        let model = photos[indexPath.item]
        cell.configure(with: model)
        
        // Обработка нажатия на лайк
        cell.likeTapped = { [weak self] in
            guard let self = self else { return }
            // Меняем состояние в модели
            self.photos[indexPath.item].isLiked.toggle()
            // Обновляем только кнопку в ячейке, если она видима
            if let visibleCell = collectionView.cellForItem(at: indexPath) as? PhotoCell {
                let updatedModel = self.photos[indexPath.item]
                visibleCell.updateLikeButton(isLiked: updatedModel.isLiked)
            }
        }
        
        // Обработка нажатия на избранное
        cell.favouriteTapped = { [weak self] in
            guard let self = self else { return }
            self.photos[indexPath.item].isFavourite.toggle()
            if let visibleCell = collectionView.cellForItem(at: indexPath) as? PhotoCell {
                let updatedModel = self.photos[indexPath.item]
                visibleCell.updateFavouriteButton(isFavourite: updatedModel.isFavourite)
            }
        }
        return cell
    }
}


// MARK: - UICollectionViewDelegate (пусто, но можно добавить обработку выбора)
extension ViewController: UICollectionViewDelegate {
}



// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns: CGFloat = 3
        let spacing: CGFloat = 10
        let padding: CGFloat = 10
        
        let totalPadding = padding * 4
        let totalSpacing = (columns - 1) * spacing
        let availableWidth = collectionView.frame.width - totalPadding - totalSpacing
        let width = availableWidth / columns
        let height = width * 1.6
        
        return CGSize(width: width, height: height)
    }
}
