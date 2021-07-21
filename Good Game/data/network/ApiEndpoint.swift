//
//  ApiEndpoint.swift
//  Good Game
//
//  Created by oratakashi on 14/07/21.
//

import Foundation

enum ApiEndpoint{
    case games
    case genre
    case detail(gameId: Int)
    case screenshot(gameId: Int)
    
    func values() -> String {
        switch self {
            case .games:
                return "games"
            case .genre:
                return "genres"
            case let .detail(gameId):
                return "games/\(String(gameId))"
            case let .screenshot(gameId):
                return "games/\(String(gameId))/screenshots"
        }
    }
}
