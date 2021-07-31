//
//  Favorite.swift
//  Good Game
//
//  Created by oratakashi on 31/07/21.
//

import Foundation

enum Fav{
    case id
    case name
    case released
    case background_image
    case rating
    
    func values() -> String {
        switch self {
            case .id:
                return "id"
            case .name:
                return "name"
            case .released:
                return "released"
            case .background_image:
                return "background_image"
            case .rating:
                return "rating"
        }
    }
}
