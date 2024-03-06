//
//  EventMapViewModel.swift
//  EventGo
//
//  Created by Abdulkerim Can on 17.10.2023.
//

import Foundation
import MapKit

protocol EventMapViewModelDelegate {
    var view: EventMapVCDelegate? {get set}
    func viewDidLoad()
    func fetchEvents()
    func selectEvent(with event: Event)
}

final class EventMapViewModel: NSObject {
    weak var view: EventMapVCDelegate?
    var events: [Event] = []
    private var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
}

extension EventMapViewModel: EventMapViewModelDelegate {
    func selectEvent(with event: Event) {
            self.view?.presentBottomSheet(with: event, distance: 0)
    }
    
        
    func fetchEvents() {
        NetworkManager.shared.getMultipleDatas(type: Event.self, path: .posts) { result in
            switch result {
            case .success(let success):
                self.events.append(contentsOf: success)
                self.view?.configureEventAnnotations(events: self.events)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func viewDidLoad() {
        view?.configureMapView()
        fetchEvents()
    }
}

extension EventMapViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard let location = locationManager.location else {
            return
        }
        
        switch locationManager.authorizationStatus {
        case .notDetermined,.restricted:
            print("location cannot be determined or restricted")
            view?.doNotShowUserLocation()
        case .denied:
            print("location permission has been denied")
            view?.doNotShowUserLocation()
        case .authorizedWhenInUse,.authorizedAlways:
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
            view?.showUserLocation(region: region)
        @unknown default:
            print("Unknown error")
            view?.doNotShowUserLocation()
        }
    }
}

extension EventMapViewModel: GetDirectionDelegate {
    func getDirection(coordinate destinationCoordinate: CLLocationCoordinate2D) {
        guard let sourceCoordinate = locationManager.location?.coordinate else {
            return
        }
        
        let sourcePlaceMark = MKPlacemark(coordinate: sourceCoordinate)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationCoordinate)
        
        let sourceItem = MKMapItem(placemark: sourcePlaceMark)
        let destinationItem = MKMapItem(placemark: destinationPlaceMark)
        
        let destinationRequest = MKDirections.Request()
        destinationRequest.source = sourceItem
        destinationRequest.destination = destinationItem
        destinationRequest.transportType = .walking
        destinationRequest.requestsAlternateRoutes = true
        
        let direction = MKDirections(request: destinationRequest)
        
        direction.calculate { response, error in
            if  error != nil {
                return
            }
            guard let response = response else {
                return
            }
            
            for route in response.routes {
                self.view?.configureDistance(route.polyline)
            }
        }
    }
}
