//
//  MovieRepository.swift
//  MovieApp
//
//  Created by TakHyun Jung on 2022/02/13.
//

import Foundation

final class MovieRepository: MovieRepositoryInterface {
    private let transferService: TransferService
    
    init(transferService: TransferService) {
        self.transferService = transferService
    }
    
    func query(query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        let endpoint = MovieEndpoint(urlParameters: ["query": query, "display": "100"])
        
        self.transferService.resume(endpoint: endpoint) { (result: Result<MovieResponse, TransferError>) in
            switch result {
            case .success(let movieResponse):
                completion(.success(movieResponse.items.map{ $0.toDomain()}))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
