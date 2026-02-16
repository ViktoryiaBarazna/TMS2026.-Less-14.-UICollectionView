//
//  FavoritesViewController.swift
//  Less. 14. UICollectionView Homework
//
//  Created by Виктория Дисбаланс on 15.02.26.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    // MARK: - Properties
    var favouritePhotos: [PhotoCellModel] = []
    
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
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
    }
    
    private func setupViewProperties() {
        view.backgroundColor = .systemBackground
        title = "My favourite photos"
    }
    
    private func setupSubviews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FavouritesCell.self, forCellWithReuseIdentifier: FavouritesCell.identifier)
        
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}





// MARK: - UICollectionViewDataSource
extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favouritePhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavouritesCell.identifier, for: indexPath) as! FavouritesCell
        cell.configure(with: favouritePhotos[indexPath.item])
        return cell
    }
}


// MARK: - UICollectionViewDelegateFlowLayout (2 columns)
extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns: CGFloat = 2
        let spacing: CGFloat = 10
        let padding: CGFloat = 10
        
        let totalPadding = padding * 4
        let totalSpacing = (columns - 1) * spacing
        let availableWidth = collectionView.frame.width - totalPadding - totalSpacing
        let width = availableWidth / columns
        let height = width * 1.1

        return CGSize(width: width, height: height)
    }
}
