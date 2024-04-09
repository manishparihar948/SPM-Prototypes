//
//  BumbleFilterView.swift
//  SPM
//
//  Created by Manish Parihar on 09.04.24.
//

// Top Segment bar
import SwiftUI

struct BumbleFilterView: View {
    
    var options: [String] = ["Everyone", "Trending"]
    // @State private var selection: String  = "Everyone" // becuase we dont want to hardcore everytime instead we use binding
    @Binding var selection: String
    @Namespace private var namespace //used for providing name in matchedGeometry
    
    var body: some View {
        HStack(alignment: .top, spacing: 32) {
            ForEach(options, id:\.self) { option in
                VStack(spacing: 8) {
                    Text(option)
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        //.background(Color.red)
                    
                    if selection == option {
                        RoundedRectangle(cornerRadius: 2)
                            .frame(height : 1.5)
                            .matchedGeometryEffect(id: "selection", in: namespace) // For animate the bar below the text
                    }
                }.padding(.top, 8)
                .background(Color.black.opacity(0.001))
                .foregroundStyle(selection == option ? .bumbleBlack : .bumbleGray)
                .onTapGesture {
                    selection = option
                }
            }
        }
        .animation(.smooth, value: selection)
    }
}

fileprivate struct BumbleFilterViewPreview: View {
    
    var options: [String] = ["Everyone", "Trending"]
    @State private var selection = "Everyone"
    
    var body: some View {
        BumbleFilterView(options: options, selection: $selection)
    }
}

#Preview {
    BumbleFilterViewPreview()
        .padding()
}

/*
#Preview {
    BumbleFilterView()
        .padding()
}
*/
