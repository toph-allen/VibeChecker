//
//  VibeToken.swift
//  VibeChecker
//
//  Created by Toph Allen on 7/1/20.
//

import SwiftUI

enum VibeTokenSize {
    case small, medium, large
}

struct VibeToken: View {
    let name: String
    let size: VibeTokenSize = .small
    
    var body: some View {
        Text(name)
            .font(.callout)
            .foregroundColor(.white)
            .lineLimit(1)
            .truncationMode(.middle)
            .padding(.horizontal, 3)
            .padding(.vertical, 1)
            .background(Color.accentColor)
            .cornerRadius(5.0)
//            .frame(minWidth: 50, idealWidth: 20)
    }
}


//struct WrappedTokenView {
//    var vibeNames: [String]
//
//    var body: some View {
//
//    }
//}


struct VibeTokens_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VibeToken(name: "Trippy")
            VibeToken(name: "This is a super long token title")
        }
    }
}
