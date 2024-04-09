//
//  BumbleHomeView.swift
//  SPM
//
//  Created by Manish Parihar on 09.04.24.
//

import SwiftUI

struct BumbleHomeView: View {
    
    @State private var filters : [String] = ["Everyone", "Trending"]
    // @State private var selectedFilter = "Everyone" // instead we use to store user filters into AppStorage
    @AppStorage("bumble_home_filter") private var selectedFilter = "Everyone"
    
    var body: some View {
        ZStack {
            Color.bumbleWhite.ignoresSafeArea()
            
            VStack(spacing:8) {
                header
                
                BumbleFilterView(options: filters, selection: $selectedFilter)
                    .background(Divider(), alignment: .bottom)
                
                Spacer()
                
                
            }
            .padding(8)
        }
    }
    
    private var header: some View {
        HStack(spacing: 0){
            HStack(spacing: 0){
                Image(systemName: "line.horizontal.3")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        
                    }
                
                Image(systemName: "arrow.uturn.left")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("bumble")
                .font(.title)
                .fontWeight(.medium)
                .foregroundStyle(.bumbleYellow)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Image(systemName: "slider.horizontal.3")
                .padding(8)
                .background(Color.black.opacity(0.001))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .onTapGesture {
                    
                }
        }
        .font(.title2)
        .fontWeight(.medium)
        .foregroundStyle(.bumbleBlack)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        BumbleHomeView()
    }
}
