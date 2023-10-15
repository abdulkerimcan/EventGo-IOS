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
}

final class EventListViewModel {
    weak var view: EventListVCDelegate?
    
}

extension EventListViewModel: EventListViewModelDelegate {
    func viewDidLoad() {
        view?.configureVC()
    }
}
