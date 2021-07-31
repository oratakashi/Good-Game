//
//  ContentView.swift
//  Good Game
//
//  Created by oratakashi on 13/07/21.
//

import SwiftUI

struct MainActivity: View {
    var body: some View {
            TabView {
                NavigationView {
                    HomeFragment()
                }
                    
                    .tabItem {
                        VStack {
                            Image(systemName: "house")
                            Text("Home")
                        }
                    }
                    .tag(1)
                NavigationView {
                    FavoriteFragment()
                }
                .tabItem {
                    VStack {
                        Image(systemName: "heart")
                        Text("Favorite")
                    }
                }
                .tag(2)
                NavigationView {
                    ProfileFragment()
                }
                    .tabItem {
                        VStack {
                            Image(systemName: "info.circle")
                            Text("About")
                        }
                    }
                    .tag(3)
            }
            .accentColor(.yellow)
    }
}

struct MainActivity_Previews: PreviewProvider {
    static var previews: some View {
        MainActivity()
    }
}
