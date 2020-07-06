//
//  VibeDetail.swift
//  VibeChecker
//
//  Created by Toph Allen on 7/1/20.
//

import SwiftUI

struct VibeDetail: View {
    @ObservedObject var vibe: Vibe
    @State var selectedTrack: Track?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Divider()
            NavigationView {
                List(selection: $selectedTrack) {
                    ForEach(vibe.tracks?.allObjects as! [Track]) { track in
                        TrackRow(track).tag(track)
                    }
                }
                if selectedTrack != nil {
                    // This is actually a track detail view or an inspector
                    TrackDetail(track: selectedTrack!)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    Text("No Track Selected")
                        .font(.title)
                        .fontWeight(.light)
                        .foregroundColor(.tertiaryLabel)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

//struct VibeDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        VibeDetail()
//    }
//}
