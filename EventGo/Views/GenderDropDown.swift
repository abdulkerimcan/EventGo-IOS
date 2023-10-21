//
//  GenderDropDown.swift
//  EventGo
//
//  Created by Abdulkerim Can on 21.10.2023.
//

import UIKit
import iOSDropDown

class GenderDropDown: DropDown {
    
    var genderArray: [GenderEnum] = [.male,.female,.unknown]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUI() {
        backgroundColor = .label
        placeholder = "Select Gender"
        selectedRowColor = UIColor(named: "mainColor") ?? .secondaryMain
        cornerRadius = 10
        isSearchEnable = false
        backgroundColor = .secondarySystemBackground
        let leftPaddingView = UIView(frame: CGRectMake(0, 0, 15, frame.height))
        leftView = leftPaddingView
        leftViewMode = .always
        arrowSize = 10
        arrowColor = .label
        textColor = .label
        
        optionArray = genderArray.compactMap({ gender in
            gender.rawValue
        })
    }
}
