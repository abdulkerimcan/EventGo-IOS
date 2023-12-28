//
//  EventDetailInfoCollectionViewCell.swift
//  EventGo
//
//  Created by Abdulkerim Can on 29.12.2023.
//

import UIKit
import SnapKit

final class EventDetailInfoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "EventDetailInfoCollectionViewCell"
    
    private lazy var eventNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    
    private lazy var calendarImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(systemName: "calendar.circle.fill")
        imageview.tintColor = .main
        return imageview
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private lazy var hourLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .thin)
        return label
    }()
    
    private lazy var addCalendarBtn = CustomButton(title: "Add to My Calendar", hasBackground: false, fontSize: .small)
    
    private lazy var locationImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(systemName: "mappin.circle.fill")
        imageview.tintColor = .main
        return imageview
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private lazy var seeOnMapBtn = CustomButton(title: "See on Map", hasBackground: false, fontSize: .small)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        addSubviews(eventNameLabel,
                    calendarImageView,
                    dateLabel,
                    hourLabel,
                    addCalendarBtn,
                    locationImageView,
                    locationLabel,
                    seeOnMapBtn)
        
        eventNameLabel.snp.makeConstraints { make in
            make.left.top.equalTo(20)
        }
        
        calendarImageView.snp.makeConstraints { make in
            make.left.equalTo(eventNameLabel)
            make.top.equalTo(eventNameLabel.snp.bottom).offset(10)
            make.height.width.equalTo(60)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(calendarImageView)
            make.left.equalTo(calendarImageView.snp.right).offset(10)
        }
        
        hourLabel.snp.makeConstraints { make in
            make.left.equalTo(dateLabel)
            make.top.equalTo(dateLabel.snp.bottom).offset(2)
        }
        
        addCalendarBtn.snp.makeConstraints { make in
            make.top.equalTo(hourLabel.snp.bottom).offset(2)
            make.left.equalTo(hourLabel)
        }
        
        locationImageView.snp.makeConstraints { make in
            make.left.equalTo(calendarImageView)
            make.top.equalTo(addCalendarBtn.snp.bottom).offset(10)
            make.height.width.equalTo(60)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(locationImageView)
            make.left.equalTo(locationImageView.snp.right).offset(10)
        }
        
        seeOnMapBtn.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(2)
            make.left.equalTo(locationLabel)
        }
    }
    
    func configureCell(with event: Event) {
        eventNameLabel.text = event.name
        dateLabel.text = event.date
        hourLabel.text = event.time
        locationLabel.text = event.location
    }
}

