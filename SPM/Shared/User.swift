//
//  User.swift
//  SPM
//
//  Created by Manish Parihar on 03.04.24.
//

import Foundation

struct UserArray: Codable {
    let users: [User]
    let total, skip, limit: Int?
}

// MARK: - User
struct User: Codable, Identifiable {
    let id: Int?
    let firstName, lastName: String
    let age: Int
    let email, phone, username, password: String
    let image: String
    let height: Int?
    let weight: Double?
    
    static var mock: User {
        User(
            id: 555,
            firstName: "Manish",
            lastName: "Parihar",
            age: 30,
            email: "app@app.com",
            phone: "+44-12456789",
            username: "",
            password: "",
            image: Constants.randomImage,
            height: 180,
            weight: 200
        )
    }
}


