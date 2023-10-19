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
}

final class ProfileViewModel {
    weak var view: ProfileVCDelegate?
}

extension ProfileViewModel: ProfileViewModelDelegate {
    func viewDidLoad() {
        view?.configureProfileImage()
        view?.configureFollowingSection()
        view?.configureAboutSection()
    }
}
