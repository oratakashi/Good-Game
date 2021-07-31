//
//  ScreenshotAdapter.swift
//  Good Game
//
//  Created by oratakashi on 20/07/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ScreenshotAdapter: View {
    
    var screenShots: Screenshot
    
    var body: some View {
        ZStack {
            WebImage(url: URL(string: screenShots.image))
                .resizable()
                .placeholder(Image("imgLoading"))
                .aspectRatio(contentMode: .fill)
                .frame(width: 350, height: 180)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

struct ScreenshotAdapter_Previews: PreviewProvider {
    static var previews: some View {
        ScreenshotAdapter(
            screenShots: Screenshot(id: 1827221, image: "https://media.rawg.io/media/screenshots/a7c/a7c43871a54bed6573a6a429451564ef.jpg")
        )
    }
}
