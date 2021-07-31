//
//  HomeAdapter.swift
//  Good Game
//
//  Created by oratakashi on 16/07/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeAdapter: View {
    var game: Games
    
    @State var gameImage = UIImage(named: "imgLoading")!
    
    var body: some View {
        ZStack{
            NavigationLink(destination: DetailActivity(game: game)) {
                Rectangle().opacity(0.0)
            }
            HStack(alignment: .top) {
                WebImage(url: URL(string: game.background_image))
                    .resizable()
                    .placeholder(Image("imgLoading"))
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .onAppear{
                        DispatchQueue.global().async {
                            guard let url = URL(string: self.game.background_image) else { return }
                            URLSession.shared.dataTask(with: url) { (data, response, error) in
                                guard let data = data else { return }
                                guard let image = UIImage(data: data) else { return }
                                
                                DispatchQueue.main.async {
                                    self.gameImage = image
                                }
                                
                            }.resume()
                        }
                    }
                VStack(alignment: .leading, spacing: 8) {
                    Text(game.name)
                        .font(.system(size: 24, weight: .bold, design: .default))
                        .multilineTextAlignment(.leading)
                    HStack(alignment: .top, spacing: 10) {
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 16, height: 16, alignment: .leading)
                            .foregroundColor(.yellow)
                        Text(String(format:"%.2f", game.rating))
                            .font(.system(size: 16, weight: .medium))
                    }
                    Text(convertDate(date: game.released))
                        .font(.system(size: 16))
                        .lineLimit(1)
                }
                .padding(.leading, 10)
                Spacer()
            }.padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
            
        }
    }
}

struct HomeAdapter_Previews: PreviewProvider {
    static var previews: some View {
        HomeAdapter(game: Games(
            id: 3498, name: "Grand Theft Auto V", released: "2013-09-17", background_image: "https://media.rawg.io/media/games/84d/84da2ac3fdfc6507807a1808595afb12.jpg", rating: 4.48
        ))
            .previewLayout(.fixed(width: 400, height: 120))
    }
}
