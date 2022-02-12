//
//  MovieCell.swift
//  MovieApp
//
//  Created by TakHyun Jung on 2022/02/12.
//

import UIKit

class MovieCell: UICollectionViewCell {
    static let identifer = String(describing: MovieCell.self)

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var directorLabel: UILabel!
    @IBOutlet private weak var actorLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!

    override func prepareForReuse() {
        super.prepareForReuse()
        self.favoriteButton.imageView?.image = UIImage(named: "starUnFilled")
    }
}
