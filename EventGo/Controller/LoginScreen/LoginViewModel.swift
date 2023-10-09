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
}

final class LoginViewModel {
    weak var view: LoginVCDelegate?
}

extension LoginViewModel: LoginViewModelDelegate{
    
    func viewDidLoad() {
        view?.configureVC()
        view?.configureUI()
    }
}
