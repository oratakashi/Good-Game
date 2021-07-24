//
//  LayoutShimmerDetail.swift
//  Good Game
//
//  Created by oratakashi on 22/07/21.
//

import SwiftUI

struct LayoutShimmerDetail: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24){
                ShimmerView()
                    .frame(height: 200)
                VStack(alignment: .leading, spacing: 10){
                    ShimmerView()
                        .frame(width: 250, height: 24)
                    ShimmerView()
                        .frame(width: 130, height: 14)
                    ShimmerView()
                        .frame(width: 250, height: 16)
                }.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                
                ShimmerView()
                    .frame(height: 3)
                
                ShimmerView()
                    .frame(height: 30)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                
                ShimmerView()
                    .frame(height: 3)
                
                ShimmerView()
                    .frame(width: 250, height: 28)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                
                ShimmerView()
                    .frame(height: 300)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            }
            
        }
    }
}

struct LayoutShimmerDetail_Previews: PreviewProvider {
    static var previews: some View {
        LayoutShimmerDetail()
    }
}
