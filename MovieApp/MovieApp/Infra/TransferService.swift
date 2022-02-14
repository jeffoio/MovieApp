//
//  TransferService.swift
//  MovieApp
//
//  Created by TakHyun Jung on 2022/02/13.
//

import Foundation

enum TransferError: Error {
    case network(NetworkError)
    case decode(Error)
}

protocol Networkable {
    func request(_ urlRequest: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

struct TransferService {
    private let networkService: Networkable

    init(networkService: Networkable) {
        self.networkService = networkService
    }

    func resume<T: Decodable>(endpoint: MovieEndpoint, completion: @escaping (Result<T, TransferError>) -> Void) {
        let request = endpoint.urlRequest()
        self.networkService.request(request) { result in
            switch result {
            case .success(let data):
                let result: Result<T, TransferError> = self.decode(data)
                completion(result)
            case .failure(let error):
                completion(.failure(.network(error)))
            }
        }
    }

    private func decode<T: Decodable>(_ data: Data) -> Result<T, TransferError> {
        do {
            let result: T = try JSONDecoder().decode(T.self, from: data)
            return .success(result)
        } catch {
            return .failure(.decode(error))
        }
    }
}
