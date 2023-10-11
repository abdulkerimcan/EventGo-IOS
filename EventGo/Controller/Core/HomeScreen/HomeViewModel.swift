//
//  HomeViewModel.swift
//  EventGo
//
//  Created by Abdulkerim Can on 11.10.2023.
//

import Foundation

protocol HomeViewModelDelegate {
    var view: HomeVCDelegate? {get set}
    func viewDidLoad()
}

final class HomeViewModel {
    weak var view: HomeVCDelegate?
    var sections: [HomeSections] = [.featured,.trending,.nearby,.newest]
}

extension HomeViewModel: HomeViewModelDelegate {
    func viewDidLoad() {
        view?.configureVC()
        view?.configureCollectionView()
    }
}
