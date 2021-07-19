//
//  DetailGames.swift
//  Good Game
//
//  Created by oratakashi on 19/07/21.
//

import Foundation

struct DetailGames: Codable {
    let id: Int
    let name: String
    let released: String?
    let background_image: String
    let rating: Float
    let description_raw: String
    let ratings_count: Int
    let publishers: [Publishers]
    let genres: [Genres]
}

struct Publishers: Codable {
    let id: Int
    let name: String
}
