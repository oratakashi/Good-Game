//
//  ProfileFragment.swift
//  Good Game
//
//  Created by oratakashi on 13/07/21.
//

import SwiftUI

struct ProfileFragment: View {
    
    @State var gameImage = UIImage(named: "imgLoading")!
    
    var body: some View {
        ScrollView {
            VStack {
                Image(uiImage: gameImage)
                    .resizable()
                    .frame(height: 280)
                    .cornerRadius(20)
                    .padding(.top, 16)
                    .onAppear{
                        DispatchQueue.global().async {
                            guard let url = URL(string: "https://cdn.wallpapersafari.com/58/70/oRiMI6.jpg") else { return }
                            URLSession.shared.dataTask(with: url) { (data, response, error) in
                                guard let data = data else { return }
                                guard let image = UIImage(data: data) else { return }
                                
                                DispatchQueue.main.async {
                                    self.gameImage = image
                                }
                                
                            }.resume()
                        }
                    }
                Image("photo")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 10)
                    .offset(y: -80).padding(.bottom, -80)
                
                VStack(alignment: .center){
                    Text("Abdul Hafiidh S")
                        .font(.system(size: 24))
                    Text("Android Developer")
                        .font(.system(size: 18))
                    
                }.padding()
            }
        }
            .navigationBarTitle(Text("About"), displayMode: .large)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    ZStack {
                        Text("")
                        NavigationLink(destination: SearchActivity()) {
                            Image(systemName: "magnifyingglass")
                                .font(.title2)
                        }
                        
                    }
                }
            }
    }
}

struct ProfileFragment_Previews: PreviewProvider {
    static var previews: some View {
        ProfileFragment()
    }
}


