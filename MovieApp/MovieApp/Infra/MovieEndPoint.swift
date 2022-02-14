//
//  MovieEndPoint.swift
//  MovieApp
//
//  Created by TakHyun Jung on 2022/02/13.
//

import Foundation

struct MovieEndpoint {
    private let baseURL = "https://openapi.naver.com/v1/search/movie.json"
    private let headers = ["X-Naver-Client-Id": "\(Secrets.clientID)",
                           "X-Naver-Client-Secret": "\(Secrets.clientSecret)"]
    private let urlParameters: [String: String]

    init(urlParameters: [String: String]) {
        self.urlParameters = urlParameters
    }
    
    func urlRequest() -> URLRequest {
        let url = self.url()!
        var request = URLRequest(url: url)
        headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        return request
    }

    private func url() -> URL? {
        var urlComponents = URLComponents(string: self.baseURL)
        urlComponents?.queryItems = urlParameters.map { URLQueryItem(name: $0.key, value: $0.value)}
        return urlComponents?.url
    }
}
