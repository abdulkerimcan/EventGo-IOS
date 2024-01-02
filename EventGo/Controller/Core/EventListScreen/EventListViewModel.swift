//
//  EventListViewModel.swift
//  EventGo
//
//  Created by Abdulkerim Can on 12.10.2023.
//

import Foundation

protocol EventListViewModelDelegate {
    var view: EventListVCDelegate? {get set}
    func viewDidLoad()
    func fetchEvents()
}

final class EventListViewModel {
    weak var view: EventListVCDelegate?
    lazy var events: [Event] = []
    
}

extension EventListViewModel: EventListViewModelDelegate {
    func fetchEvents() {
        NetworkManager.shared.getMultipleDatas(type: Event.self,whereField: EventFields.ownerId,isEqual: true,isEqualTo: UserConstants.user?.id, path: .posts) { result in
            switch result {
            case .success(let success):
                self.events.append(contentsOf: success)
                self.view?.reloadData()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func viewDidLoad() {
        fetchEvents()
        view?.configureVC()
        view?.configureCollectionView()
    }
}
