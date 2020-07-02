//
//  TrackRow.swift
//  VibeChecker
//
//  Created by Toph Allen on 7/1/20.
//

import SwiftUI

struct TrackRow: View {
    let track: Track
    init(_ track: Track) {
        self.track = track
    }
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading) {
                Text(track.title ?? "")
                    .font(.headline)
//                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                Text(track.artistName ?? "")
                    .font(.subheadline)
                    .lineLimit(1)
                    .foregroundColor(.secondary)
            }
        }
            .padding(.vertical, 2)
    }
}

//struct TrackRow_Previews: PreviewProvider {
//    static var previews: some View {
//        TrackRow()
//    }
//}
