//
//  FeaturedCollectionViewCell.swift
//  EventGo
//
//  Created by Abdulkerim Can on 11.10.2023.
//

import UIKit

final class FeaturedCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FeaturedCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        layer.cornerRadius = 20
    }
    
    func changeColor(color: UIColor) {
        backgroundColor = color
    }
}
