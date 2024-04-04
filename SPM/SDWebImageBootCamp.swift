//
//  SDWebImageBootCamp.swift
//  SPM
//
//  Created by Manish Parihar on 27.03.24.
//

import SwiftUI
import SDWebImageSwiftUI

struct SDWebImageBootCamp: View {
    var body: some View {
        WebImage(url: URL(string: "https://picsum.photos/id/237/200/300"))
            .onSuccess(perform: { image, data, cacheType in
                
            })
            .onFailure(perform: {error in
                
            })
            .resizable()
    }
}

#Preview {
    SDWebImageBootCamp()
}
