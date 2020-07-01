//
//  PlaylistDetail.swift
//  VibeChecker
//
//  Created by Toph Allen on 7/1/20.
//

import SwiftUI

struct PlaylistDetail: View {
    @ObservedObject var playlist: Playlist
    @State var selectedTrack: Track?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Divider().padding(0)
            NavigationView {
                List(selection: $selectedTrack) {
                    ForEach(playlist.playlistTracks?.allObjects.map({($0 as! PlaylistTrack).track}) as! [Track]) { track in
                        TrackRow(track).tag(track)
                    }
                }
                if selectedTrack != nil {
                    TagCloudView(tags: selectedTrack!.vibes?.allObjects.map({($0 as! Vibe).name}) as! [String])
                        .background(Color.windowBackground)
                        .cornerRadius(5)
                } else {
                    Text("No Track Selected")
                }
            }
        }

    }
}

//struct PlaylistDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaylistDetail()
//    }
//}
