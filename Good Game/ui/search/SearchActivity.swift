//
//  SearchActivity.swift
//  Good Game
//
//  Created by oratakashi on 31/07/21.
//

import SwiftUI
import AlertToast

struct SearchActivity: View {
    
    @ObservedObject var viewModel: SearchViewModel = SearchViewModel()
    @State var isDetailShow: Bool = false
    @State var selectedGame: Games? = nil
    @State private var showToast = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            SearchBar(text: $viewModel.searchKeyword)
                .padding(.top, 10)
            ScrollView{
                VStack(alignment: .leading, spacing: 10){
                    ForEach(viewModel.searchResult){ game in
                        SearchAdapter(game: game, isDetailShow: $isDetailShow, selectedGame: $selectedGame)
                    }
                    if viewModel.canloadMore == true {
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
                                            viewModel.searchGames(keyword: viewModel.searchKeyword)
                                        }
                                    Spacer()
                                }
                            }
                        }
                    }
                }
            }
        }            
            .navigationBarTitle(Text("Search"), displayMode: .large)
            .sheet(isPresented: $isDetailShow,
                   onDismiss: { self.isDetailShow = false }) {
                if selectedGame != nil {
                    DetailModal(game: selectedGame!)                   
                }else{
                    VStack{}
                        .toast(isPresenting: $showToast, alert: {
                            AlertToast(type: .error(.red), title: "Something Wrong!, Please select another result!")
                        }, completion: {
                            isDetailShow = false
                        })
                        .onAppear{
                            showToast.toggle()
                        }
                        
                }
                
            }
    }
}

struct SearchActivity_Previews: PreviewProvider {
    static var previews: some View {
        SearchActivity()
    }
}
