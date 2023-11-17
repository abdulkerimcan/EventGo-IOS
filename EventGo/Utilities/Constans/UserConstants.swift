//
//  UserConstants.swift
//  EventGo
//
//  Created by Abdulkerim Can on 5.11.2023.
//

import Foundation

final class UserConstants {
    static var user: User? {
         let user = UserDefaults.standard.getUser(forKey: "user")
         return user
    }
}
