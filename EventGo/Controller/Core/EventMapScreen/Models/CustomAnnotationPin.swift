//
//  CustomAnnotationPin.swift
//  EventGo
//
//  Created by Abdulkerim Can on 17.10.2023.
//

import Foundation
import MapKit

class CustomAnnotationPin: NSObject, MKAnnotation {
    var event: Event
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    init(event: Event, coordinate: CLLocationCoordinate2D) {
        self.event = event
        self.title = event.name
        self.subtitle = event.date
        self.coordinate = coordinate
    }
    
}
