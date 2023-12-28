//
//  EventDetailUserInteractionView.swift
//  EventGo
//
//  Created by Abdulkerim Can on 29.12.2023.
//

import UIKit
import SnapKit

final class EventDetailUserInteractionView: UIView {
    
    private lazy var row: UIStackView = {
        let row = UIStackView()
        row.axis = .horizontal
        return row
    }()
    
    private lazy var shareBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "square.and.arrow.up.fill"), for: .normal)
        return btn
    }()
    
    private lazy var saveBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "bookmark"), for: .normal)
        return btn
    }()
    
    private lazy var buyBtn = CustomButton(title: "Buy Ticket", hasBackground: true, fontSize: .medium)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        addSubview(row)
        
        row.addArrangedSubviews(shareBtn,saveBtn,buyBtn)
        
        shareBtn.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
        saveBtn.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
        buyBtn.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
    }
}

