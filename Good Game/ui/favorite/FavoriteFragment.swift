//
//  FavoriteFragment.swift
//  Good Game
//
//  Created by oratakashi on 31/07/21.
//

import SwiftUI

struct FavoriteFragment: View {
    
    @ObservedObject var viewModel: FavoriteViewModel = FavoriteViewModel()
    @State var showsAlert = false
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if viewModel.favorite.count > 0 {
                ScrollView {
                    VStack(
                        alignment: .leading,
                        spacing: 10
                    ){
                        ForEach(viewModel.favorite){ game in
                            HomeAdapter(game: game)
                        }
                    }.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                }
            }else{
                VStack(alignment: .leading, spacing: 10) {
                    HStack{
                        Spacer()
                        Image(systemName: "heart")
                            .font(.system(size: 64))
                            .foregroundColor(.yellow)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("Favorite Game Empty!")
                            .font(.system(size: 24, weight: .bold))
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("You can save game into favorite from detail game")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.gray)
                        Spacer()
                    }
                }
            }
            
            HStack{
                Spacer()
                if viewModel.favorite.count > 0 {
                    Button(action: {
                        showsAlert.toggle() 
                    }) {
                        HStack {
                            Image(systemName: "trash")
                                .font(.system(size: 18, weight: .bold))
                            Text("Remove All")
                                .font(.system(size: 18, weight: .semibold))
                            
                        }
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.yellow)
                        .cornerRadius(40)
                    }         
                    .alert(isPresented: self.$showsAlert) {
                        Alert(title: Text("Are you sure want to remove all Favorite data?"), primaryButton: .destructive(Text("Remove All"), action: {
                            viewModel.removeAll()
                        }), secondaryButton: .cancel(Text("Cancel")))
                    }
                }                
                Spacer()
            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 24, trailing: 16))
        }
        .onAppear{
            viewModel.getFavorite()
        }
        .navigationBarTitle(Text("Favorite"), displayMode: .large)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                ZStack {
                    Text("")
                    NavigationLink(destination: SearchActivity()) {
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                    }
                    
                }
            }
        }
    }
}

struct FavoriteFragment_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteFragment()
    }
}
