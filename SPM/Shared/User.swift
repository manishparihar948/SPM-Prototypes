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
    let id: Int
    let firstName, lastName: String
    let age: Int
    let email, phone, username, password: String
    let image: String
    let height: Int
    let weight: Double
    
    var work : String {
        "Works as Data Scientist"
    }
    
    var eduction : String {
        "Post Graduate Degree"
    }
    
    var aboutMe : String {
        "This is a sentence about me that will look good on my profile"
    }
    
    var basics: [UserInterest] {
        [
            UserInterest(iconName: "ruler", emoji: nil, text: "\(height)"),
            UserInterest(iconName: "graduationcap", emoji: nil, text: eduction),
            UserInterest(iconName: "wineglass", emoji: nil, text: "Socially"),
            UserInterest(iconName: "moon.stars.fill", emoji: nil, text: "Virgo"),
        ]
    }
    
    var interests: [UserInterest] {
        [
            UserInterest(iconName: nil, emoji: "🍳", text: "Cooking"),
            UserInterest(iconName: nil, emoji: "📚", text: "Study"),
            UserInterest(iconName: nil, emoji: "🚴", text: "Sport"),
            UserInterest(iconName: nil, emoji: "🎧", text: "Music"),
        ]
    }
    
    var images: [String] {
        ["https://picsum.photos/500/500",
         "https://picsum.photos/600/600",
         "https://picsum.photos/700/700"
        ]
    }
    
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


