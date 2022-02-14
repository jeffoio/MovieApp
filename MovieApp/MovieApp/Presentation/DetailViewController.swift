//
//  DetailViewController.swift
//  MovieApp
//
//  Created by TakHyun Jung on 2022/02/12.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    static let identifider = String(describing: DetailViewController.self)
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var directorLabel: UILabel!
    @IBOutlet private weak var actorLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    private let movie: Movie?
    
    init?(coder: NSCoder, movie: Movie?) {
        self.movie = movie
        super.init(coder: coder)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateDetail()
    }
    
    private func updateDetail() {
        guard let movie = movie, let url = URL(string: movie.link) else { return }
        self.titleLabel.text = movie.title
        self.directorLabel.text = movie.director
        self.actorLabel.text = movie.actors
        self.ratingLabel.text = movie.rating
        self.webView.load(URLRequest(url: url))
        self.favoriteButton.setImage(FavoriteManager.shared.isFavorite(movie) ? UIImage(named: "starFilled") : UIImage(named: "starUnfilled"),
                                     for: .normal)
        
        ImageDownloadManager.shared.load(urlString: movie.thumbnail) { data in
            DispatchQueue.main.async { [weak self] in
                self?.thumbnailImageView.image = UIImage(data: data)
            }
        }
    }
    
    @IBAction func backButtonTouched(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func favoriteButtonTouched(_ sender: UIButton) {
        guard let movie = movie else { return }
        let currentState = FavoriteManager.shared.isFavorite(movie)
        self.favoriteButton.setImage(!currentState ? UIImage(named: "starFilled") : UIImage(named: "starUnfilled"),
                                     for: .normal)
        FavoriteManager.shared.updateFavorite(movie, state: !currentState)
    }
}
