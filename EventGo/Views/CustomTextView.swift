//
//  AuthTextView.swift
//  EventGo
//
//  Created by Abdulkerim Can on 9.10.2023.
//

import UIKit

final class CustomTextField: UITextField {
    private var placeHolder: String?
    
    init(placeHolder: String?) {
        self.placeHolder = placeHolder
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 10
        returnKeyType = .done
        let paddingView = UIView(frame: CGRectMake(0, 0, 15, self.frame.height))
        leftView = paddingView
        leftViewMode = .always
        placeholder = placeHolder
    }
}
