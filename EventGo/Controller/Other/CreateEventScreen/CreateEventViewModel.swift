//
//  CreateEventViewModel.swift
//  EventGo
//
//  Created by Abdulkerim Can on 12.10.2023.
//

import Foundation
import FirebaseAuth


protocol CreateEventViewModelDelegate {
    var view: CreateEventVCDelegate? {get set}
    func didTapDateDoneBtn(date: Date) -> String
    func didTapTimeDoneBtn(date: Date) -> String
    func viewDidLoad()
    func postEvent(eventNameText: String,
                   eventTypeText: String,
                   eventDateText: String,
                   eventTimeText: String,
                   eventPriceText: String,
                   eventLocationText: String,
                   eventCoordinateTuple: (latitude: Double,longitude: Double),
                   imageData: Data?)
}

final class CreateEventViewModel {
    weak var view: CreateEventVCDelegate?
    var eventTypes: [EventSection] = [.opera,.concert,.party,.sport,.theatr]
}

extension CreateEventViewModel: CreateEventViewModelDelegate {
    
    
    func didTapTimeDoneBtn(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
    
    func didTapDateDoneBtn(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
    
    func viewDidLoad() {
        view?.configureVC()
        view?.configureCoverView()
        view?.configureEventName()
        view?.configureEventType()
        view?.configureDatePicker()
        view?.configureTimePicker()
        view?.configureEventPrice()
        view?.configureMapView()
        view?.configureCreateEventButton()
    }
    
    func postEvent(
        eventNameText: String,
        eventTypeText: String,
        eventDateText: String,
        eventTimeText: String,
        eventPriceText: String,
        eventLocationText: String,
        eventCoordinateTuple: (latitude: Double,longitude: Double),
        imageData: Data?) {
            
            
            let event = Event(id: UUID().uuidString,
                              ownerId: Auth.auth().currentUser?.uid,
                              image: imageData?.base64EncodedString(),
                              name: eventNameText,
                              type: eventTypeText,
                              date: eventDateText,
                              time: eventTimeText,
                              price: eventPriceText,
                              location: eventLocationText,
                              latitude: eventCoordinateTuple.latitude,
                              longitude: eventCoordinateTuple.longitude)
            
            NetworkManager.shared.postEvent(event: event,data: imageData) { error in
                if let error = error {
                    print("\(error.localizedDescription)")
                    return
                }
                self.view?.navigateToTabVC()
            }
        }
}
