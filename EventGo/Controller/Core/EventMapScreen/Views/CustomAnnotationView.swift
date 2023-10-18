//
//  CustomAnnotationView.swift
//  EventGo
//
//  Created by Abdulkerim Can on 17.10.2023.
//

import UIKit
import MapKit
import SnapKit

class CustomAnnotationView: MKAnnotationView {
    
    var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(150)
            make.height.equalTo(150)
        }
    }
}
