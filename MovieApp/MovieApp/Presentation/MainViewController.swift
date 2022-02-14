//
//  MainViewController.swift
//  MovieApp
//
//  Created by TakHyun Jung on 2022/02/12.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet private weak var seacrhTextField: UITextField!
    @IBOutlet private weak var movieCollectionView: UICollectionView!
    @IBOutlet private weak var noResultLabel: UILabel!
    
    private var viewModel = MainViewModel(useCase: MovieUsecase(repository: MovieRepository(transferService: TransferService(networkService: NetworkAPI()))))
    private var dataSource: UICollectionViewDiffableDataSource<Section, Movie>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind()
        self.configureDelegates()
        self.configureMovieCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.movieCollectionView.reloadData()
    }
    
    private func bind() {
        self.viewModel.movies.observe(on: self) { [weak self] movies in
            var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
            snapshot.appendSections([.main])
            snapshot.appendItems(movies)
            self?.dataSource?.apply(snapshot)
            self?.noResultLabel.isHidden = !movies.isEmpty
        }
    }
    
    private func configureDelegates() {
        self.seacrhTextField.delegate = self
        self.movieCollectionView.delegate = self
    }
    
    private func configureMovieCollectionView() {
        self.registerCell()
        self.configureDataSource()
    }
    
    private func registerCell() {
        self.movieCollectionView.register(UINib(nibName: MovieCell.identifer, bundle: nil),
                                          forCellWithReuseIdentifier: MovieCell.identifer)
    }
    
    private func configureDataSource() {
        self.dataSource = UICollectionViewDiffableDataSource<Section, Movie>(collectionView: self.movieCollectionView,
                                                                             cellProvider: { collectionView, indexPath, movie in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifer, for: indexPath) as? MovieCell
            cell?.update(movie) { [weak self] state in
                self?.viewModel.updateFavorite(movie, state: state)
            }
            return cell
        })
    }
    
    @IBAction func presentFavorite(_ sender: UIButton) {
        guard let favoriteViewController = self.storyboard?.instantiateViewController(identifier: FavoriteViewController.identifider, creator: { coder in
            let viewModel = FavoriteModel()
            return FavoriteViewController(coder: coder, viewModel: viewModel)
        }) else {
            fatalError("Failed to load DetailViewController from storyboard.")
        }
        self.present(favoriteViewController, animated: false, completion: nil)
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let queryString = textField.text else { return true }
        self.movieCollectionView.setContentOffset(.zero, animated: true)
        self.viewModel.query(queryString)
        self.seacrhTextField.resignFirstResponder()
        return true
    }
}

extension MainViewController: UICollectionViewDelegate {
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
