//
//  HomeViewModel.swift
//  Good Game
//
//  Created by oratakashi on 14/07/21.
//

import Foundation

final class HomeViewModel: ViewModel {
    
    @Published var isLoading: Bool = true
    @Published var topRating: [Games] = []
    @Published var genreGames: [Int: [Games]] = [:]
    @Published var genres: [Genres] = []
    @Published var genreLoading: [Int: Bool] = [:]
    @Published var loadMore: Bool = false
    @Published var page: Int = 1
    
    func getHome(){
        DispatchQueue.main.async {
            if(self.genres.count == 0) && (self.topRating.count == 0){
                self.getTopRating()
                self.getGenres()
            }
            
        }
    }
    
    func getGenres(){
        URLSession.shared.dataTask(with: client.getRequest(endpoint: ApiEndpoint.genre, pageSize: "5")) { [self] data, response, error in
            guard let response = response as? HTTPURLResponse, let data = data else { return }
            do{
                let decoder = try JSONDecoder().decode(ResponseGenre.self, from: data)
                print("Success: \(data), HTTP Status: \(response.statusCode)")
                print(decoder)
                
                /**
                 Set  All Games in Ganre in Loading State
                 */
                decoder.results.forEach{ row in
                    DispatchQueue.main.sync {
                        self.genreLoading[row.id] = true
                    }
                }
                
                DispatchQueue.main.sync {
                    self.isLoading = false
                    self.genres = decoder.results
                }
                
            } catch {
                print("\(error)")
            }
        }.resume()
    }
    
    func getTopRating() {
        
        if self.page == 1 {
            self.isLoading = true
        } else {
            self.loadMore = true
        }
        
        URLSession.shared.dataTask(with: client.getRequest(endpoint: ApiEndpoint.games, query: [
            URLQueryItem(name: "ordering", value: "-rating"),
            URLQueryItem(name: "page", value: String(self.page))
        ])){ data, response, error in
            guard let response = response as? HTTPURLResponse, let data = data else { return }
            do{
                let decoder = try JSONDecoder().decode(Response.self, from: data)
                print("Success: \(data), HTTP Status: \(response.statusCode)")
                print(decoder)
                
                decoder.results.forEach{ row in
                    DispatchQueue.main.sync {
                        self.topRating.append(row)
                    }
                }
                
                DispatchQueue.main.sync {
                    self.page += 1
                    self.isLoading = false
                    self.loadMore = false
//                    self.topRating = decoder.results
                }
                
            } catch {
                print("\(error)")
            }
        }.resume()
    }
    
    func getGames(genre: Int){
        if self.genreGames[genre] == nil {
            DispatchQueue.global().async {
                
                URLSession.shared.dataTask(with: self.client.getRequest(endpoint: ApiEndpoint.games, query: [
                    URLQueryItem(name: "ordering", value: "-rating"),
                    URLQueryItem(name: "genres", value: String(genre))
                ], pageSize: "5"
                )){ data, response, error in
                    guard let response = response as? HTTPURLResponse, let data = data else { return }
                    do{
                        let decoder = try JSONDecoder().decode(Response.self, from: data)
                        print("Success: \(data), HTTP Status: \(response.statusCode)")
                        print(decoder)
                        
                        DispatchQueue.main.sync {
                            self.genreLoading[genre] = false
                            self.genreGames[genre] = decoder.results
                        }
                        
                    } catch {
                        print("\(error)")
                    }
                }.resume()
            }
        }
    }
}
