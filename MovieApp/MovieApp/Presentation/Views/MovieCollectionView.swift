//
//  MovieCollectionView.swift
//  MovieApp
//
//  Created by TakHyun Jung on 2022/02/12.
//

import UIKit

class MovieCollectionView: UICollectionView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.collectionViewLayout = configureCollectionViewLayout(headerTapped: false)
    }
    
    func configureCollectionViewLayout(headerTapped: Bool) -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.15))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}
