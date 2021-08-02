//
//  GanreAdapter.swift
//  Good Game
//
//  Created by oratakashi on 17/07/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct GanreAdapter: View {
    var game: Games
    
    var body: some View {
        ZStack {
            WebImage(url: URL(string: game.background_image ?? ""))
                .resizable()
                .placeholder(Image("imgLoading"))
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 230)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    //This HStack places the text in the middle with some padding
                    HStack {
                        Spacer()
                        Text(game.name)
                            .font(.headline)
                            .foregroundColor(.white)
                            .lineLimit(2)
                            .padding(.vertical)
                        Spacer()
                    }
                    .background(Color.gray)
                    .opacity(0.8)
                    .clipShape(RoundedRectangle(cornerRadius: 10)),
                    alignment: .bottom
                )
//            Image(uiImage: gameImage)
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 150, height: 230)
//                .clipShape(RoundedRectangle(cornerRadius: 10))
//                .overlay(
//                    //This HStack places the text in the middle with some padding
//                    HStack {
//                        Spacer()
//                        Text(game.name)
//                            .font(.headline)
//                            .foregroundColor(.white)
//                            .lineLimit(2)
//                            .padding(.vertical)
//                        Spacer()
//                    }
//                    .background(Color.gray)
//                    .opacity(0.8)
//                    .clipShape(RoundedRectangle(cornerRadius: 10)),
//                    alignment: .bottom
//                )
//                .onAppear{
//                    DispatchQueue.global().async {
//                        guard let url = URL(string: self.game.background_image) else { return }
//                        URLSession.shared.dataTask(with: url) { (data, response, error) in
//                            guard let data = data else { return }
//                            guard let image = UIImage(data: data) else { return }
//
//                            DispatchQueue.main.async {
//                                self.gameImage = image
//                            }
//
//                        }.resume()
//                    }
//                }
            NavigationLink(destination: DetailActivity(game: game)) {
                Rectangle().opacity(0.0)
            }
        }
        .contentShape(Rectangle())
    }
}

struct GanreAdapter_Previews: PreviewProvider {
    static var previews: some View {
        GanreAdapter(game: Games(
            id: 3498, name: "Grand Theft Auto V", released: "2013-09-17", background_image: "https://media.rawg.io/media/games/84d/84da2ac3fdfc6507807a1808595afb12.jpg", rating: 4.48
        ))
        .previewLayout(.fixed(width: 180, height: 250))
    }
}
