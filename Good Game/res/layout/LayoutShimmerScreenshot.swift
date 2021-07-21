//
//  LayoutShimmerScreenshot.swift
//  Good Game
//
//  Created by oratakashi on 20/07/21.
//

import SwiftUI

struct LayoutShimmerScreenshot: View {
    var body: some View {
        ShimmerView()
            .frame(width: 400, height: 230)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct LayoutShimmerScreenshot_Previews: PreviewProvider {
    static var previews: some View {
        LayoutShimmerScreenshot()
    }
}
