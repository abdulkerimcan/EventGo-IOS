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
    func didTapSaveChangesButton(fullname: String,gender: String,birthday: String,imageData: Data?)
}

final class EditProfileViewModel {
    weak var view: EditProfileVCDelegate?
}

extension EditProfileViewModel: EditProfileViewModelDelegate {
    func didTapSaveChangesButton(fullname: String,gender: String,birthday: String,imageData: Data?) {
        view?.startSpinner()
        guard let id = UserConstants.user?.id,
              let userEmail = UserConstants.user?.email else {
            view?.showAlert(title: "Error", message: "Error occured", okAction: {
                
            })
            return
        }
        var updatedFields: [String:Any] = [:]
        updatedFields[UserFields.fullname.rawValue] = fullname
        updatedFields[UserFields.gender.rawValue] = gender
        updatedFields[UserFields.dateOfBirth.rawValue] = birthday
        
        NetworkManager.shared.update(id: id, updatedFields: updatedFields, path: .users, data: imageData) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let url):
                guard let user = UserConstants.user else {
                    return
                }
                var editedUser = user
                editedUser.email = userEmail
                editedUser.fullname = fullname
                editedUser.image = url
                editedUser.dateOfBirth = birthday
                editedUser.gender = gender
                UserDefaults.standard.saveUser(user: user, forKey: "user")
                
                strongSelf.view?.stopSpinner()
                strongSelf.view?.navigateBack()
            case .failure(let failure):
                strongSelf.view?.showAlert(title: "Error", message: failure.localizedDescription, okAction: {
                    strongSelf.view?.navigateBack()
                })
            }
        }
    }
    
    func viewDidLoad() {
        view?.configureVC(with: UserConstants.user)
        view?.configureStackView()
        view?.configureProfileImageView(with: UserConstants.user?.image ?? "")
        view?.configureDivider()
        view?.configureTextfield()
        view?.configureDropDown()
        view?.configureDateOfBirth()
        view?.configureSpinner()
        view?.configureSaveChangesBtn()
        
    }
    
    func didTapDateOfBirth(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
}
