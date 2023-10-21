//
//  EditProfileViewModel.swift
//  EventGo
//
//  Created by Abdulkerim Can on 20.10.2023.
//

import Foundation

protocol EditProfileViewModelDelegate {
    var view: EditProfileVCDelegate? {get set}
    func viewDidLoad()
    func didTapDateOfBirth(date: Date) -> String
}

final class EditProfileViewModel {
    weak var view: EditProfileVCDelegate?
}

extension EditProfileViewModel: EditProfileViewModelDelegate {
    func viewDidLoad() {
        view?.configureVC()
        view?.configureProfileImageView()
        view?.configureDivider()
        view?.configureStackView()
        view?.configureTextfield()
        view?.configureDropDown()
        view?.configureDateOfBirth()
        view?.configureSaveChangesBtn()
    }
    
    func didTapDateOfBirth(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
}
