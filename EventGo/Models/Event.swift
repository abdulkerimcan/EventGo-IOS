//
//  Event.swift
//  EventGo
//
//  Created by Abdulkerim Can on 14.10.2023.
//

import Foundation

struct Event: Codable,BaseModelProtocol {
    
    var id: String?
    let ownerId: String?
    var image: String?
    let name: String
    let type: EventSection
    let date: String
    let time: String
    let price: String
    let location: String
    let latitude: Double
    let longitude: Double
}
