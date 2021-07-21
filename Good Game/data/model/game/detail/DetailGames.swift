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
    let updated: String?
    let background_image: String
    let rating: Float
    let description_raw: String
    let ratings_count: Int
    let publishers: [Publishers]
    let genres: [Genres]
    let parent_platforms: [ParentPlatform]
    
}

struct ParentPlatform: Codable {
    let platform: Platform
}

struct Publishers: Codable, Identifiable {
    let id: Int
    let name: String
}

struct Platform: Codable, Identifiable {
    let id: Int
    let name: String
}
