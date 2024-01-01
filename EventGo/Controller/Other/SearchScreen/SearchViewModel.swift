//
//  SearchViewModel.swift
//  EventGo
//
//  Created by Abdulkerim Can on 1.01.2024.
//

import Foundation

protocol SearchViewModelDelegate {
    var view: SearchVCDelegate? {get set}
    func viewDidLoad()
    func search(searchText: String?,events: [Event])
}

final class SearchViewModel {
    
    lazy var events: [Event] = []
    weak var view: SearchVCDelegate?
}

extension SearchViewModel: SearchViewModelDelegate {
    
    func search(searchText: String?,events: [Event]) {
        guard let searchText else {
            view?.reloadData()
            return
        }
        self.events = events.filter({ event in
            event.name.lowercased().contains(searchText.lowercased())
        })
        view?.reloadData()
    }
    
    func viewDidLoad() {
        view?.configureCollectionView()
    }
}
