//
//  LoginViewModel.swift
//  EventGo
//
//  Created by Abdulkerim Can on 8.10.2023.
//

import Foundation

protocol LoginViewModelDelegate {
    var view: LoginVCDelegate? {get set}
    func viewDidLoad()
    func validate(email: String, password: String)
    func login(email: String, password: String)
}

final class LoginViewModel {
    weak var view: LoginVCDelegate?
}

extension LoginViewModel: LoginViewModelDelegate{
    func validate(email: String, password: String) {
        
        if !ValidationManager.shared.isValidEmail(for: email) {
            view?.showInvalidEmailError()
            return
        }
        if !ValidationManager.shared.isPasswordValid(for: password) {
            view?.showInvalidPasswordError()
            return
        }
    }
    
    func login(email: String, password: String) {
        NetworkManager.shared.login(email: email, password: password) { [weak self] error in
            guard let self = self else {
                return
            }
            if let error = error {
                self.view?.showLoginError(error: error)
                return
            }
            self.view?.navigateToHomeScreen()
        }
    }
    
    
    func viewDidLoad() {
        view?.configureVC()
        view?.configureUI()
    }
}
