//
//  SpotifyPlaylistView.swift
//  SPM
//
//  Created by Manish Parihar on 07.04.24.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct SpotifyPlaylistView: View {
    
    @Environment(\.router) var router
    
    var product: Product = .mock
    var user: User = .mock
    
    @State private var products: [Product] = []
    @State private var showHeader: Bool = true
    @State private var offset: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                LazyVStack(spacing:12) {
                    
                    PlaylistHeaderView(
                        height: 250,
                        title: product.title,
                        subtitle: product.brand,
                        imageName: product.thumbnail
                    )
                    .readingFrame { frame in
                        showHeader = frame.maxY < 150
                    }

                    
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
                    
                    ForEach(products) {product in
                        SongRowCell(
                            imageSize: 50,
                            imageName: product.firstImage,
                            title: product.title,
                            subtitle: product.brand,
                            onCellPressed: {
                                goToPlaylistView(product: product)
                            },
                            onEllipsisPressed: {
                                
                            }
                        )
                        .padding(.leading, 16)
                    }
                }
            }
            .scrollIndicators(.hidden)
            
            /*
            Text("\(offset)")
                .background(Color.red)
            */
            
           header
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for:.navigationBar)
    }
    
    private func getData() async {
        do {
            products = try await DatabaseHelper().getProducts()
        } catch  {
            
        }
    }
    
    private func goToPlaylistView(product: Product) {
        
        router.showScreen(.push) {_ in
                SpotifyPlaylistView(product: product, user: user)
        }
    }

    
    private var header: some View {
        ZStack {
            Text(product.title)
                .font(.headline)
                .padding(.vertical, 20)
                .frame(maxWidth:.infinity)
                .background(Color.spotifyBlack)
                .offset(y: showHeader ? 0 : -40)
                .opacity(showHeader ? 1 : 0)
            
            Image(systemName: "chevron.left")
                .font(.title3)
                .padding(10)
                .background(showHeader ? Color.spotifyGray.opacity(0.001) : Color.spotifyGray.opacity(0.7))
                .clipShape(Circle())
                .onTapGesture {
                    router.dismissScreen()
                }
                .padding(.leading,16)
                .frame(maxWidth:.infinity, alignment: .leading)
        }
        .foregroundStyle(.spotifyWhite)
        .animation(.smooth(duration:0.2), value: showHeader)
    }
}

#Preview {
    RouterView {_ in
        SpotifyPlaylistView()
    }
}
