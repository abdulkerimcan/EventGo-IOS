//
//  UIStackView+Ext.swift
//  EventGo
//
//  Created by Abdulkerim Can on 24.10.2023.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { view in
            addArrangedSubview(view)
        }
    }
}
