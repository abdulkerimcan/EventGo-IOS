//
//  CalendarViewModel.swift
//  EventGo
//
//  Created by Abdulkerim Can on 18.10.2023.
//

import Foundation


protocol CalendarViewModelDelegate {
    var view: CalendarVCDelegate? {get set}
    func viewDidLoad()
    func fetchEvents(date: Date)
    func formatDate(date: Date) ->String
}

final class CalendarViewModel {
    
    weak var view: CalendarVCDelegate?
    var events: [Event] = []
}

extension CalendarViewModel: CalendarViewModelDelegate {
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
    
    func fetchEvents(date: Date) {
        
        let dateString = formatDate(date: date)
        events.removeAll(keepingCapacity: false)
        NetworkManager.shared.getMultipleDatas(type: Event.self,whereField: EventFields.date,isEqualTo: dateString,path: .posts) { result in
            switch result {
            case .success(let success):
                self.events.append(contentsOf: success)
                self.view?.reloadDate()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
    }
    
    func viewDidLoad() {
        view?.configureVC()
        view?.configureDatePicker()
        view?.configureCollectionView()
        fetchEvents(date: .now)
    }
}
