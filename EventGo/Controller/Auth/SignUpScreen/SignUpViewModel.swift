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
    func register(email: String ,fullname:String ,gender: String ,birthDay: String, password: String)
    func didTapDateOfBirth(date: Date) -> String
}

final class SignUpViewModel {
    weak var view: SignUpVCDelegate?
}

extension SignUpViewModel: SignUpViewModelDelegate{
    func validate(email: String, password: String) {
        if !ValidationManager.shared.isValidEmail(for: email) {
            view?.showAlert(title: "Error", message: "Invalid mail entered", okAction: {
                
            })
            return
        }
        if !ValidationManager.shared.isPasswordValid(for: password) {
            view?.showAlert(title: "Error", message: "Invalid password entered", okAction: {
                
            })
            return
        }
    }
    func viewDidLoad() {
        view?.configureVC()
        view?.configureUI()
        view?.configureSpinner()
    }
    
    func register(email: String,fullname:String,gender: String,birthDay: String, password: String) {
        view?.startSpinner()
        let user = User(email: email, fullname: fullname, dateOfBirth: birthDay, gender: gender)
        
        NetworkManager.shared.register(user: user, password: password) {
            [weak self] isRegistered, error in
            
            guard let self = self else {
                return
            }
            
            if let error = error {
                self.view?.showAlert(title: "Error", message: error.localizedDescription, okAction: {
                    
                })
                return
            }
            
            if isRegistered {
                self.view?.showAlert(title: "Error", message: "This mail already registered", okAction: {
                    
                })
                return
            }
            
            self.view?.stopSpinner()
            self.view?.navigateToHomeScreen()
        }
    }
    
    func didTapDateOfBirth(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
}
