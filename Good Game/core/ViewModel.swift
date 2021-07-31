//
//  ViewModel.swift
//  Good Game
//
//  Created by oratakashi on 14/07/21.
//

import Foundation

class ViewModel: ObservableObject {    
    var client: ApiClient = ApiClient()
    var db: FavoriteDao = FavoriteDao()
}
