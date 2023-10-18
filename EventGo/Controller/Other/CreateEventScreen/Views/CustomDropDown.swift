//
//  CustomDropDown.swift
//  EventGo
//
//  Created by Abdulkerim Can on 13.10.2023.
//

import UIKit
import iOSDropDown

class CustomDropDown: DropDown {
    var sectionsArray: [EventSection]
    init(sectionsArray: [EventSection]) {
        self.sectionsArray = sectionsArray
        super.init(frame: .zero)
        setUI()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUI() {
        backgroundColor = .label
        placeholder = "Select Type"
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
        
        optionArray = sectionsArray.compactMap({ EventType in
            EventType.rawValue
        })
        
    }
}
