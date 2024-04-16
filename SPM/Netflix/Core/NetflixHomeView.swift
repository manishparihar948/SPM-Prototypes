//
//  NetflixHomeView.swift
//  SPM
//
//  Created by Manish Parihar on 12.04.24.
//

import SwiftUI
import SwiftfulUI

struct NetflixHomeView: View {
    
    @State private var filters = FilterModel.mockArray
    @State private var selectedFilters : FilterModel? = nil
    @State private var fulHeaderSize: CGSize = .zero
    
    @State private var heroProduct : Product? = nil
    @State private var currentUser: User? = nil
    @State private var productRows: [ProductRow] = []
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.netflixBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                VStack(spacing:8){
                    Rectangle()
                        .opacity(0)
                        .frame(height: fulHeaderSize.height)
                    
                    if let heroProduct {
                       
                        heroCell(product: heroProduct)
                    }
                    
                    categoryRows
                }
            }
            .scrollIndicators(.hidden)
            
            VStack(spacing:0) {
                header
                    .padding(.horizontal, 16)
                
                NetflixFilterBarView(
                    filters: filters,
                    selectedFilter: selectedFilters,
                    onFilterPressed: { newFilter in
                        Task {
                            // This stask used for you want to do something before view get updated
                            try? await Task.sleep(nanoseconds:1_000_000_000)
                            selectedFilters = newFilter
                        }
                    },
                    onXMarkPressed: {
                        selectedFilters = nil
                    }
                )
                .padding(.top, 16)
            }
            .background(Color.blue)
            .readingFrame { frame in
                fulHeaderSize = frame.size
                
            }
        }
        .foregroundStyle(.netflixWhite)
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private func getData() async {
        guard productRows.isEmpty else { return }
        do {
            currentUser  =  try await DatabaseHelper().getUsers().first
            let products = try await DatabaseHelper().getProducts()
            heroProduct  = products.first
            
            var rows: [ProductRow] = []
            let allBrands = Set(products.map({ $0.brand }))
            for brand in allBrands {
                // let products = self.products.filter({$0.brand == brand })
                rows.append(ProductRow(title: brand.capitalized, products: products))
            }
            productRows = rows
        } catch  {
            
        }
    }
    
    private var header: some View {
        HStack(spacing:0) {
            Text("For You")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
            
            HStack(spacing:16){
                Image(systemName: "tv.badge.wifi")
                    .onTapGesture {
                        
                    }
                
                Image(systemName: "magnifyingglass")
                    .onTapGesture {
                        
                    }
            }
        }
    }
    
    private func heroCell(product: Product) -> some View {
        NetflixHeroCell(
            imageName: product.firstImage,
            isNetflixFilm: true,
            title: product.title,
            categories: [product.category.capitalized, product.brand],
            onBackgroundPressed: {
                
            },
            onPlayPressed: {
                
            },
            onMyListPressed: {
                
            }
        )
        .padding(24)
    }
    
    private var categoryRows: some View {
        LazyVStack(spacing:16) {
            ForEach(Array(productRows.enumerated()), id:\.offset) { (rowIndex,  row) in
                VStack(alignment:.leading, spacing: 6) {
                    Text(row.title)
                        .font(.headline)
                        .padding(.horizontal, 16)
                    
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(Array(row.products.enumerated()), id:\.offset) { (index, product) in
                                NetflixMovieCell(
                                    imageName: product.firstImage,
                                    title: product.title,
                                    isRecentlyAdded: product.recentlyAdded,
                                    topTenRanking: rowIndex == 1 ? (index + 1) : nil
                                )
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    .scrollIndicators(.hidden)
                }
            }
        }
    }
    
}

#Preview {
    NetflixHomeView()
}
