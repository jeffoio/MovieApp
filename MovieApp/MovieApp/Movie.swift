//
//  Movie.swift
//  MovieApp
//
//  Created by TakHyun Jung on 2022/02/13.
//

import Foundation

struct Movie: Hashable {
    let title: String
    let thumbnail: String
    let director: String
    let actors: [String]
    let rating: String
}
