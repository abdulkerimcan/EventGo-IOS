//
//  EventDetailLocationCollectionViewCell.swift
//  EventGo
//
//  Created by Abdulkerim Can on 29.12.2023.
//

import UIKit
import SnapKit
import MapKit

final class EventDetailLocationCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "EventDetailLocationCollectionViewCell"
    
    private lazy var mapView: MKMapView = {
        let mapview = MKMapView()
        mapview.layer.cornerRadius = 10
        return mapview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    
    func configureMap(with event: Event) {
        let eventCoordinate = CLLocationCoordinate2D(latitude: event.latitude, longitude: event.longitude)
        let pin = CustomAnnotationPin(event: event, coordinate: eventCoordinate)
        mapView.addAnnotation(pin)
        let region = MKCoordinateRegion(center: eventCoordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = false
    }
}

