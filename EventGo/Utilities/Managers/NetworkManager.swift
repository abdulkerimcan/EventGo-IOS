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
}

extension NetworkManager {
    
    ///  function to register new user
    /// - Parameters:
    ///   - email: The user's e-mail adress
    ///   - password: The user's password
    ///   - completion: completion with two values
    ///   - Bool: isRegistered - This email address is already in use or not
    ///   - Error?: firebase error
    func register(user: User,password: String, completion: @escaping (Bool,Error?) -> ()) {
        Auth.auth().createUser(withEmail: user.email, password: password) { result, error in
            
            if let error = error {
                completion(true,error)
                return
            }
            guard let result = result else {
                completion(true,nil)
                return
            }
            let newUser = User(id: result.user.uid,email: user.email, fullname: user.fullname, dateOfBirth: user.dateOfBirth, gender: user.gender)
            
            self.post(entity: newUser, path: .users) { error in
                if let error = error {
                    completion(true,error)
                }
                UserDefaults.standard.saveUser(user: newUser, forKey: "user")
            }
            
            completion(false,nil)
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Result<String?,Error>) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(
                .success(result?.user.uid))
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
    
    func updateArrayField(id: String,path:CollectionPath, field: String, value: Event, completion: @escaping (Error?) -> ()) {
        do {
            let eventData = try Firestore.Encoder().encode(value)
            db.collection(path.rawValue).document(id).updateData([field: FieldValue.arrayUnion([eventData])]) { error in
                if let error = error {
                    completion(error)
                    return
                }
                
                completion(nil)
            }
        }catch let error {
            completion(error)
        }
        
    }
    
    func update(id: String,
                updatedFields: [String : Any],
                path: CollectionPath,
                data: Data?,
                completion: @escaping (Result<String?,Error>) -> ()) {
        
        guard let data = data else {
            db.collection(path.rawValue).document(id).updateData(updatedFields) { error in
                if let error = error {
                    completion(.failure(error))
                }
                completion(.success(nil))
            }
            return
        }
        
        upload(id: id, path: path, data: data) { result in
            switch result {
            case .success(let urlString):
                var mutableUpdatedFields = updatedFields
                mutableUpdatedFields["image"] = urlString
                self.db.collection(path.rawValue).document(id).updateData(updatedFields) { error in
                    if let error = error {
                        completion(.failure(error))
                    }
                    
                    completion(.success(urlString))
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    func upload(id: String, path: CollectionPath, data: Data, completion: @escaping (Result<String,Error>) -> ()) {
        let postReference = ref.child("\(path.rawValue)/\(id).jpeg")
        postReference.putData(data,metadata: nil) { storageData, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            postReference.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let url = url else {
                    completion(.failure(ErrorTypes.documentNotFound))
                    return
                }
                completion(.success(url.absoluteString))
            }
        }
    }
    func post<T: BaseModelProtocol>(entity: T,
                                    data: Data? = nil,
                                    path: CollectionPath,
                                    completion: @escaping (Error?) -> ()) {
        guard let entityId = entity.id else {
            completion(ErrorTypes.documentNotFound)
            return
        }
        
        guard let data = data else {
            do {
                let dictionaryEntity = try entity.asDictionary()
                db.collection(path.rawValue).document(entityId).setData(dictionaryEntity)
                completion(nil)
            } catch let error {
                completion(error)
            }
            return
        }
        
        upload(id: entityId, path: .posts, data: data) { result in
            switch result {
            case .success(let urlString):
                var newEntity = entity
                newEntity.image = urlString
                do {
                    try self.db.collection(path.rawValue).document(entityId).setData(from: newEntity)
                    
                    completion(nil)
                } catch let error {
                    completion(error)
                }
            case .failure(let failure):
                completion(failure)
            }
        }
    }
    func getSingleData<T:Codable>(type: T.Type,
                                  documentId: String,
                                  path: CollectionPath,
                                  completion: @escaping (Result<T,Error>) -> ()) {
        let query = db.collection(path.rawValue).document(documentId)
        query.getDocument(as: type) { result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func getMultipleDatas<T: Codable>(type: T.Type,
                                      whereField: Fields? = nil,
                                      isEqual: Bool? = true,
                                      isEqualTo: Any? = nil,
                                      path: CollectionPath,
                                      completion: @escaping (Result<[T],Error>) -> ()) {
        var datas: [T] = []
        var query: Query = db.collection(path.rawValue)
        
        if let field = whereField , let value = isEqualTo {
            if isEqual ?? true {
                query = query.whereField(field.rawValue, isEqualTo: value)
            } else {
                query = query.whereField(field.rawValue, isNotEqualTo: value)
            }
            
        }
        query.getDocuments { snp, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let snp = snp else {
                completion(.failure(ErrorTypes.documentNotFound))
                return
            }
            for document in snp.documents {
                do {
                    let data = try document.data(as: T.self)
                    datas.append(data)
                } catch let error {
                    completion(.failure(error))
                }
            }
            completion(.success(datas))
        }
    }
}

enum CollectionPath: String, Codable {
    case users = "Users"
    case posts = "posts"
}

protocol Fields {
    var rawValue: String { get }
}

enum EventFields: String, Codable, Fields {
    
    case date = "date"
    case name = "name"
    case id = "id"
    case ownerId = "ownerId"
    case type = "type"
    case time = "time"
    case price = "price"
}

enum UserFields: String, Codable, Fields {
    case id = "id"
    case dateOfBirth = "dateOfBirth"
    case fullname = "fullname"
    case email = "email"
    case gender = "gender"
    case followers = "followers"
    case followings = "followings"
    case events = "events"
}

protocol BaseModelProtocol: Codable {
    var id: String? {get set}
    var image: String? { get set}
    
    func asDictionary() throws -> [String: Any]
}

extension BaseModelProtocol {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw ErrorTypes.serializationFailed
        }
        return dictionary
    }
}

enum ErrorTypes: Error {
    case documentNotFound
    case typeNotMatch
    case serializationFailed
}

