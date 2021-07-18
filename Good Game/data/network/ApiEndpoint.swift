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
    
    func values() -> String {
        switch self {
            case .games:
                return "games"
            case .genre:
                return "genres"
        }
    }
}
