//
//  Event.swift
//  EventGo
//
//  Created by Abdulkerim Can on 14.10.2023.
//

import Foundation

struct Event: Codable {
    let id: String
    let ownerId: String?
    let image: String?
    let name: String
    let type: EventSection
    let date: String
    let time: String
    let price: String
    let location: String
    let latitude: Double
    let longitude: Double
}
