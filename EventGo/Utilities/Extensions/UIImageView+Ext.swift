//
//  UIImageView+Ext.swift
//  EventGo
//
//  Created by Abdulkerim Can on 20.10.2023.
//

import UIKit

extension UIImageView {
    func makeRounded() {
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height/2 //This will change with corners of image and height/2 will make this circle shape
        self.clipsToBounds = true
    }
}
