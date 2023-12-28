//
//  EventDetailViewModel.swift
//  EventGo
//
//  Created by Abdulkerim Can on 29.12.2023.
//

import Foundation

protocol EventDetailViewModelDelegate {
    var view: EventDetailVCDelegate? {get set}
    func getOrganizer(completion: @escaping (User?) ->())
    func viewDidLoad()
}

final class EventDetailViewModel {
    weak var view: EventDetailVCDelegate?
    var event: Event
    var sections: [EventDetailSection] = [.photo,.info,.location,.organizer]
    init(event: Event) {
        self.event = event
    }
}

extension EventDetailViewModel: EventDetailViewModelDelegate {
    func getOrganizer(completion: @escaping (User?) ->()){
        
        NetworkManager.shared.getSingleData(type: User.self, documentId: event.ownerId, path: .users) { result in
            switch result {
            case .success(let user):
                completion(user)
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    func viewDidLoad() {
        view?.configureVC()
        view?.configureCollectionView()
    }
}
