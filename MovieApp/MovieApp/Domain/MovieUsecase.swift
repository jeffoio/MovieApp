//
//  MovieUsecase.swift
//  MovieApp
//
//  Created by TakHyun Jung on 2022/02/13.
//

import Foundation

protocol MovieRepositoryInterface {
    func query(query: String, completion: @escaping (Result<[Movie], Error>) -> Void)
}

final class MovieUsecase: MoviesUsecaseInterface {
    private let repository: MovieRepositoryInterface
    
    init(repository: MovieRepositoryInterface) {
        self.repository = repository
    }
    
    func query(_ query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard !query.isEmpty else {
            completion(.success([]))
            return
        }
        self.repository.query(query: query) { result in
            switch result {
            case .success(let movies):
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
