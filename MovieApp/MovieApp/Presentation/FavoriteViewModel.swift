//
//  FavoriteViewModel.swift
//  MovieApp
//
//  Created by TakHyun Jung on 2022/02/14.
//

import Foundation

final class FavoriteModel {
    private(set) var movies: Observable<[Movie]>
    
    init() {
        self.movies = Observable([])
    }
    
    func removeFavorite(_ movie: Movie) {
        FavoriteManager.shared.removeFavorite(movie)
        self.movies.value = FavoriteManager.shared.loadFavorite()
    }
    
    func getCurrent() {
        self.movies.value = FavoriteManager.shared.loadFavorite()
    }
}
