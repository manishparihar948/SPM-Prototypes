//
//  SpotifyPlaylistView.swift
//  SPM
//
//  Created by Manish Parihar on 07.04.24.
//

import SwiftUI

struct SpotifyPlaylistView: View {
    
    var product: Product = .mock
    var user: User = .mock
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                PlaylistHeaderView(
                    height: 250,
                    title: product.title,
                    subtitle: product.brand,
                    imageName: product.thumbnail
                )
                
                // Control + M -> To Expand PlaylistDescriptionView
                PlaylistDescriptionView(
                    descriptionText: product.description,
                    userName: user.firstName,
                    subheadline: product.category,
                    onAddToPlaylistPressed: nil,
                    onDownloadPressed: nil,
                    onSharePressed: nil,
                    onEllipsesPressed: nil,
                    onShufflePressed: nil,
                    onPlayPressed: nil
                )
                .padding(.horizontal, 16)
                
                
            }
        }
    }
}

#Preview {
    SpotifyPlaylistView()
}
