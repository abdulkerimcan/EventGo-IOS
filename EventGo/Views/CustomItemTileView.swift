//
//  SettingsItemView.swift
//  EventGo
//
//  Created by Abdulkerim Can on 20.10.2023.
//

import UIKit
import SnapKit

final class CustomItemTileView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let itemNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "chevron.right")
        return imageView
    }()
    
    private let imageName: String
    private let name: String
    private let color: UIColor?
    init(imageName: String = "", name: String,color : UIColor? = nil) {
        self.imageName = imageName
        self.name = name
        self.color = color
        super.init(frame: .zero)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        addSubviews(imageView,
                    itemNameLabel,
                    arrowImageView)
        
        imageView.image = UIImage(systemName: imageName)
        itemNameLabel.text = name
        imageView.tintColor = color
        imageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.bottom.equalToSuperview()
        }
        
        itemNameLabel.snp.makeConstraints { make in
            make.left.equalTo(imageView.snp.right).offset(10)
            make.centerY.equalTo(imageView)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview()
        }
    }
}
