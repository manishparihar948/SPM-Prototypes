//
//  BumbleHomeView.swift
//  SPM
//
//  Created by Manish Parihar on 09.04.24.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct BumbleHomeView: View {
    
    @Environment(\.router) var router
    @State private var filters : [String] = ["Everyone", "Trending"]
    // @State private var selectedFilter = "Everyone" // instead we use to store user filters into AppStorage
    @AppStorage("bumble_home_filter") private var selectedFilter = "Everyone"
    
    @State private var allUsers: [User] = []
    @State private var selectedIndex: Int = 0 // to make previous, current and next view in memorey and rest will load when profile calls
    @State private var cardOffsets: [Int:Bool] = [:] // Maked dictionary of integer and boolean , UserId: (Direction is Right == TRUE)
    @State private var currentSwipeOffset: CGFloat = 0 // not required now
    
    var body: some View {
        ZStack {
            Color.bumbleWhite.ignoresSafeArea()
            
            VStack(spacing:8) {
                header
                
                BumbleFilterView(options: filters, selection: $selectedFilter)
                    .background(Divider(), alignment: .bottom)
                
                // BumbleCardView()
                
                ZStack{
                    if !allUsers.isEmpty {
                        ForEach(Array(allUsers.enumerated()), id: \.offset) { (index, user) in
                            
                            let isPrevious = (selectedIndex - 1) == index
                            let isCurrent = selectedIndex == index
                            let isNext = (selectedIndex + 1) == index
                            
                            if isPrevious || isCurrent || isNext {
                                let offsetValue = cardOffsets[user.id]
                                
                                userProfileCell(user: user ,index: index)
                                    .zIndex(Double(allUsers.count - index)) // We want to reverse the order coz without this, it will show user profile in sequence which we dont want. Example 100 - 0,
                                    .offset(x: offsetValue == nil ? 0 : offsetValue == true ? 900 : -900)
                            }
                        }
                    } else {
                        ProgressView()
                    }
                    
                    overlaySwipingIndicators
                            .zIndex(999999)
                }
                .frame(maxWidth: .infinity)
                .padding(8)
                .animation(.smooth, value: currentSwipeOffset)
            }
            .padding(8)
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    
    private func userDidSelect(index: Int, isLike: Bool) {
        let user = allUsers[index]
        cardOffsets[user.id] = isLike
        
        selectedIndex += 1
    }
    
    private func getData() async {
        guard allUsers.isEmpty else { return }
        do {
            allUsers =  try await DatabaseHelper().getUsers()
        } catch  {
            
        }
    }
    
    private var header: some View {
        HStack(spacing: 0){
            HStack(spacing: 0){
                Image(systemName: "line.horizontal.3")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        router.dismissScreen()
                    }
                
                Image(systemName: "arrow.uturn.left")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        router.dismissScreen()
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
                    router.showScreen(.push) { _ in
                        BumbleChatsView()
                    }
                }
        }
        .font(.title2)
        .fontWeight(.medium)
        .foregroundStyle(.bumbleBlack)
    }
    
    private func userProfileCell(user: User ,index:Int) -> some View {
        /*
         Rectangle()
         .fill(index == 0 ? Color.red : Color.blue)
         .overlay(
         Text("\(currentSwipeOffset)")
         )
         */
        BumbleCardView(
            user: user,
            onSendAComplimentPressed: nil,
            onSuperLikePressed: nil,
            onXmarkPressed: {
                userDidSelect(index: index, isLike: false)
            },
            onCheckmarkPressed: {
                userDidSelect(index: index, isLike: true)
            },
            onHideAndReportPressed: {
                
            }
        )
        .withDragGesture(
            .horizontal,
            minimumDistance: 10, // use minimum distance otherwise scroll will not work with DragGesture
            resets: true,
            //animation: <#T##Animation#>,
            rotationMultiplier: 1.05,
            //scaleMultiplier: 0.8,
            onChanged: { dragOffset in
                currentSwipeOffset = dragOffset.width
            },
            onEnded: { dragOffset in
                if dragOffset.width < -50 {
                    userDidSelect(index: index, isLike: false)
                } else if dragOffset.width > 50 {
                    userDidSelect(index: index, isLike: true)
                }
                
            }
        )
    }
    
    private var overlaySwipingIndicators : some View {
        ZStack {
            Circle()
                .fill(.bumbleGray.opacity(0.4))
                .overlay(
                    Image(systemName: "xmark")
                        .font(.title)
                        .fontWeight(.semibold)
                )
                .frame(width: 60, height: 60)
                .scaleEffect(abs(currentSwipeOffset) > 100 ? 1.5 : 1.0)
                .offset(x: min(-currentSwipeOffset, 150))
                .offset(x: -100)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Circle()
                .fill(.bumbleGray.opacity(0.4))
                .overlay(
                    Image(systemName: "checkmark")
                        .font(.title)
                        .fontWeight(.semibold)
                )
                .frame(width: 60, height: 60)
                .scaleEffect(abs(currentSwipeOffset) > 100 ? 1.5 : 1.0)
                .offset(x: max(-currentSwipeOffset, -150))
                .offset(x: 100)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

#Preview {
    RouterView { _ in
        BumbleHomeView()
    }
}
