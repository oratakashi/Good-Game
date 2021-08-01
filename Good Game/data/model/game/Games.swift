//
//  Games.swift
//  Good Game
//
//  Created by oratakashi on 14/07/21.
//

import Foundation

struct Games: Codable, Identifiable {
    let id: Int32
    let name: String
    let released: String?
    let background_image: String?
    let rating: Float
}
