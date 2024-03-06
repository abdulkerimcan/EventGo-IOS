//
//  AuthButton.swift
//  EventGo
//
//  Created by Abdulkerim Can on 9.10.2023.
//

import UIKit
import SnapKit

final class CustomButton: UIButton {
    
    enum FontSize {
        case large
        case medium
        case small
    }
    
    init(title: String, hasBackground: Bool = false,fontSize: FontSize) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        layer.cornerRadius = 20
        layer.masksToBounds = true
        backgroundColor = hasBackground ? UIColor(named: "mainColor") : .clear
        titleLabel?.snp.makeConstraints({ make in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
        })
        let titleColor: UIColor? = hasBackground ? .white : UIColor(named: "mainColor")
        setTitleColor(titleColor, for: .normal)
        
        switch fontSize {
            
        case .large:
            titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        case .medium:
            titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        case .small:
            titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
