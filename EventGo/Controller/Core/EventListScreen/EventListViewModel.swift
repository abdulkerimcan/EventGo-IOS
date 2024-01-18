//
//  EventListViewModel.swift
//  EventGo
//
//  Created by Abdulkerim Can on 12.10.2023.
//

import Foundation
import RxRelay

protocol EventListViewModelDelegate {
    var view: EventListVCDelegate? {get set}
    func viewDidLoad()
    func fetchEvents()
    func getEvent(indexPath: IndexPath)
}

final class EventListViewModel {
    weak var view: EventListVCDelegate?
    let eventList = BehaviorRelay<[Event]>(value: [])
}

extension EventListViewModel: EventListViewModelDelegate {
    func getEvent(indexPath: IndexPath) {
        let event = eventList.value[indexPath.item]
        self.view?.navigateToDetail(with: event)
    }
    
    func fetchEvents() {
        NetworkManager.shared.getMultipleDatas(type: Event.self,whereField: EventFields.ownerId,isEqual: true,isEqualTo: UserConstants.user?.id, path: .posts) { result in
            switch result {
            case .success(let success):
                self.eventList.accept(success)
                self.view?.reloadData()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func viewDidLoad() {
        fetchEvents()
        view?.configureVC()
        view?.bindCollectionView()
    }
}
