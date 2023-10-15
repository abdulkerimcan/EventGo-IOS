//
//  HomeScreenEventCollectionViewCell.swift
//  EventGo
//
//  Created by Abdulkerim Can on 11.10.2023.
//

import UIKit
import SnapKit

final class HomeScreenEventCollectionViewCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "onboard1")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "17 Dec"
        label.backgroundColor = .tertiarySystemBackground
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        return label
    }()
    
    private let eventNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Bastau Concert"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let eventCategoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Music"
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor(named: "mainColor")?.cgColor
        label.textColor = UIColor(named: "mainColor")
        label.layer.cornerRadius = 5
        label.font = .systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    private let locationImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "mappin.and.ellipse.circle.fill")
        image.tintColor = UIColor(named: "mainColor")
        return image
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.text = "Antalya, Türkiye"
        return label
    }()

    static let identifier = "HomeScreenEventCollectionViewCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func setUI() {
        backgroundColor = UIColor(named: "secondaryMainColor")
        layer.cornerRadius = 20
        layer.borderWidth = 0.5
        layer.borderColor = UIColor(named: "mainColor")?.cgColor
        clipsToBounds = true
        addSubviews(imageView,eventNameLabel,eventCategoryLabel,locationImageView,locationLabel)
        imageView.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(self.layer.frame.height * 0.6)
            make.width.equalToSuperview()
        }
        
        eventNameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview()
        }
        
        eventCategoryLabel.snp.makeConstraints { make in
            make.top.equalTo(eventNameLabel.snp.bottom).offset(10)
            make.left.equalTo(eventNameLabel)
        }
        
        locationImageView.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.top.equalTo(eventCategoryLabel.snp.bottom).offset(5)
            make.left.equalTo(eventCategoryLabel)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.left.equalTo(locationImageView.snp.right).offset(5)
            make.centerY.equalTo(locationImageView)
        }
    }
}
