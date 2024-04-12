//
//  NetflixHomeView.swift
//  SPM
//
//  Created by Manish Parihar on 12.04.24.
//

import SwiftUI

struct NetflixHomeView: View {
    
    @State private var filters = FilterModel.mockArray
    @State private var selectedFilters : FilterModel? = nil
    
    var body: some View {
        ZStack {
            Color.netflixBlack.ignoresSafeArea()
            
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
                
                Spacer()
            }
        }
        .foregroundStyle(.netflixWhite)
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
}

#Preview {
    NetflixHomeView()
}
