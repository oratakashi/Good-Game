//
//  ProfileFragment.swift
//  Good Game
//
//  Created by oratakashi on 13/07/21.
//

import SwiftUI

struct ProfileFragment: View {
    var body: some View {
        Text("Profile Fragment")
            .navigationBarTitle(Text("About"), displayMode: .large)
    }
}

struct ProfileFragment_Previews: PreviewProvider {
    static var previews: some View {
        ProfileFragment()
    }
}
