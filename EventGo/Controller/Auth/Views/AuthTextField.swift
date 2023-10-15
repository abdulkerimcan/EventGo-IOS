//
//  AuthTextView.swift
//  EventGo
//
//  Created by Abdulkerim Can on 9.10.2023.
//

import UIKit

final class AuthTextField: UITextField {
    private var textFieldType: TextFieldType
    enum TextFieldType: String {
        case email
        case password
    }
    
    init(textFieldType: TextFieldType) {
        self.textFieldType = textFieldType
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
        autocorrectionType = .no
        autocapitalizationType = .none
        let paddingView = UIView(frame: CGRectMake(0, 0, 15, self.frame.height))
        leftView = paddingView
        leftViewMode = .always
        
        switch textFieldType {
        case .email:
            placeholder = "Email"
            keyboardType = .emailAddress
            textContentType = .emailAddress
        case .password:
            placeholder = "Password"
            textContentType = .oneTimeCode
            isSecureTextEntry = true
        }
    }
}
