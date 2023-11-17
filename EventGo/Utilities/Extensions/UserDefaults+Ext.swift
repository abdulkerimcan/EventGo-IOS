//
//  UserDefaults+Ext.swift
//  EventGo
//
//  Created by Abdulkerim Can on 5.11.2023.
//

import Foundation

extension UserDefaults {
    func saveUser(user: User,forKey: String) {
            
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(user)
                UserDefaults.standard.setValue(data, forKey: forKey)
            } catch {
                print(error.localizedDescription)
            }
        }
    
    func getUser(forKey: String) -> User?{
        guard let jsonData = UserDefaults.standard.data(forKey: forKey) else {
            return nil
        }
        do {
            let decoder = JSONDecoder()
            let tasks = try decoder.decode(User.self, from: jsonData)
            return tasks
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
