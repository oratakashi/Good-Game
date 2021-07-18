//
//  Genres.swift
//  Good Game
//
//  Created by oratakashi on 17/07/21.
//

import Foundation

struct Genres: Codable, Identifiable {
    let id: Int
    let name: String
    let slug: String
    let gameCount: Int
    let images: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case slug
        case gameCount = "games_count"
        case images = "image_background"
    }
}
