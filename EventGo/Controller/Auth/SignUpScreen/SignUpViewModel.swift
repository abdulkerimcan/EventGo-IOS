//
//  LoginViewModel.swift
//  EventGo
//
//  Created by Abdulkerim Can on 8.10.2023.
//

import Foundation

protocol SignUpViewModelDelegate {
    var view: SignUpVCDelegate? {get set}
    func viewDidLoad()
    func validate(email: String, password: String)
    func register(email: String, password: String)
}

final class SignUpViewModel {
    weak var view: SignUpVCDelegate?
}

extension SignUpViewModel: SignUpViewModelDelegate{
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
    func viewDidLoad() {
        view?.configureVC()
        view?.configureUI()
    }
    
    func register(email: String, password: String) {
        NetworkManager.shared.register(email: email, password: password) {
            [weak self] isRegistered, error in
            
            guard let self = self else {
                return
            }
            
            if let error = error {
                self.view?.showRegisterError(error: error)
                return
            }
            
            if isRegistered {
                self.view?.showRegisterError()
                return
            }
            
            self.view?.navigateToHomeScreen()
        }
    }
}
