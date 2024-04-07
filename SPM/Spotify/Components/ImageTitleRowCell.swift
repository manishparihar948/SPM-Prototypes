//
//  ImageTitleRowCell.swift
//  SPM
//
//  Created by Manish Parihar on 06.04.24.
//

import SwiftUI

struct ImageTitleRowCell: View {
    
    var imageSize: CGFloat = 100
    var imageName: String = Constants.randomImage
    var titleName: String = "Some Text"
    
    var body: some View {
        VStack(alignment:.leading, spacing: 8) {
            ImageLoaderView(urlString: imageName, resizingMode: .fill)
                .frame(width: imageSize, height: imageSize)
            
            Text(titleName)
                .font(.callout)
                .foregroundStyle(.spotifyLightGray)
                .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                .padding(4)
        }
        .frame(width: imageSize)
        .background(Color.clear)

    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        ImageTitleRowCell()
    }
}
