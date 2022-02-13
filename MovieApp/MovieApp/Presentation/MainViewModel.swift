//
//  MainViewModel.swift
//  MovieApp
//
//  Created by TakHyun Jung on 2022/02/13.
//

import Foundation

protocol MoviesUsecaseInterface {
    func query(_ query: String, completion: @escaping (Result<[Movie], Error>) -> Void)
}

final class MainViewModel {
    private let useCase: MoviesUsecaseInterface
    private(set) var movies: Observable<[Movie]>
    
    init(useCase: MoviesUsecaseInterface) {
        self.useCase = useCase
        self.movies = Observable([])
    }
    
    func query(_ query: String) {
        self.useCase.query(query) { result in
            switch result {
            case .success(let movies):
                self.movies.value = movies
            case .failure(let error):
                print(error)
            }
        }
    }
}
