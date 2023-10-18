//
//  MKAnnotationView+Ext.swift
//  EventGo
//
//  Created by Abdulkerim Can on 17.10.2023.
//

import Foundation
import MapKit

extension MKAnnotationView {

    public func setPin(image: UIImage = UIImage(systemName: "mappin.circle.fill")!,
                       with color : UIColor? = nil) {
        let view: UIImageView
        
        
        if let color = color {
            view = UIImageView(image: image.withRenderingMode(.alwaysTemplate))
            view.tintColor = color
        } else {
            view = UIImageView(image: image)
        }
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        guard let graphicsContext = UIGraphicsGetCurrentContext() else { return }
        view.layer.render(in: graphicsContext)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.image = image
    }
}
