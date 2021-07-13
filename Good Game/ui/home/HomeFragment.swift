//
//  HomeFragment.swift
//  Good Game
//
//  Created by oratakashi on 13/07/21.
//

import SwiftUI

struct HomeFragment: View {
    var body: some View {
        Text("Home Fragment!")
            .navigationBarTitle(Text("Home"), displayMode: .large)
            .padding()
    }
}

struct HomeFragment_Previews: PreviewProvider {
    static var previews: some View {
        HomeFragment()
    }
}
