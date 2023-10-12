//
//  HeaderCollectionReusableView.swift
//  EventGo
//
//  Created by Abdulkerim Can on 11.10.2023.
//

import UIKit
import SnapKit

final class HeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "HeaderCollectionReusableView"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let seeAllBtn = CustomButton(title: "See All", fontSize: .medium)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    private func setUI() {
        addSubviews(titleLabel,seeAllBtn)
        
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
        seeAllBtn.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
}
