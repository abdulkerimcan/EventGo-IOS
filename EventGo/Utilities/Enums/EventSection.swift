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

struct EventSectionModel: SectionModelType {
    var items: [Event]
    var sectionName: EventSection
}
extension EventSectionModel {
    init(original: EventSectionModel, items: [Event]) {
        self = original
        self.items = items
    }
    
    typealias Item = Event
}
