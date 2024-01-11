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
    var eventList = BehaviorRelay<[ZISectionWrapperModel]>(value: [])
}

extension HomeViewModel: HomeViewModelDelegate {
    func getEvent(indexPath: IndexPath) {
        self.view?.navigateToDetail(with: eventList.value[indexPath.section].items[indexPath.item].data)
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
                let featuredItems = ZISectionWrapperModel(sectionName: .featured, items: ZISectionWrapperModel.convertItemOfAnyToZIWrapperItem(sectionName: .featured, objects: featuredEvents))
                
                let partyItems = ZISectionWrapperModel(sectionName: .party, items: ZISectionWrapperModel.convertItemOfAnyToZIWrapperItem(sectionName: .party, objects: success.filter{
                    $0.type == .party
                }))
                
                let concertItems = ZISectionWrapperModel(sectionName: .concert, items: ZISectionWrapperModel.convertItemOfAnyToZIWrapperItem(sectionName: .concert, objects: success.filter{
                    $0.type == .concert
                }))
                
                let sportItems = ZISectionWrapperModel(sectionName: .sport, items: ZISectionWrapperModel.convertItemOfAnyToZIWrapperItem(sectionName: .sport, objects: success.filter{
                    $0.type == .sport
                }))
                
                let theatrItems = ZISectionWrapperModel(sectionName: .theatr, items: ZISectionWrapperModel.convertItemOfAnyToZIWrapperItem(sectionName: .theatr, objects: success.filter{
                    $0.type == .theatr
                }))
                
                newSection += [featuredItems]
                newSection += [concertItems]
                newSection += [partyItems]
                newSection += [theatrItems]
                newSection += [sportItems]
                
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

