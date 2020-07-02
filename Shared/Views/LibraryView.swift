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
    @FetchRequest(entity: Container.entity(), sortDescriptors: [], predicate: nil) var containers: FetchedResults<Container>
    @FetchRequest(entity: Vibe.entity(), sortDescriptors: [], predicate: nil) var vibes: FetchedResults<Vibe>
    @FetchRequest(entity: Playlist.entity(), sortDescriptors: [], predicate: nil) var playlists: FetchedResults<Playlist>
    @FetchRequest(entity: Folder.entity(), sortDescriptors: [], predicate: nil) var folders: FetchedResults<Folder>
    @FetchRequest(entity: Track.entity(), sortDescriptors: [], predicate: nil) var tracks: FetchedResults<Track>
    

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text("VibeChecker Library").font(.largeTitle)
                Text("Containers: \(containers.count)")
                Text("Vibes: \(vibes.count)")
                Text("Playlists: \(playlists.count)")
                Text("Folders: \(folders.count)")
                Text("Tracks: \(tracks.count)")
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
