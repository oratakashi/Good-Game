//
//  SearchViewModel.swift
//  Good Game
//
//  Created by oratakashi on 31/07/21.
//

import Foundation

class SearchViewModel: ViewModel {
    
    private var oldKeyword: String = ""
    private var oldId: Int32 = -1
    
    @Published var page: Int = 1
    
    @Published var loadMore: Bool = false
    @Published var canloadMore: Bool = false
    @Published var isLoading: Bool = true
    
    @Published var searchResult: [Games] = []
    
    @Published var searchKeyword = "" {
        didSet {
            if searchKeyword.count > 2 {
                if searchKeyword != oldKeyword {
                    oldKeyword = searchKeyword
                    page = 1
                    searchResult = []
                    oldId = -1
                    print(searchResult)
                    searchGames(keyword: searchKeyword)
                }                
            }            
        }
    }
    
    func searchGames(keyword: String){
        if self.page == 1 {
            self.isLoading = true
        } else {
            self.loadMore = true
        }
        
        URLSession.shared.dataTask(with: client.getRequest(endpoint: ApiEndpoint.games, query: [
            URLQueryItem(name: "search", value: keyword),
            URLQueryItem(name: "page", value: String(self.page))
        ])){ data, response, error in
            guard let response = response as? HTTPURLResponse, let data = data else { return }
            do {
                let decoder = try JSONDecoder().decode(Response.self, from: data)
                print("Success: \(data), HTTP Status: \(response.statusCode)")
//                print(decoder)
                
                decoder.results.forEach{ row in
                    DispatchQueue.main.sync {
                        self.searchResult.append(row)
                    }
                }
                
                DispatchQueue.main.sync {
                    if decoder.next != nil {
                        self.canloadMore = true
                    }else{
                        self.canloadMore = false
                    }
                    self.page += 1
                    self.isLoading = false
                    self.loadMore = false
                }
            } catch {
                DispatchQueue.main.sync {
                    self.isLoading = false
                    self.loadMore = false
                }
                print("\(error)")
            }
        }.resume()
    }
}
