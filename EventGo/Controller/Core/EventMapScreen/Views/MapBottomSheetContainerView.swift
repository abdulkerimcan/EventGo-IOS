//
//  MapBottomSheetContainerView.swift
//  EventGo
//
//  Created by Abdulkerim Can on 18.10.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class MapBottomSheetContainerView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .tertiarySystemBackground
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        return label
    }()
    
    private let eventNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let eventTypeLabel: UILabel = {
        let label = UILabel()
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        clipsToBounds = true
        layer.cornerRadius = 10
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.tertiarySystemBackground.cgColor
        
        addSubviews(imageView,
                    eventNameLabel,
                    eventTypeLabel,
                    locationLabel,
                    locationImageView,
                    dateLabel)
        imageView.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(CGFloat.dWidth * 0.4)
            make.top.left.bottom.equalToSuperview()
        }
        
        eventNameLabel.snp.makeConstraints { make in
            make.left.equalTo(imageView.snp.right).offset(10)
            make.top.equalToSuperview().offset(20)
        }
        
        eventTypeLabel.snp.makeConstraints { make in
            make.left.equalTo(eventNameLabel)
            make.centerY.equalToSuperview()
        }
        
        locationImageView.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.bottom.equalToSuperview().offset(-20)
            make.left.equalTo(eventTypeLabel)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.left.equalTo(locationImageView.snp.right).offset(5)
            make.centerY.equalTo(locationImageView)
        }
        
    }
    
    func configure(with event: Event) {
        eventNameLabel.text = event.name
        locationLabel.text = event.location
        eventTypeLabel.text = event.type.rawValue
        dateLabel.text = event.date
        
        let url = URL(string: event.image ?? "")
        imageView.kf.setImage(with: url)
    }
}
