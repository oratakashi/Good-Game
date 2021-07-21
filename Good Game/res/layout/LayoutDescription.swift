//
//  LayoutDescription.swift
//  Good Game
//
//  Created by oratakashi on 20/07/21.
//

import SwiftUI
import AttributedText

struct LayoutDescription: View {
    var description: String
    var body: some View {
        VStack(alignment: .leading){
            AttributedText(description)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        }
        .clipped()
    }
}

struct LayoutDescription_Previews: PreviewProvider {
    static var previews: some View {
        LayoutDescription(description: "<i>Description not available</i>")
    }
}
