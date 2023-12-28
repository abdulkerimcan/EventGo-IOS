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
                   eventType: EventSection,
                   eventDateText: String,
                   eventTimeText: String,
                   eventPriceText: String,
                   eventLocationText: String,
                   eventCoordinateTuple: (latitude: Double,longitude: Double),
                   imageData: Data?)
}

final class CreateEventViewModel {
    
    weak var view: CreateEventVCDelegate?
    var eventTypes: [EventSection] = [.concert,.party,.sport,.theatr]
    
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
        eventType: EventSection,
        eventDateText: String,
        eventTimeText: String,
        eventPriceText: String,
        eventLocationText: String,
        eventCoordinateTuple: (latitude: Double,longitude: Double),
        imageData: Data?) {
            
            let eventId = UUID().uuidString
            
            guard let userId = UserConstants.user?.id else {
                return
            }
            
            let event = Event(id: eventId,
                              ownerId: userId,
                              image: imageData?.base64EncodedString(),
                              name: eventNameText,
                              type: eventType,
                              date: eventDateText,
                              time: eventTimeText,
                              price: eventPriceText,
                              location: eventLocationText,
                              latitude: eventCoordinateTuple.latitude,
                              longitude: eventCoordinateTuple.longitude)
            
            
            NetworkManager.shared.post(entity: event, data: imageData, path: .posts) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                NetworkManager.shared.updateArrayField(id: userId, path: .users, field: UserFields.events.rawValue, value: event) { error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    guard let user = UserConstants.user else {
                        return
                    }
                    var updatedUser = user
                    updatedUser.events.append(event)
                    UserDefaults.standard.saveUser(user: updatedUser, forKey: "user")
                    self.view?.navigateToTabVC()
                }
            }
        }
}

