//
//  CalendarVC.swift
//  EventGo
//
//  Created by Abdulkerim Can on 11.10.2023.
//

import UIKit
import SnapKit

final class CalendarVC: UIViewController {
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: .dWidth, height: .dHeight * 0.3))
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
        }
        print(datePicker)
    }
}
