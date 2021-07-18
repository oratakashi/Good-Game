//
//  LayoutShimmerGenres.swift
//  Good Game
//
//  Created by oratakashi on 17/07/21.
//

import SwiftUI

struct LayoutShimmerGenres: View {
    var body: some View {
        ShimmerView()
            .frame(width: 150, height: 230)
            .cornerRadius(10)
    }
}

struct LayoutShimmerGenres_Previews: PreviewProvider {
    static var previews: some View {
        LayoutShimmerGenres()
    }
}
