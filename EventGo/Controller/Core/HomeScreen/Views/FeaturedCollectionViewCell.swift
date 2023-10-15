//
//  FeaturedCollectionViewCell.swift
//  EventGo
//
//  Created by Abdulkerim Can on 11.10.2023.
//

import UIKit
import SnapKit

final class FeaturedCollectionViewCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "onboard1")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let eventNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.clipsToBounds = true
        label.text = "International Concert"
        label.textColor = .white
        label.backgroundColor = .black
        label.layer.cornerRadius = 5
        
        return label
    }()
    
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
        clipsToBounds = true
        layer.borderWidth = 0.5
        layer.borderColor = UIColor(named: "mainColor")?.cgColor
        
        addSubviews(imageView)
        imageView.addSubview(eventNameLabel)
        imageView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
        
        
        eventNameLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-30)
            make.left.equalToSuperview().offset(20)
        }
        
    }
}
