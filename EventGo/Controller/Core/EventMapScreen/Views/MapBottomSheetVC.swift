//
//  MapBottomSheetVC.swift
//  EventGo
//
//  Created by Abdulkerim Can on 18.10.2023.
//

import UIKit
import SnapKit

final class MapBottomSheetVC: UIViewController {
    
    private var container: MapBottomSheetContainerView!
    
    private var event: Event
    
    init(event: Event) {
        self.event = event
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        view.backgroundColor = UIColor(named: "secondaryMainColor")
        
        container = MapBottomSheetContainerView(frame: .zero)
        view.addSubview(container)
        
        container.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(40)
            make.bottom.equalToSuperview().offset(-60)
        }
        configure()
    }
    
    func configure() {
        container.configure(with: event)
    }
}
