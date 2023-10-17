//
//  EventMapsVC.swift
//  EventGo
//
//  Created by Abdulkerim Can on 11.10.2023.
//

import UIKit
import MapKit
import SnapKit

class AnnotationPin: NSObject, MKAnnotation {
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
protocol EventMapVCDelegate: AnyObject {
    func configureMapView()
    func configureEventAnnotations(events: [Event])
}

final class EventMapVC: UIViewController {
    private let mapview: MKMapView = {
        let mapview = MKMapView()
        mapview.showsUserLocation = true
        return mapview
    }()
    private var locationManager: CLLocationManager?
    private lazy var viewModel = EventMapViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        
    }
}

extension EventMapVC: EventMapVCDelegate {
    func configureEventAnnotations(events: [Event]) {
        for event in events {
            
            let eventCoordinate = CLLocationCoordinate2D(latitude: event.latitude, longitude: event.longitude)
            let pin = AnnotationPin(event: event, coordinate: eventCoordinate)
            
            mapview.addAnnotation(pin)
        }
        
    }
    
    func configureMapView() {
        
        view.addSubview(mapview)
        mapview.snp.makeConstraints { make in
            make.left.right.bottom.top.equalToSuperview()
        }
        mapview.delegate = self
        locationManager = CLLocationManager()
        locationManager?.delegate = self
    }
}

extension EventMapVC: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard let locationManager = locationManager, let location =
                locationManager.location else {
            return
        }
        
        switch locationManager.authorizationStatus {
        case .notDetermined,.restricted:
            print("location cannot be determined or restricted")
            mapview.showsUserLocation = false
        case .denied:
            print("location permission has been denied")
            mapview.showsUserLocation = false
        case .authorizedWhenInUse,.authorizedAlways:
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
            mapview.setRegion(region, animated: true)
            mapview.showsUserLocation = true
        @unknown default:
            print("Unknown error")
            mapview.showsUserLocation = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

extension EventMapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        guard let annotation = annotation as? AnnotationPin else {
            print("asasa")
            return nil
        }
        var annotationview = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationview == nil {
            annotationview = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotationview?.rightCalloutAccessoryView = UIButton(type: .custom)
            annotationview?.canShowCallout = true
        } else {
            annotationview?.annotation = annotation
        }

        switch annotationview?.annotation?.title {
        case "12aas":
            annotationview?.image = UIImage(systemName: "bell.fill")
            annotationview?.tintColor = .red
        case "Basketball":
            annotationview?.image = UIImage(systemName: "bell")
        default:
            annotationview?.image = UIImage(systemName: "plus")
        }
        return annotationview
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
    }
}

