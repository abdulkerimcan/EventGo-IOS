//
//  ProfileViewModel.swift
//  EventGo
//
//  Created by Abdulkerim Can on 19.10.2023.
//

import Foundation

protocol ProfileViewModelDelegate {
    var view: ProfileVCDelegate? {get set}
    func viewDidLoad()
    func viewWillAppear()
}

final class ProfileViewModel {
    weak var view: ProfileVCDelegate?
}

extension ProfileViewModel: ProfileViewModelDelegate {
    func viewWillAppear() {
        view?.prepareVC(with: UserConstants.user)
        view?.prepareProfileImage(with: UserConstants.user?.image ?? "")
    }
    
    func viewDidLoad() {
        view?.configureVC()
        view?.configureProfileImage()
        view?.configureFollowingSection()
        view?.configureAboutSection()
    }
}
