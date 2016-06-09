//
//  User.swift
//  RestApp
//
//  Created by Macrinici Dan on 6/9/16.
//  Copyright © 2016 Daniel Macrinici. All rights reserved.
//

import Foundation

class User {
    var name, email, password, gender: String
    var yearOfBirth: Int
    
    init(name: String, email: String, password: String, yearOfBirth: Int, gender: String) {
        self.name = name
        self.email = email
        self.password = password
        self.gender = gender
        self.yearOfBirth = yearOfBirth
    }
    
    convenience init() {
        self.init(name: "Unnamed", email: "No email", password: "No password", yearOfBirth: 2000, gender: "Undefined")
    }
    
}