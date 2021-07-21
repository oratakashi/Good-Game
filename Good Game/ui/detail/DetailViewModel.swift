//
//  DetailViewModel.swift
//  Good Game
//
//  Created by oratakashi on 19/07/21.
//

import SwiftUI

final class DetailViewModel: ViewModel {
    
    @Published var isLoading: Bool = true
    @Published var ssLoading: Bool = true
    @Published var detailGame: [DetailGames] = []
    @Published var screenShots: [Screenshot] = []
    
    func getDetail(game: Games){
        DispatchQueue.global().async {
            if(self.detailGame.count == 0){
                self.getDetailGames(game: game)
            }
            if(self.screenShots.count == 0){
                self.getScreenshots(game: game)
            }            
        }
    }
    
    func getScreenshots(game: Games){
        DispatchQueue.main.sync {
            self.ssLoading = true
        }
        URLSession.shared.dataTask(with: self.client.getRequest(endpoint: ApiEndpoint.screenshot(gameId: game.id))
        ){ data, response, error in
            guard let response = response as? HTTPURLResponse, let data = data else { return }
            do {
                let decoder = try JSONDecoder().decode(ResponseScreenshots.self, from: data)
                print("Success: \(data), HTTP Status: \(response.statusCode)")
                print(decoder)
                
                DispatchQueue.main.sync {
                    self.ssLoading = false
                    self.screenShots = decoder.results
                }
            } catch {
                print("\(error)")
            }
        }.resume()
    }
    
    func getDetailGames(game: Games){
        DispatchQueue.main.sync {
            self.isLoading = true
        }
        
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
