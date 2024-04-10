//
//  InterestPilllGridView.swift
//  SPM
//
//  Created by Manish Parihar on 09.04.24.
//

import SwiftUI
import SwiftfulUI

struct UserInterest: Identifiable {
    let id = UUID().uuidString
    var iconName : String? = nil
    var emoji: String? = nil
    var text: String
}

struct InterestPilllGridView: View {
    
    var interests: [UserInterest] = User.mock.interests
    
    var body: some View {
        ZStack {
            NonLazyVGrid(
                columns: 2,
                alignment: .leading,
                spacing: 8,
                items: interests) { interest in
                    if let interest {
                        InterestPillView(
                            iconName: interest.iconName,
                            emoji: interest.emoji,
                            text: interest.text
                        )
                    } else {
                        EmptyView()
                    }
                }
        }
    }
}

#Preview {
    VStack(spacing: 40) {
        InterestPilllGridView(interests: User.mock.basics)
        InterestPilllGridView(interests: User.mock.interests)
    }
}
