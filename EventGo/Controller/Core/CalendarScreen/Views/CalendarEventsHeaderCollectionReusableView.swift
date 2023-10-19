//
//  CalendarEventsHeaderCollectionReusableView.swift
//  EventGo
//
//  Created by Abdulkerim Can on 19.10.2023.
//

import UIKit
import SnapKit

final class CalendarEventsHeaderCollectionReusableView: UICollectionReusableView {
    
    private let eventCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    static let identifier = "CalendarEventsHeaderCollectionReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        addSubview(eventCountLabel)
        
        eventCountLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.bottom.equalToSuperview()
        }
    }
    
    func configureCalendarEventHeader(with count: Int) {
        eventCountLabel.text = "Events (\(count))"
    }
}
