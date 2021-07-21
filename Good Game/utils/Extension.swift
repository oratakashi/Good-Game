//
//  Extension.swift
//  Good Game
//
//  Created by oratakashi on 16/07/21.
//

import SwiftUI

extension View {
    func convertDate(date: String?) -> String{
        if date != nil {
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd"
            let showDate = inputFormatter.date(from: String(date!.prefix(10)))
            inputFormatter.dateFormat = "dd MMM yyyy"
            return inputFormatter.string(from: showDate!)
        }else{
            return "-"
        }
        
    }
}
