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
    func fetchEvents()
}

final class HomeViewModel {
    weak var view: HomeVCDelegate?
    var sections: [EventSection] = [.featured,.concert,.sport,.theatr,.party,.opera,.newest]
    var events: [Event] = []
    var featuredEvents: [Event] = []
}

extension HomeViewModel: HomeViewModelDelegate {
    func fetchEvents() {
        NetworkManager.shared.fetchEvents { result in
            switch result {
            case .success(let success):
                guard let success = success else {
                    return
                }
                self.events.append(contentsOf: success)
                if self.events.count > 2 {
                    for i in 0...2 {
                        self.featuredEvents.append(self.events[i])
                    }
                }
                self.view?.reloadData()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func viewDidLoad() {
        view?.configureVC()
        view?.configureCollectionView()
        fetchEvents()
    }
    
    func getFilteredEvents(eventType: EventSection) -> [Event] {
        let filteredEvents = events.filter { event in
            if event.type.elementsEqual(eventType.rawValue) {
                return true
            }
            return false
        }
        
        return filteredEvents
    }
}
