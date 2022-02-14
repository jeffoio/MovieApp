//
//  FavoriteManager.swift
//  MovieApp
//
//  Created by TakHyun Jung on 2022/02/14.
//

import Foundation

final class FavoriteManager {
    static let shared = FavoriteManager()
    private let key = "favorite"
    
    private init() { }
    
    func isFavorite(_ movie: Movie) -> Bool {
        let savedMovies = self.loadFavorite()
        return savedMovies.contains(movie)
    }
    
    func loadFavorite() -> [Movie] {
        guard let encoded = UserDefaults.standard.array(forKey: self.key) as? [Data] else { return [] }
        return encoded.map{ try! JSONDecoder().decode(Movie.self, from: $0)}
    }
    
    func updateFavorite(_ movie: Movie, state: Bool) {
        if state {
            self.saveFavorite(movie)
        } else {
            self.removeFavorite(movie)
        }
    }
    
    func saveFavorite(_ movie: Movie) {
        let savedMovies = self.loadFavorite() + [movie]
        let data = savedMovies.map { try? JSONEncoder().encode($0) }
        UserDefaults.standard.set(data, forKey: self.key)
    }
    
    func removeFavorite(_ movie: Movie) {
        let savedMovies = self.loadFavorite().filter { $0 != movie }
        let data = savedMovies.map { try? JSONEncoder().encode($0) }
        UserDefaults.standard.set(data, forKey: self.key)
    }
}
