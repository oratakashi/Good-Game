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
                            Image(systemName: "h.circle")
                            Text("Home")
                        }
                    }
                    .tag(1)
                NavigationView {
                    ProfileFragment()
                }
                    .tabItem {
                        VStack {
                            Image(systemName: "p.circle")
                            Text("About")
                        }
                    }
                    .tag(2)
            }
    }
}

struct MainActivity_Previews: PreviewProvider {
    static var previews: some View {
        MainActivity()
    }
}
