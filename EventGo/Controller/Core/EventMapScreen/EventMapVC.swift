//
//  EventMapsVC.swift
//  EventGo
//
//  Created by Abdulkerim Can on 11.10.2023.
//

import UIKit
import MapKit
import SnapKit
import Kingfisher

protocol EventMapVCDelegate: AnyObject {
    func configureMapView()
    func configureEventAnnotations(events: [Event])
    func configureBottomSheet(with event: Event)
}

final class EventMapVC: UIViewController {
    private let mapview: MKMapView = {
        let mapview = MKMapView()
        mapview.showsUserLocation = true
        return mapview
    }()
    private var coverView: CoverView!
    private var locationManager: CLLocationManager?
    private lazy var viewModel = EventMapViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

extension EventMapVC: EventMapVCDelegate {
    
    func configureBottomSheet(with event: Event) {
        let vc = MapBottomSheetVC(event: event)
        
        let nav = UINavigationController(rootViewController: vc)
        
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.custom(resolver: { context in
                0.3 * context.maximumDetentValue
            })]
        }
        navigationController?.present(nav, animated: true)
    }
    
    func configureEventAnnotations(events: [Event]) {
        for event in events {
            
            let eventCoordinate = CLLocationCoordinate2D(latitude: event.latitude, longitude: event.longitude)
            let pin = CustomAnnotationPin(event: event, coordinate: eventCoordinate)
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
        locationManager?.requestWhenInUseAuthorization()
    }
}

extension EventMapVC: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard let locationManager = locationManager,
              let location = locationManager.location else {
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
        
        let annotationview = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
        annotationview.rightCalloutAccessoryView = UIButton(type: .custom)
        annotationview.tintColor = .red
        
        guard let annotation = annotationview.annotation as? CustomAnnotationPin else {
            return nil
        }
        switch annotation.event.type {
            
        case .concert:
            annotationview.setPin(image: UIImage(systemName: "music.note")!,with: .red)
        case .sport:
            let image = UIImage(systemName: "soccerball.inverse")
            annotationview.setPin(image: image!,with: .white)
        case .theatr:
            let image = UIImage(systemName: "theatermasks.fill")
            annotationview.setPin(image: image!,with: .white)
        case .party:
            let image = UIImage(systemName: "party.popper.fill")
            annotationview.setPin(image: image!,with: .cyan)
        default:
            break
        }
        annotationview.transform = .init(scaleX: 1.5, y: 1.5)
        return annotationview
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? CustomAnnotationPin else {
            return
        }
        configureBottomSheet(with: annotation.event)
    }
}

