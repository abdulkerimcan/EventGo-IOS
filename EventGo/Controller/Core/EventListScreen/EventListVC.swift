//
//  EventListVC.swift
//  EventGo
//
//  Created by Abdulkerim Can on 11.10.2023.
//

import UIKit

protocol EventListVCDelegate: AnyObject {
    func configureVC()
}

final class EventListVC: UIViewController {
    
    private lazy var viewModel = EventListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    @objc private func navigateToCreateEvent() {
        DispatchQueue.main.async {
            let vc = CreateEventVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension EventListVC: EventListVCDelegate {
    func configureVC() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create Event", style: .done, target: self, action: #selector(navigateToCreateEvent))
    }
}
