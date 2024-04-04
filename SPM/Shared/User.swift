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
    let firstName, lastName, maidenName: String
    let email, phone, username, password: String
    let birthDate: String?
    let image: String
    let bloodGroup: String?
    let height: Int?
    let weight: Double?
}
