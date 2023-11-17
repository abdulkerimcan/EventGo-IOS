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
            view?.showAlert(title: "Invalid E-mail", message: "Please enter a valid e-mail ", okAction: {
                self.view?.stopSpinner()
            })
            return
        }
        if !ValidationManager.shared.isPasswordValid(for: password) {
            view?.showAlert(title: "Invalid password", message: "Please enter a valid password", okAction: {
                self.view?.stopSpinner()
            })
            return
        }
    }
    
    func login(email: String, password: String) {
        view?.startSpinner()
        NetworkManager.shared.login(email: email, password: password) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let userId):
                if let userId = userId {
                    NetworkManager.shared.getSingleData(type: User.self, documentId: userId, path: .users) { result in
                        switch result {
                        case .success(let user):
                            UserDefaults.standard.saveUser(user: user, forKey: "user")
                            strongSelf.view?.stopSpinner()
                            strongSelf.view?.navigateToHomeScreen()
                        case .failure(let failure):
                            strongSelf.view?.showAlert(title: "Login Error", message: failure.localizedDescription, okAction: {
                                strongSelf.view?.stopSpinner()
                            })
                        }
                    }
                }
            case .failure(let failure):
                strongSelf.view?.showAlert(title: "Login Error", message: failure.localizedDescription, okAction: {
                    strongSelf.view?.stopSpinner()
                })
            }
        }
    }
    
    func viewDidLoad() {
        view?.configureVC()
        view?.configureUI()
        view?.configureSpinner()
    }
}
