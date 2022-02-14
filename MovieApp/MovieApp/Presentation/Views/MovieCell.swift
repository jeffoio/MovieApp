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
    
    private var task: ImageCancelable?
    private var favoriteButtonAction: ((Bool) -> ())?
    private var favoriteState: Bool
    
    required init?(coder: NSCoder) {
        self.favoriteState = false
        super.init(coder: coder)
    }
    
    func update(_ movie: Movie ,buttonAction: @escaping (Bool) -> ()) {
        self.titleLabel.text = movie.title
        self.directorLabel.text = movie.director
        self.actorLabel.text = movie.actors
        self.ratingLabel.text = movie.rating
        self.task = ImageDownloadManager.shared.load(urlString: movie.thumbnail) { data in
            DispatchQueue.main.async { [weak self] in
                self?.thumbnailImageView.image = UIImage(data: data)
            }
        }
        self.favoriteState = FavoriteManager.shared.isFavorite(movie)
        self.favoriteButtonAction = buttonAction
        self.favoriteButton.setImage(self.favoriteState ? UIImage(named: "starFilled") : UIImage(named: "starUnfilled"),
                                     for: .normal)
    }
    
    func cancel() {
        self.task?.downloadCancel()
    }
    
    @IBAction func favoriteButtonTouched(_ sender: UIButton) {
        self.favoriteState = !self.favoriteState
        self.favoriteButtonAction?(self.favoriteState)
        self.favoriteButton.setImage(self.favoriteState ? UIImage(named: "starFilled") : UIImage(named: "starUnfilled"),
                                     for: .normal)
    }
}
