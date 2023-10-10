//
//  AuthButton.swift
//  EventGo
//
//  Created by Abdulkerim Can on 9.10.2023.
//

import UIKit

final class AuthButton: UIButton {
    
    enum FontSize {
        case large
        case medium
        case small
    }
    
    init(title: String, hasBackground: Bool = false,fontSize: FontSize) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        backgroundColor = hasBackground ? UIColor(named: "mainColor") : .clear
        
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
