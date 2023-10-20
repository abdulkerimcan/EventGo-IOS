//
//  NetworkManager.swift
//  EventGo
//
//  Created by Abdulkerim Can on 9.10.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import FirebaseFirestoreSwift

final class NetworkManager {
    static let shared = NetworkManager()
    private let db = Firestore.firestore()
    private let ref = Storage.storage().reference()
    private init() {}
    
    enum errorTypes: Error {
        case documentNotFound
    }
}

extension NetworkManager {
    
    ///  function to register new user
    /// - Parameters:
    ///   - email: The user's e-mail adress
    ///   - password: The user's password
    ///   - completion: completion with two values
    ///   - Bool: isRegistered - This email address is already in use or not
    ///   - Error?: firebase error
    func register(email: String, password: String, completion: @escaping (Bool,Error?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            if let error = error {
                completion(true,error)
                return
            }
            guard let result = result else {
                completion(true,nil)
                return
            }
            let user = User(id: result.user.uid, email: result.user.email,image: nil)
            do {
                try self.db.collection("Users").document(result.user.uid).setData(from: user)
            } catch let error {
                completion(true,error)
                return
            }
            
            completion(false,nil)
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(error)
                return
            }
            completion(nil)
        }
    }
    
    func logout(completion: @escaping (Error?) -> ()) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error{
            completion(error)
        }
    }
    
    func fetchEvents(completion: @escaping (Result<[Event]?,Error>) -> ()) {
        var events: [Event] = []
        db.collection("posts").getDocuments { snp, error in
            
            if let error = error {
                completion(.failure(error))
            }
            guard let snp = snp else {
                completion(.failure(errorTypes.documentNotFound))
                return
            }
            
            for document in snp.documents {
                do {
                    let event = try document.data(as: Event.self)
                    events.append(event)
                } catch let error {
                    completion(.failure(error))
                }
            }
            completion(.success(events))
        }
        
    }
    
    func postEvent(event: Event,data: Data?,completion: @escaping (Error?) -> ()){
        let postImageRef = ref.child("postImages/\(event.id).jpeg")
        
        guard let data = data else {
            return
        }
        
        let uploadTask = postImageRef.putData(data, metadata: nil) { storageData, error in
            
            if let error = error {
                completion(error)
                return
            }
            
            postImageRef.downloadURL { url, error in
                if let error = error {
                    completion(error)
                    return
                }
                guard let url = url else {
                    return
                }
                
                let newEvent = Event(id: event.id,
                                     ownerId: event.ownerId,
                                     image: url.absoluteString,
                                     name: event.name,
                                     type: event.type,
                                     date: event.date,
                                     time: event.time,
                                     price: event.price,
                                     location: event.location,
                                     latitude: event.latitude,
                                     longitude: event.longitude)
                do {
                    try self.db.collection("posts").document(newEvent.id).setData(from: newEvent)
                    completion(nil)
                } catch let error {
                    completion(error)
                }
            }
        }
        uploadTask.resume()
    }
    
    
    func fetchEventsOnDate(dateString: String, completion: @escaping (Result<[Event]?,Error>) -> ()) {
        
        var events: [Event] = []
        
        db.collection("posts").whereField("date", isEqualTo: dateString).getDocuments { snp, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let snp = snp else {
                completion(.failure(errorTypes.documentNotFound))
                return
            }
            
            for document in snp.documents {
                do {
                    let event = try document.data(as: Event.self)
                    events.append(event)
                } catch let error {
                    completion(.failure(error))
                }
            }
            completion(.success(events))
            
        }
    }
    
}
