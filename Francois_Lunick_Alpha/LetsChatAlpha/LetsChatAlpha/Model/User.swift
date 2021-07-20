//
//  User.swift
//  LetsChatAlpha
//
//  Created by Lunick Francois on 7/19/21.
//

import Foundation

struct User {
    let email: String
    let name: String
    let password: String
    let uid: String
    
    init(dictionary: [String: Any]) {
        
        self.email = dictionary["email"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.password = dictionary["password"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
