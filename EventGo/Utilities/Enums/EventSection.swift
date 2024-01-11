//
//  HomeSectionsEnum.swift
//  EventGo
//
//  Created by Abdulkerim Can on 11.10.2023.
//

import Foundation
import RxDataSources

enum EventSection: String, Codable {
    case featured = "Featured"
    case concert = "Concert"
    case sport = "Sport"
    case theatr = "Theatr"
    case party = "Party"
    case newest = "Newest Events"
}

struct ZISectionWrapperModel {
    var sectionName:EventSection
    var items = [ZIWrapperItem]()
}

extension ZISectionWrapperModel:AnimatableSectionModelType {
    init(original: ZISectionWrapperModel, items: [ZIWrapperItem]) {
        self = original
        self.items = items
    }

    typealias Identity = EventSection
    
    var identity:Identity {
        return self.sectionName
    }
    
    /// Method description
    /// This method can is used to convert Section Items to ZIWrapperItem array
    ///
    /// - parameter content:  (sectionName) - Should be different for each section  (objects) - array of different objects
    ///
    /// - return: [ZIWrapperItem]
    static func convertItemOfAnyToZIWrapperItem(sectionName:EventSection,objects:[Event])->[ZIWrapperItem] {
        var array = [ZIWrapperItem]()
        for (index,obj) in objects.enumerated() {
            let item = ZIWrapperItem(id: sectionName.rawValue + "\(index)", data: obj)
            array.append(item)
        }
        return array
    }
}


/// Class ZISectionWrapperModel
class ZIWrapperItem:IdentifiableType,Equatable {
    typealias Identity = String
    
    var identity:Identity {
        return self.id
    }
    
    static func == (lhs: ZIWrapperItem, rhs: ZIWrapperItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id:String
    var data:Event
    
    /// Method description
    /// This method is used for initialization of ZIWrapperItem
    ///
    /// - parameter content:  (id) - SectionName + "\(index)"  (data) - information to pass
    ///
    fileprivate init(id:String,data:Event) {
        self.id = id
        self.data = data
    }
}
