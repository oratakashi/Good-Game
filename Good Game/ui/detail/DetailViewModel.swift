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
    @Published var recomendationLoading: Bool = true
    @Published var detailGame: [DetailGames] = []
    @Published var screenShots: [Screenshot] = []
    @Published var recomendation: [Games] = []
    @Published var isFav: Bool = true
    @Published var favImage: String = "heart"
    @Published var favText: String = "Tambahkan ke Favorite"
    
    func getDetail(game: Games){
        DispatchQueue.global().async {
            if(self.detailGame.count == 0){
                self.getDetailGames(game: game)
            }
            if(self.screenShots.count == 0){
                self.getScreenshots(game: game)
            }        
            self.getFavStatus(game: game)
        }
    }
    
    func getScreenshots(game: Games){
        DispatchQueue.main.sync {
            if(self.detailGame.count == 0){
                self.ssLoading = true
            }
        }
        URLSession.shared.dataTask(with: self.client.getRequest(endpoint: ApiEndpoint.screenshot(gameId: Int(game.id)))
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
            if(self.detailGame.count == 0){
                self.ssLoading = true
            }   
        }
        
        URLSession.shared.dataTask(with: self.client.getRequest(endpoint: ApiEndpoint.detail(gameId: Int(game.id)), pageSize: "0")
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
    
    func getRecomendation(id: Int){
        if recomendation.count == 0 {
            self.recomendationLoading = true
            DispatchQueue.global().async {
                URLSession.shared.dataTask(with: self.client.getRequest(endpoint: ApiEndpoint.games, query: [
                    URLQueryItem(name: "ordering", value: "-rating"),
                    URLQueryItem(name: "publishers", value: String(id))
                ])
                ){ data, response, error in
                    guard let response = response as? HTTPURLResponse, let data = data else { return }
                    do {
                        let decoder = try JSONDecoder().decode(Response.self, from: data)
                        print("Success: \(data), HTTP Status: \(response.statusCode)")
                        print(decoder)
                        
                        DispatchQueue.main.sync {
                            self.recomendationLoading = false
                            self.recomendation = decoder.results
                        }
                    } catch {
                        print("\(error)")
                    }
                }.resume()
            }
        }
    }
    
    func getFavStatus(game: Games){
        db.findById(game.id){ data in
            if data != nil {
                DispatchQueue.main.async {
                    self.isFav = true
                }                
            }else{
                DispatchQueue.main.async {
                    self.isFav = false
                }
            }
        }
    }
    
    func addFav(game: Games){
        db.findById(game.id){ data in
            if data != nil {
                self.db.deleteById(game.id){
                    self.getFavStatus(game: game)
                }
            }else{
                self.db.create(game){
                    self.getFavStatus(game: game)
                }
            }
        }
    }
}
