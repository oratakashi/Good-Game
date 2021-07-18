//
//  LayoutShimmerGame.swift
//  Good Game
//
//  Created by oratakashi on 17/07/21.
//

import SwiftUI

struct LayoutShimmerGame: View {
    
    @State private var width: CGFloat? = 0
    
    var body: some View {
        HStack(alignment: .top) {
            ShimmerView()
                .frame(width: 80, height: 80)
            VStack(alignment: .leading, spacing: 8) {
                ShimmerView()
                    .frame(height: 20)
                ShimmerView()
                    .frame(height: 20)
                ShimmerView()
                    .frame(height: 20)
            }
            .padding(.leading, 10)
            Spacer()
        }.padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
    }
}

struct LayoutShimmerGame_Previews: PreviewProvider {
    static var previews: some View {
        LayoutShimmerGame()
    }
}
