//
//  VibeDetail.swift
//  VibeChecker
//
//  Created by Toph Allen on 7/1/20.
//

import SwiftUI

struct VibeDetail: View {
    @ObservedObject var vibe: Vibe
    @Binding var selectedTrack: Track?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Divider().padding(0)
            NavigationView {
                List(selection: $selectedTrack) {
                    ForEach(vibe.tracks?.allObjects as! [Track]) { track in
                        TrackRow(track).tag(track)
                    }
                }
                Text("stuff goes here")
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }

    }
}

//struct VibeDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        VibeDetail()
//    }
//}
