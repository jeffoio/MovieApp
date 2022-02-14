//
//  MovieResponse.swift
//  MovieApp
//
//  Created by TakHyun Jung on 2022/02/13.
//

import Foundation

struct MovieResponse: Codable {
    let lastBuildDate: String
    let total, start, display: Int
    let items: [MovieDTO]
}

struct MovieDTO: Codable {
    let title: String
    let link: String
    let image: String
    let subtitle, pubDate, director, actor: String
    let userRating: String
    
    func toDomain() -> Movie {
        let title = title.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        let directors = self.director.split(separator: "|").map{String($0)}.joined(separator: ", ")
        let actors = self.actor.split(separator: "|").map{String($0)}.joined(separator: ", ")

        return Movie(title: title,
                     thumbnail: self.image,
                     director: directors,
                     actors: actors,
                     rating: userRating,
                     link: link)
    }
}
