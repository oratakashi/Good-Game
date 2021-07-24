//
//  DetailActivity.swift
//  Good Game
//
//  Created by oratakashi on 17/07/21.
//

import SwiftUI
import AttributedText

struct DetailActivity: View {
    var game: Games
    
    @ObservedObject var viewModel: DetailViewModel = DetailViewModel()
    
    @State var gameImage = UIImage(named: "imgLoading")!
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 24){
                if viewModel.isLoading == false {
                    let data = viewModel.detailGame.first!
                    Image(uiImage: gameImage)
                        .resizable()
                        .frame(height: 280)
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
                    ZStack{
                        NavigationLink(destination: LayoutAboutGame(game: data)) {
                            Rectangle().opacity(0.0)
                        }
                        HStack{
                            Text("About This Game")
                                .font(.system(size: 24, weight: .bold))
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.yellow)
                        }
                    }.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    
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
                    
                    if data.publishers.first != nil {
                        let pub = data.publishers.first!
                        Text("More by "+pub.name)
                            .font(.system(size: 24, weight: .bold))
                            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                            .onAppear{
                                viewModel.getRecomendation(id: pub.id)
                            }
                        if viewModel.recomendationLoading == false {
                            ScrollView(.horizontal,showsIndicators: false) {
                                HStack(spacing: 8) {
                                    ForEach(viewModel.recomendation){ game in
                                        if game.id == viewModel.recomendation.first!.id {
                                            GanreAdapter(game: game)
                                                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
                                        }else{
                                            GanreAdapter(game: game)
                                        }
                                        
                                    }
                                }
                            }
                            .frame(height: 230)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
                            .clipped()
                        }else{
                            ScrollView(.horizontal,showsIndicators: false) {
                                HStack(spacing: 5) {
                                    ForEach(0...10, id: \.self) { _ in
                                        LayoutShimmerGenres()
                                    }
                                }.padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                            }
                            .frame(height: 230)
                            .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                            .clipped()
                        }
                    }
                }
                else {
                    LayoutShimmerDetail()
                }
            }
        }
        .clipped()
        .onAppear{
            viewModel.getDetail(game: game)
        }
        .navigationBarTitle(Text("Detail Game"), displayMode: .inline)
    }
}

struct DetailActivity_Previews: PreviewProvider {
    static var previews: some View {
        DetailActivity(game: Games(
            id: 3498, name: "Grand Theft Auto V", released: "2013-09-17", background_image: "https://media.rawg.io/media/games/84d/84da2ac3fdfc6507807a1808595afb12.jpg", rating: 4.48
        ))
    }
}
