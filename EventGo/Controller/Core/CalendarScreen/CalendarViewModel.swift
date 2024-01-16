//
//  CalendarViewModel.swift
//  EventGo
//
//  Created by Abdulkerim Can on 18.10.2023.
//

import Foundation
import RxRelay

protocol CalendarViewModelDelegate {
    var view: CalendarVCDelegate? {get set}
    func viewDidLoad()
    func fetchEvents(date: Date)
    func formatDate(date: Date) -> String
    func getEvent(indexPath: IndexPath)
}

final class CalendarViewModel {
    let eventList = BehaviorRelay<[Event]>(value: [])
    weak var view: CalendarVCDelegate?
}

extension CalendarViewModel: CalendarViewModelDelegate {
    
    func getEvent(indexPath: IndexPath) {
        let event = eventList.value[indexPath.item]
        self.view?.navigateToDetail(with: event)
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
    
    func fetchEvents(date: Date) {
        
        let dateString = formatDate(date: date)
        NetworkManager.shared.getMultipleDatas(type: Event.self,whereField: EventFields.date,isEqualTo: dateString,path: .posts) { result in
            switch result {
            case .success(let success):
                self.eventList.accept(success)
                self.view?.reloadDate()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
    }
    
    func viewDidLoad() {
        view?.configureVC()
        view?.configureDatePicker()
        view?.bindCollectionView()
        fetchEvents(date: .now)
    }
}
