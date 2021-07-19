//
//  DetailViewModel.swift
//  Good Game
//
//  Created by oratakashi on 19/07/21.
//

import SwiftUI

final class DetailViewModel: ViewModel {
    
    @Published var isLoading: Bool = true
    @Published var detailGame: [DetailGames] = []
    
    func getDetail(game: Games){
        self.isLoading = true
        DispatchQueue.global().async {
            URLSession.shared.dataTask(with: self.client.getRequest(endpoint: ApiEndpoint.detail(gameId: game.id), pageSize: "0")
            ){ data, response, error in
                guard let response = response as? HTTPURLResponse, let data = data else { return }
                do {
                    let decoder = try JSONDecoder().decode(DetailGames.self, from: data)
                    print("Success: \(data), HTTP Status: \(response.statusCode)")
                    print(decoder)
                    
                    DispatchQueue.main.sync {
                        self.isLoading = false
                        self.detailGame.removeAll()
                        self.detailGame.append(decoder)
                    }
                } catch {
                    print("\(error)")
                }
            }.resume()
        }
    }
}
