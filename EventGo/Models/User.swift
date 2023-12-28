//
//  User.swift
//  EventGo
//
//  Created by Abdulkerim Can on 10.10.2023.
//

import Foundation

struct User: Codable, BaseModelProtocol {
    var image: String?

    var id: String?
    var email: String
    var fullname: String
    var followers: [String]
    var followings: [String]
    var events: [Event]
    var dateOfBirth: String
    var gender: String
    
    init(id: String? = nil,
         email: String,
         fullname: String,
         followers: [String] = [],
         image: String? = nil,
         followings: [String] = [],
         events: [Event] = [],
         dateOfBirth: String,
         gender: String) {
        
        self.id = id
        self.email = email
        self.fullname = fullname
        self.image = image
        self.followers = followers
        self.followings = followings
        self.events = events
        self.dateOfBirth = dateOfBirth
        self.gender = gender
    }
}

