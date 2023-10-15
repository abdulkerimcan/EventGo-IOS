//
//  UIView+Ext.swift
//  EventGo
//
//  Created by Abdulkerim Can on 9.10.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { view in
            addSubview(view)
        }
    }
}
