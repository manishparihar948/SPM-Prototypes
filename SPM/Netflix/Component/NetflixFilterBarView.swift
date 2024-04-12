//
//  NetflixFilterBarView.swift
//  SPM
//
//  Created by Manish Parihar on 12.04.24.
//

import SwiftUI

struct FilterModel: Hashable, Equatable {
    let title: String
    let isDropdown: Bool
    
    static var mockArray: [FilterModel] {
        [
            FilterModel(title: "TV Shows", isDropdown: false),
            FilterModel(title: "Movies", isDropdown: false),
            FilterModel(title: "Categories", isDropdown: true),
        ]
    }
    
}

struct NetflixFilterBarView: View {
    
    var filters: [FilterModel] = FilterModel.mockArray
    //@State private var selectedFilter : FilterModel? = nil // if we make it @State so we can access inside this class so instead we remove @State private tto access from outside
    var selectedFilter : FilterModel? = nil
    var onFilterPressed: ((FilterModel) -> Void)? = nil
    var onXMarkPressed: (()-> Void)? = nil
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                if selectedFilter != nil {
                    Image(systemName: "xmark")
                        .padding(8)
                        .background(
                            Circle()
                                .stroke(lineWidth: 1)
                        )
                        .foregroundStyle(.netflixLightGray)
                        .background(Color.black.opacity(0.001))
                        .onTapGesture {
                            onXMarkPressed?()
                        }
                        .transition(AnyTransition.move(edge: .leading))
                        .padding(.leading, 16)

                }
                
                ForEach(filters, id:\.self) { filter in
                    
                    if selectedFilter == nil || selectedFilter == filter {
                        NetflixFilterCell(
                            title: filter.title,
                            isDropdown: filter.isDropdown,
                            isSelected: selectedFilter == filter
                        )
                        .background(Color.black.opacity(0.001))
                        .onTapGesture {
                            onFilterPressed?(filter)
                        }
                        .padding(.leading, ((selectedFilter == nil) && filter == filters.first) ? 16 : 0)
                    }
                }
            }
            .padding(.vertical, 4)
        }
        .scrollIndicators(.hidden)
        .animation(.bouncy, value: selectedFilter)
    }
}

fileprivate struct NetflixFilterBarViewPreview: View {
    
    @State private var filters = FilterModel.mockArray
    @State private var selectedFilters : FilterModel? = nil
    
    var body: some View {
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
    }
}

#Preview {
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        
        NetflixFilterBarViewPreview()
    }
}
