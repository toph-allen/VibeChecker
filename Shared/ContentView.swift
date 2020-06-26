//
//  ContentView.swift
//  Shared
//
//  Created by Toph Allen on 6/25/20.
//

import SwiftUI



struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.persistentContainer) var persistentContainer
    
    @FetchRequest(entity: Container.entity(), sortDescriptors: [], predicate: NSPredicate(format: "parent == nil")) var rootContainers: FetchedResults<Container>

    @State private var selectedContainer: Container? = nil

    
    var body: some View {
        VStack {
            NavigationView {
                List(selection: $selectedContainer) {
                    Section(header: Text("Playlists")) {
                        OutlineGroup(rootContainers.filter({$0.inPlaylistTree}), children: \.childArray) { playlist in
                            ContainerRow(playlist).tag(playlist)
                        }
                    }
                    Section(header: Text("Vibes")) {
                        OutlineGroup(rootContainers.filter({$0.inVibeTree}), children: \.childArray) { vibe in
                            ContainerRow(vibe).tag(vibe)
                        }
                    }

                }
                .listStyle(SidebarListStyle())
                
//                switch selectedContainer {
//                case let vibe as Vibe:
//                    List {
//                        ForEach(vibe.tracks?.allObjects as! [Track]) { track in
//                            TrackRow(track)
//                        }
//                    }
//                case let playlist as Playlist:
//                    List {
//                        ForEach(playlist.playlistTracks?.allObjects.map({($0 as! PlaylistTrack).track}) as! [Track]) { track in
//                            TrackRow(track)
//                        }
//                    }
//                default:
//                    Text("No Vibe Selected")
//                        .font(.title)
//                        .fontWeight(.light)
//                        .foregroundColor(.secondary)
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                }
                
                Text("No Vibe Selected")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Text("Hello world")
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbar {
            ToolbarItem {
                Button(action: {
                    let taskContext = persistentContainer.newBackgroundContext()
                    taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
                    let importer = ITunesImporter(for: taskContext)

                    importer.importITunesLibrary()

                    // Running this in the background currently causes this to crash.
//                    taskContext.perform {
//                        importer.importITunesLibraryInBatches()
//                    }
                }, label: {
                    Label("Import Tracks", systemImage: "square.and.arrow.down")
                })
            }
        }
    }
}


struct ContainerRow: View {
    let container: Container
    init(_ container: Container) {
        print("")
        self.container = container
    }
    
    var body: some View {
        Label(container.name ?? "", systemImage: imageName(for: container))
    }
}


struct TrackRow: View {
    let track: Track
    init(_ track: Track) {
        self.track = track
    }
    
    var body: some View {
        Text(track.title ?? "").font(.headline)
    }
}


func imageName(for container: Container) -> String {
    switch container {
    case is Folder:
        return "folder"
    case is Playlist:
        return "music.note.list"
    case is Vibe:
        return "tag"
    default:
        return ""
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


