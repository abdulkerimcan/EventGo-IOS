//
//  SearchViewModel.swift
//  EventGo
//
//  Created by Abdulkerim Can on 1.01.2024.
//

import Foundation
import RxSwift
import RxRelay

protocol SearchViewModelDelegate {
    var view: SearchVCDelegate? {get set}
    func viewDidLoad()
    func getEvent(indexPath: IndexPath)
    func search(searchText: String?,events: [EventSectionModel])
}

final class SearchViewModel {
    var eventList = BehaviorRelay<[Event]>(value: [])
    weak var view: SearchVCDelegate?
}

extension SearchViewModel: SearchViewModelDelegate {
    func getEvent(indexPath: IndexPath) {
        let event = eventList.value[indexPath.item]
        self.view?.navigateToDetail(with: event)
    }
    
    func search(searchText: String?,events: [EventSectionModel]) {
        guard let searchText else {
            view?.reloadData()
            return
        }
        let allEvents = events.flatMap {
            $0.items
        }.filter {
            $0.name.lowercased().contains(searchText.lowercased())
        }
        eventList.accept(allEvents)
        view?.reloadData()
    }
    
    func viewDidLoad() {
        view?.configureCollectionView()
    }
}
