//
//  FavoriteViewModel.swift
//  Good Game
//
//  Created by oratakashi on 31/07/21.
//

import Foundation

class FavoriteViewModel: ViewModel {
    @Published var favorite: [Games] = []
    
    func getFavorite() {
        db.getAll { data in
            DispatchQueue.main.async {
                self.favorite = data
            }
        }
    }
    
    func removeAll() {
        db.deleteAll {
            self.getFavorite()
        }
    }
}
