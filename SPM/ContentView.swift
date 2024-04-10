//
//  ContentView.swift
//  SPM
//
//  Created by Manish Parihar on 27.03.24.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

/*
struct ContentView: View {

    @State private var users : [User] = []
    @State private var products : [Product] = []
    
    var body: some View {
        ScrollView {
            
            VStack {
                ForEach(users) { user in
                    Text(user.firstName)
                        .foregroundStyle(.spotifyGreen)
                }
            }
            .padding()
            .task {
                await getData()
            }
        }
    }
    
    private func getData() async {
        do {
            users =  try await DatabaseHelper().getUsers()
            products = try await DatabaseHelper().getProducts()
        } catch  {
            
        }
    }
}
*/

struct ContentView: View {
    @Environment(\.router) var router
    var body: some View {
        List {
            Button("Open Spotify") {
                router.showScreen(.fullScreenCover) { _ in
                        SpotifyHomeView()
                }
            }
            
            Button("Open Bumble") {
                router.showScreen(.fullScreenCover) { _ in
                        BumbleHomeView()
                }
            }
        }
    }
}

#Preview {
    RouterView { _ in
        ContentView()
    }
}
