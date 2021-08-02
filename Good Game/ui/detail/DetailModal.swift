//
//  DetailModal.swift
//  Good Game
//
//  Created by oratakashi on 02/08/21.
//

import SwiftUI
import AttributedText
import SDWebImageSwiftUI

struct DetailModal: View {
    var game: Games
    
    @ObservedObject var viewModel: DetailViewModel = DetailViewModel()
    
    @State var gameImage = UIImage(named: "imgLoading")!
    
    var body: some View {
        VStack(alignment: .center, spacing: 10){
            Capsule()
                .fill(Color.secondary)
                .frame(width: 100, height: 5)
                .padding(.top, 10)
            ZStack(alignment: .bottomLeading){
                ScrollView{
                    VStack(alignment: .leading, spacing: 24){
                        if viewModel.isLoading == false {
                            let data = viewModel.detailGame.first!
                            WebImage(url: URL(string: game.background_image  ?? ""))
                                .resizable()
                                .placeholder(Image("imgLoading"))
                                .frame(height: 280)
                            VStack(alignment: .leading, spacing: 10) {
                                Text(data.name)
                                    .font(.system(size: 26, weight: .bold))
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(2)
                                Text(data.publishers.first?.name ?? "Unknown")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.yellow)
                                HStack(spacing: 10){
                                    StarView(rating: CGFloat(data.rating), size: 15)
                                    Text(String(data.rating))
                                        .font(.system(size: 16, weight: .medium))
                                    Text("( "+String(data.ratings_count)+" Review's )")
                                        .font(.system(size: 16, weight: .regular))
                                        .foregroundColor(.gray)
                                    Spacer()
                                }
                            }
                            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                            Rectangle()
                                .foregroundColor(.secondary)
                                .frame(height: 3)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .opacity(0.8)
                            
                            // Genre
                            ScrollView(.horizontal,showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(data.genres){ genre in
                                        ZStack {
                                            Text(genre.name)
                                                .font(.system(size: 18, weight: .medium))
                                                .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                                        }
                                        .background(Color(.gray))
                                        .cornerRadius(20)
                                    }
                                }
                            }
                            .clipped()
                            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                            
                            Rectangle()
                                .foregroundColor(.secondary)
                                .frame(height: 3)
                                .opacity(0.8)
                            Text("About This Game")
                                .font(.system(size: 24, weight: .bold))
                                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                            
                            ZStack {
                                if data.description_raw.count > 200 {
                                    AttributedText(String(data.description_raw.prefix(200)) + " ...")
                                    
                                } else if data.description_raw.count == 0 {
                                    AttributedText("<i>Description not available</i>")
                                } else {
                                    AttributedText(data.description_raw)
                                }
                            }.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                            
                            Text("Screenshot")
                                .font(.system(size: 24, weight: .bold))
                                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                            
                            // Screenshot
                            ScrollView(.horizontal,showsIndicators: false) {
                                HStack(spacing: 13) {
                                    if(viewModel.ssLoading == false){
                                        ForEach(viewModel.screenShots){ screenShot in
                                            if(screenShot.id == viewModel.screenShots.first!.id){
                                                ScreenshotAdapter(screenShots: screenShot)
                                                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
                                            }else{
                                                ScreenshotAdapter(screenShots: screenShot)
                                            }
                                            
                                        }
                                    }
                                }
                            }
                            
                            aboutGame
                            
                        }
                        else {
                            LayoutShimmerDetail()
                        }
                    }
                }
                .fixFlickering()
                HStack{
                    Spacer()
                    if viewModel.isLoading == false {
                        Button(action: {
                            viewModel.addFav(game: game)
                        }) {
                            HStack {
                                if viewModel.isFav == true {
                                    Image(systemName: "heart.fill")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.red)
                                    Text("Hapus dari Favorite")
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(.black)
                                }else{
                                    Image(systemName: "heart")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.red)
                                    Text("Tambahkan ke Favorite")
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(.black)
                                }
                            }
                            .padding()
                            .background(Color.yellow)
                            .cornerRadius(40)
                        }
                        .shadow(color: .black, radius: 10)
                    }                
                    Spacer()
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 24, trailing: 16))
            }
            
        }
        .navigationBarTitle(Text("Detail Game"), displayMode: .inline)
        .onAppear{
            viewModel.getDetail(game: game)
        }
    }
    
    var aboutGame: some View {
        VStack(alignment: .leading, spacing: 16){
            if viewModel.isLoading == false {
                let data = viewModel.detailGame.first!
                Text("Info Game")
                    .font(.system(size: 24, weight: .bold))
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                HStack {
                    Text("Update on")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                    Spacer()
                    Text(convertDate(date: data.updated))
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
                    Text(data.publishers.first?.name ?? "Unknown")
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
                    Text(convertDate(date: data.released))
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
                        ForEach(data.parent_platforms.map{
                            $0.platform
                        }){ platform in
                            Text(platform.name)
                                .font(.system(size: 18, weight: .regular))
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                        }
                    }
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 80, trailing: 0))
            }
        }
        
    }
}

struct DetailModal_Previews: PreviewProvider {
    static var previews: some View {
        DetailModal(game: Games(
            id: 3498, name: "Grand Theft Auto V", released: "2013-09-17", background_image: "https://media.rawg.io/media/games/84d/84da2ac3fdfc6507807a1808595afb12.jpg", rating: 4.48
        ))
    }
}
