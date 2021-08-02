//
//  DetailAdapter.swift
//  Good Game
//
//  Created by oratakashi on 02/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailAdapter: View {
    var game: Games
    
    @Binding var isDetailShow: Bool
    @Binding var selectedGame: Games?
    
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
        }
        .onTapGesture {
            selectedGame = game
            isDetailShow = true              
        }
        .contentShape(Rectangle())
    }
}

struct DetailAdapter_Previews: PreviewProvider {
    static var previews: some View {
        DetailAdapter(game: Games(
            id: 3498, name: "Grand Theft Auto V", released: "2013-09-17", background_image: "https://media.rawg.io/media/games/84d/84da2ac3fdfc6507807a1808595afb12.jpg", rating: 4.48
        ), isDetailShow: .constant(false), selectedGame: .constant(nil))
    }
}
