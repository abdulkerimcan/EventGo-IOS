//
//  HomeVC.swift
//  EventGo
//
//  Created by Abdulkerim Can on 10.10.2023.
//

import UIKit

final class HomeVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "logout", style: .plain, target: self, action: #selector(logout))
    }
    
    @objc func logout() {
        
        NetworkManager.shared.logout { [weak self] error in
            guard let self = self else {
                return
            }
            
            if let error = error {
                AlertManager.shared.showLogoutErrorAlert(on: self, error: error)
                return
            }
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkCurrentUser()
            }
        }
    }
}
