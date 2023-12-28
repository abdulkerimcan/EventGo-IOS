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
    func getEvent(indexPath: IndexPath)
}

final class HomeViewModel {
    weak var view: HomeVCDelegate?
    var sections: [EventSection] = [.featured,.concert,.sport,.theatr,.party,.newest]
    var events: [Event] = []
    var featuredEvents: [Event] = []
}

extension HomeViewModel: HomeViewModelDelegate {
    func getEvent(indexPath: IndexPath) {
        let section = sections[indexPath.section]
        switch section {
        case .featured:
            view?.navigateToDetail(with: featuredEvents[indexPath.item])
        case .newest:
            view?.navigateToDetail(with: events[indexPath.item])
        default:
            view?.navigateToDetail(with: getFilteredEvents(eventType: section)[indexPath.item])
        }
    }
    func fetchEvents() {
        
        NetworkManager.shared.getMultipleDatas(type: Event.self, path: .posts) { result in
            switch result {
            case .success(let success):
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
            
            if event.type.rawValue.elementsEqual(eventType.rawValue) {
                return true
            }
            return false
        }
        
        return filteredEvents
    }
}

