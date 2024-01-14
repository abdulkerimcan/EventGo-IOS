//
//  HomeViewModel.swift
//  EventGo
//
//  Created by Abdulkerim Can on 11.10.2023.
//

import Foundation
import RxSwift
import RxRelay
import RxDataSources

protocol HomeViewModelDelegate {
    var view: HomeVCDelegate? {get set}
    func viewDidLoad()
    func fetchEvents()
    func getEvent(indexPath: IndexPath)
}

final class HomeViewModel {
    weak var view: HomeVCDelegate?
    private let disposeBag   = DisposeBag()
    var eventList = BehaviorRelay<[EventSectionModel]>(value: [])
}

extension HomeViewModel: HomeViewModelDelegate {
    func getEvent(indexPath: IndexPath) {
        let event = eventList.value[indexPath.section].items[indexPath.item]
        self.view?.navigateToDetail(with: event)
    }
    func fetchEvents() {
        
        NetworkManager.shared.getMultipleDatas(type: Event.self, whereField: EventFields.ownerId,isEqual: false, isEqualTo: UserConstants.user?.id, path: .posts) { result in
            switch result {
            case .success(let success):
                var newSection = self.eventList.value
                var featuredEvents:[Event] = []
                if success.count > 2 {
                    for i in 0...2 {
                        featuredEvents.append(success[i])
                    }
                }
                let featuredItems = EventSectionModel(items: featuredEvents, sectionName: .featured)
                
                let partyItems = EventSectionModel(items: success.filter{
                    $0.type == .party
                }, sectionName: .party)
                
                let concertItems = EventSectionModel(items: success.filter{
                    $0.type == .concert
                }, sectionName: .concert)
                
                let sportItems = EventSectionModel(items: success.filter{
                    $0.type == .sport
                }, sectionName: .sport)
                
                let theatrItems = EventSectionModel(items: success.filter{
                    $0.type == .theatr
                }, sectionName: .theatr)
                
                newSection.append(featuredItems)
                newSection.append(partyItems)
                newSection.append(concertItems)
                newSection.append(theatrItems)
                newSection.append(sportItems)
                
                self.eventList.accept(newSection)
            case .failure(let failure):
                print(failure.localizedDescription)
                self.eventList.accept([])
            }
        }
    }
    
    func viewDidLoad() {
        fetchEvents()
        view?.configureVC()
        view?.bindCollectionView()
    }
}

