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
}

final class SignUpViewModel {
    weak var view: SignUpVCDelegate?
}

extension SignUpViewModel: SignUpViewModelDelegate{
    func viewDidLoad() {
        view?.configureVC()
        view?.configureUI()
    }
}
