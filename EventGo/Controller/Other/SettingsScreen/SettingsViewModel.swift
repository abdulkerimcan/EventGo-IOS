//
//  SettingsViewModel.swift
//  EventGo
//
//  Created by Abdulkerim Can on 20.10.2023.
//

import Foundation

protocol SettingsViewModelDelegate {
    var view: SettingsVCDelegate? {get set}
    func viewDidLoad()
    func logout()
}

final class SettingsViewModel {
    weak var view: SettingsVCDelegate?
    
}

extension SettingsViewModel: SettingsViewModelDelegate {
    func logout() {
        NetworkManager.shared.logout {[weak self] error in
            guard let self = self else {return}
            if let error = error {
                self.view?.showLogoutErrorAlert(error: error)
                return
            }
            self.view?.navigateToLogin()
        }
    }
    
    func viewDidLoad() {
        view?.configureVC()
    }
}
