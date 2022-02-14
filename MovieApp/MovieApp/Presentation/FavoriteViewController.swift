//
//  FovoriteViewController.swift
//  MovieApp
//
//  Created by TakHyun Jung on 2022/02/12.
//

import UIKit

class FavoriteViewController: UIViewController {
    @IBOutlet private weak var favoriteCollectionView: MovieCollectionView!
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Movie>?
    private let viewModel: FavoriteModel = FavoriteModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind()
        self.configureFavoriteCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.getCurrent()
    }
    
    private func bind() {
        self.viewModel.movies.observe(on: self) { [weak self] movies in
            var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
            snapshot.appendSections([.main])
            snapshot.appendItems(movies)
            self?.dataSource?.apply(snapshot)
        }
    }
    
    private func configureFavoriteCollectionView() {
        self.registerCell()
        self.configureDataSource()
        self.favoriteCollectionView.delegate = self
    }
    
    private func registerCell() {
        self.favoriteCollectionView.register(UINib(nibName: MovieCell.identifer, bundle: nil),
                                             forCellWithReuseIdentifier: MovieCell.identifer)
    }
    
    private func configureDataSource() {
        self.dataSource = UICollectionViewDiffableDataSource<Section, Movie>(collectionView: self.favoriteCollectionView,
                                                                             cellProvider: { collectionView, indexPath, movie in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifer, for: indexPath) as? MovieCell
            cell?.update(movie, buttonAction: { [weak self] _ in
                self?.viewModel.removeFavorite(movie)
            })
            return cell
        })
    }
    
    @IBAction func backButtonTouched(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension FavoriteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailViewController = self.storyboard?.instantiateViewController(identifier: DetailViewController.identifider, creator: { coder in
            return DetailViewController(coder: coder, movie: self.dataSource?.itemIdentifier(for: indexPath))
        }) else {
            fatalError("Failed to load DetailViewController from storyboard.")
        }
        self.present(detailViewController, animated: false, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let movieCell = cell as? MovieCell else { return }
        movieCell.cancel()
    }
}
