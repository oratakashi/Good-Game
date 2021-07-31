//
//  SearchActivity.swift
//  Good Game
//
//  Created by oratakashi on 31/07/21.
//

import SwiftUI

struct SearchActivity: View {
    
    @ObservedObject var viewModel: SearchViewModel = SearchViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            SearchBar(text: $viewModel.searchKeyword)
                .padding(.top, 10)
            ScrollView{
                VStack(alignment: .leading, spacing: 10){
                    
                }
            }
        }            
            .navigationBarTitle(Text("Search"), displayMode: .large)
    }
}

struct SearchActivity_Previews: PreviewProvider {
    static var previews: some View {
        SearchActivity()
    }
}
