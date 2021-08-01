//
//  Extension.swift
//  Good Game
//
//  Created by oratakashi on 16/07/21.
//

import SwiftUI
import CoreData

extension View {
    func convertDate(date: String?) -> String {
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

extension Games {
    func toNSManagedObject(task: NSManagedObjectContext, entity: NSEntityDescription) -> NSManagedObject {
        let obj = NSManagedObject(entity: entity, insertInto: task)
        obj.setValue(self.id, forKey: Fav.id.values())
        obj.setValue(self.name, forKey: Fav.name.values())
        obj.setValue(self.released, forKey: Fav.released.values())
        obj.setValue(self.background_image, forKey: Fav.background_image.values())
        obj.setValue(self.rating, forKey: Fav.rating.values())
        return obj
    }
}

extension NSManagedObject {
    func toGames() -> Games {
        return Games(
            id: self.value(forKey: Fav.id.values()) as? Int32 ?? 0, 
            name: self.value(forKey: Fav.name.values()) as? String ?? "", 
            released: self.value(forKey: Fav.released.values()) as? String, 
            background_image: self.value(forKey: Fav.background_image.values()) as? String ?? "",
            rating: self.value(forKey: Fav.rating.values()) as? Float ?? 0
        )
    }
}

extension ScrollView {
    typealias PaddedContent = ModifiedContent<Content, _PaddingLayout>
//    public func fixFlickering() -> some View {
//        
//        return self.fixFlickering { (scrollView) in
//            
//            return scrollView
//        }
//        
//        
//        
//        
//    }
    
    func fixFlickering() -> some View {
        GeometryReader { geo in
            ScrollView<PaddedContent>(axes, showsIndicators: showsIndicators) {
                content.padding(geo.safeAreaInsets) as! PaddedContent
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
    
//    public func fixFlickering<T: View>(@ViewBuilder configurator: @escaping (ScrollView<AnyView>) -> T) -> some View {
//        
//        GeometryReader { geometryWithSafeArea in
//            GeometryReader { geometry in
//                configurator(
//                    ScrollView<AnyView>(self.axes, showsIndicators: self.showsIndicators) {
//                        AnyView(
//                            VStack {
//                                self.content
//                            }
//                            .padding(.top, geometryWithSafeArea.safeAreaInsets.top)
//                            .padding(.bottom, geometryWithSafeArea.safeAreaInsets.bottom)
//                            .padding(.leading, geometryWithSafeArea.safeAreaInsets.leading)
//                            .padding(.trailing, geometryWithSafeArea.safeAreaInsets.trailing)
//                        )
//                    }
//                )
//            }
//            .edgesIgnoringSafeArea(.all)
//        }
//    }
}
