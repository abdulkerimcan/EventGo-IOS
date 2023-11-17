//
//  UIViewController+Ext.swift
//  EventGo
//
//  Created by Abdulkerim Can on 18.10.2023.
//

import UIKit
import SnapKit

extension UIViewController {
    func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 10, right: 20)
        let itemWidth = CGFloat.dWidth
        layout.itemSize = CGSize(width: itemWidth * 0.9, height: itemWidth * 0.4)
        return layout
    }
    
}
