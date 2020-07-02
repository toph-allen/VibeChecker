//
//  LibraryView.swift
//  VibeChecker
//
//  Created by Toph Allen on 7/2/20.
//

import SwiftUI

struct LibraryView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.managedObjectContext) var taskContext
    @Environment(\.presentationMode) var presentationMode
    @FetchRequest(entity: Vibe.entity(), sortDescriptors: [], predicate: nil) var vibes: FetchedResults<Vibe>
    @FetchRequest(entity: Playlist.entity(), sortDescriptors: [], predicate: nil) var playlists: FetchedResults<Playlist>
    @FetchRequest(entity: Folder.entity(), sortDescriptors: [], predicate: nil) var folders: FetchedResults<Folder>
    @FetchRequest(entity: Track.entity(), sortDescriptors: [], predicate: nil) var tracks: FetchedResults<Track>
    

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text("Your VibeChecker Library").font(.headline)
                Text("You have \(tracks.count) Track\(tracks.count == 1 ? "" : "s") in your library, across \(vibes.count) Vibe\(vibes.count == 1 ? "" : "s") and \(playlists.count) Playlist\(playlists.count == 1 ? "" : "s"), organized in \(folders.count) Folder\(folders.count == 1 ? "" : "s").")
                Spacer()
            }
            Spacer()
        }
        .padding()
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
