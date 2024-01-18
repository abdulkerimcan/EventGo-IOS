//
//  MapBottomSheetVC.swift
//  EventGo
//
//  Created by Abdulkerim Can on 18.10.2023.
//

import UIKit
import SnapKit

final class MapBottomSheetVC: UIViewController {
    
    private lazy var container = MapBottomSheetContainerView(frame: .zero)
    
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
    @objc private func didTapContainer() {
        navigateToDetail(with: event)
    }
    
    private func setUI() {
        view.backgroundColor =  .secondaryMain
        container.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapContainer))
        container.addGestureRecognizer(gesture)
        view.addSubview(container)
        
        container.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(40)
            make.bottom.equalToSuperview().offset(-60)
        }
        container.configure(with: event)
    }
    private func navigateToDetail(with event : Event) {
        DispatchQueue.main.async {
            let vc = EventDetailVC(event: event)
            self.present(vc, animated: true)
            
        }
    }
}
