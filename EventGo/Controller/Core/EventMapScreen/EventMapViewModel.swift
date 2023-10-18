//
//  EventMapViewModel.swift
//  EventGo
//
//  Created by Abdulkerim Can on 17.10.2023.
//

import Foundation

protocol EventMapViewModelDelegate {
    var view: EventMapVCDelegate? {get set}
    func viewDidLoad()
    func fetchEvents()
}

final class EventMapViewModel {
    weak var view: EventMapVCDelegate?
    var events: [Event] = []
}

extension EventMapViewModel: EventMapViewModelDelegate {
    
    func fetchEvents() {
        NetworkManager.shared.fetchEvents { result in
            switch result {
            case .success(let success):
                guard let fetchedList = success else {return}
                self.events.append(contentsOf: fetchedList)
                self.view?.configureEventAnnotations(events: self.events)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func viewDidLoad() {
        view?.configureMapView()
        fetchEvents()
    }
}
