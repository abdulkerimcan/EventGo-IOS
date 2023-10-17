//
//  CustomDropDown.swift
//  EventGo
//
//  Created by Abdulkerim Can on 13.10.2023.
//

import UIKit
import iOSDropDown

class CustomDropDown: DropDown {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        backgroundColor = .label
        selectedRowColor = UIColor(named: "mainColor") ?? .secondaryMain
        cornerRadius = 10
        backgroundColor = .secondarySystemBackground
        let leftPaddingView = UIView(frame: CGRectMake(0, 0, 15, frame.height))
        leftView = leftPaddingView
        leftViewMode = .always
        arrowSize = 10
        arrowColor = .label
        textColor = .label
    }
}
