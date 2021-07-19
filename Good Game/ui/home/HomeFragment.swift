//
//  HomeFragment.swift
//  Good Game
//
//  Created by oratakashi on 13/07/21.
//

import SwiftUI
import Foundation

struct HomeFragment: View {
    @ObservedObject var viewModel: HomeViewModel = HomeViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                if viewModel.isLoading == false {
                    
                    ForEach(viewModel.genres){ genre in
                        HStack{
                            Text(genre.name)
                                .font(.system(size: 24, weight: .bold))
                                .onAppear{
                                    viewModel.getGames(genre: genre.id)
                                }
                            Spacer()
                            Text("Show All")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.yellow)
                        }
                        if viewModel.genreLoading[genre.id] == false {
                            ScrollView(.horizontal,showsIndicators: false) {
                                HStack(spacing: 8) {
                                    ForEach(viewModel.genreGames[genre.id]!){ game in
                                        GanreAdapter(game: game)
                                    }
                                }
                            }
                            .frame(height: 230)
                            .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
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
                    Text("Top Rating")
                        .font(.system(size: 24, weight: .bold))
                    ForEach(viewModel.topRating){ game in
                        ZStack {
                            HomeAdapter(game: game)
                        }
                    }
                    
                    if viewModel.loadMore == true {
                        withAnimation{
                            LayoutShimmerGame()
                        }
                    }else{
                        withAnimation{
                            HStack {
                                Spacer()
                                Text("Load More")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.yellow)
                                    .onTapGesture {
                                        viewModel.getTopRating()
                                    }
                                Spacer()
                            }
                        }
                    }
                } else {
                    ForEach(0...10, id: \.self) { _ in
                        LayoutShimmerGame()
                    }
                }
            }.padding(16)
        }
        .onAppear {
            viewModel.getHome()
        }
        .clipped()
        .navigationBarTitle(Text("Good Game"), displayMode: .large)
    }
}

struct HomeFragment_Previews: PreviewProvider {
    static var previews: some View {
        HomeFragment()
    }
}
