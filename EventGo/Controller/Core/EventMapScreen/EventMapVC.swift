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
    func presentBottomSheet(with event: Event,distance: Double)
    func showUserLocation(region: MKCoordinateRegion)
    func doNotShowUserLocation()
    func configureDistance(_ overlay: MKOverlay)
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
    func configureDistance(_ overlay: MKOverlay) {
        self.mapview.addOverlay(overlay)
        self.mapview.setVisibleMapRect(overlay.boundingMapRect, animated: true)
    }
    
    func doNotShowUserLocation() {
        mapview.showsUserLocation = false
    }
    
    func showUserLocation(region: MKCoordinateRegion) {
        mapview.setRegion(region, animated: true)
    }
    
    func presentBottomSheet(with event: Event,distance: Double) {
        let vc = MapBottomSheetVC(event: event)
        vc.delegate = self
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
        viewModel.selectEvent(with: annotation.event)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .main
        return render
    }
}

extension EventMapVC: GetDirectionDelegate {
    func getDirection(coordinate destinationCoordinate: CLLocationCoordinate2D) {
        if !mapview.overlays.isEmpty {
            mapview.removeOverlays(mapview.overlays)
        }
        viewModel.getDirection(coordinate: destinationCoordinate)
    }
}
