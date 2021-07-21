//
//  ScreenshotAdapter.swift
//  Good Game
//
//  Created by oratakashi on 20/07/21.
//

import SwiftUI

struct ScreenshotAdapter: View {
    
    var screenShots: Screenshot
    
    @State var gameImage = UIImage(named: "imgLoading")!
    
    var body: some View {
        ZStack {
            Image(uiImage: gameImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 350, height: 180)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .onAppear{
                    DispatchQueue.global().async {
                        guard let url = URL(string: self.screenShots.image) else { return }
                        URLSession.shared.dataTask(with: url) { (data, response, error) in
                            guard let data = data else { return }
                            guard let image = UIImage(data: data) else { return }
                            
                            DispatchQueue.main.async {
                                self.gameImage = image
                            }
                            
                        }.resume()
                    }
                }
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
