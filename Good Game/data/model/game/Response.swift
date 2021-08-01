//
//  Response.swift
//  Good Game
//
//  Created by oratakashi on 14/07/21.
//

import Foundation

struct Response: Codable {
    let next: String?
    let results: [Games]
}
