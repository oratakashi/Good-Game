//
//  SearchViewModel.swift
//  Good Game
//
//  Created by oratakashi on 31/07/21.
//

import Foundation

class SearchViewModel: ViewModel {
    
    @Published var searchKeyword = "" {
        didSet {
            searchGames(keyword: searchKeyword)
            //do whatever you want
        }
    }
    
    func searchGames(keyword: String){
        print(keyword)
    }
}
