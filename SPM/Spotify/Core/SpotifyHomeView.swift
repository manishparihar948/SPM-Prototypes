//
//  SpotifyHomeView.swift
//  SPM
//
//  Created by Manish Parihar on 03.04.24.
//

import SwiftUI

struct SpotifyHomeView: View {
    var body: some View {
        
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            
            HStack {
                ImageLoaderView()
                    .frame(width: 30, height: 30)
                    .background(.spotifyWhite)
            }
        }
    }
}

#Preview {
    SpotifyHomeView()
}
