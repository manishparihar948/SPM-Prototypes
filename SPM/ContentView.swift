//
//  ContentView.swift
//  SPM
//
//  Created by Manish Parihar on 27.03.24.
//

import SwiftUI

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

#Preview {
    ContentView()
}
