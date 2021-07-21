//
//  LayoutAboutGame.swift
//  Good Game
//
//  Created by oratakashi on 20/07/21.
//

import SwiftUI

struct LayoutAboutGame: View {
    
    var game: DetailGames
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16){
                Text("About This Game")
                    .font(.system(size: 24, weight: .bold))
                    .padding(EdgeInsets(top: 16, leading: 20, bottom: 0, trailing: 20))
                LayoutDescription(description: game.description_raw)
                Rectangle()
                    .foregroundColor(.secondary)
                    .frame(height: 2)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .opacity(0.8)
                Text("Info Game")
                    .font(.system(size: 24, weight: .bold))
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                HStack {
                    Text("Update on")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                    Spacer()
                    Text(convertDate(date: game.updated))
                        .font(.system(size: 18, weight: .regular))
                        .frame(alignment: .trailing)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                }
                HStack {
                    Text("Published by")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                    Spacer()
                    Text(game.publishers.first?.name ?? "Unknown")
                        .font(.system(size: 18, weight: .regular))
                        .frame(alignment: .trailing)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                }
                HStack {
                    Text("Release date")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                    Spacer()
                    Text(convertDate(date: game.released))
                        .font(.system(size: 18, weight: .regular))
                        .frame(alignment: .trailing)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                }
                HStack(alignment: .top) {
                    Text("Platform")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                    Spacer()
                    VStack(alignment: .trailing, spacing: 10){
                        ForEach(game.parent_platforms.map{
                            $0.platform
                        }){ platform in
                            Text(platform.name)
                                .font(.system(size: 18, weight: .regular))
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                        }
                    }
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
            }
        }
        .navigationBarTitle(Text("About Game"), displayMode: .inline)
    }
}

struct LayoutAboutGame_Previews: PreviewProvider {
    static var previews: some View {
        LayoutAboutGame(game: DetailGames(id: 3498, name: "Grand Theft Auto V", released: "2013-09-17", updated: "2021-03-03T20:31:29", background_image: "https://media.rawg.io/media/games/84d/84da2ac3fdfc6507807a1808595afb12.jpg", rating: 4.48, description_raw: "Rockstar Games went bigger, since their previous installment of the series. You get the complicated and realistic world-building from Liberty City of GTA4 in the setting of lively and diverse Los Santos, from an old fan favorite GTA San Andreas. 561 different vehicles (including every transport you can operate) and the amount is rising with every update. \r\nSimultaneous storytelling from three unique perspectives: \r\nFollow Michael, ex-criminal living his life of leisure away from the past, Franklin, a kid that seeks the better future, and Trevor, the exact past Michael is trying to run away from. \r\nGTA Online will provide a lot of additional challenge even for the experienced players, coming fresh from the story mode. Now you will have other players around that can help you just as likely as ruin your mission. Every GTA mechanic up to date can be experienced by players through the unique customizable character, and community content paired with the leveling system tends to keep everyone busy and engaged.", ratings_count: 4889, publishers: [Publishers(id: 2155, name: "Rockstar Games")], genres: [], parent_platforms: [
                ParentPlatform(platform: Platform(id: 1, name: "PC")),
                ParentPlatform(platform: Platform(id: 2, name: "PlayStation")),
                ParentPlatform(platform: Platform(id: 3, name: "Xbox"))
            ]))
    }
}
