//
//  ContentView.swift
//  Shared
//
//  Created by Toph Allen on 6/25/20.
//

import SwiftUI
import CoreData


struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.taskContext) var taskContext

    @FetchRequest(entity: Container.entity(), sortDescriptors: [], predicate: NSPredicate(format: "parent == nil")) var rootContainers: FetchedResults<Container>

    @State private var selectedContainer: Container? = nil
    @State private var selectedTrack: Track? = nil
    @State private var presentingImportView = false

    
    var body: some View {
        Group {
            if presentingImportView == false {
                NavigationView {
                    List(selection: $selectedContainer) {
                        Section(header: Text("Vibes")) {
                            OutlineGroup(rootContainers.filter({$0.inVibeTree == true}).first?.childArray ?? [], children: \.childArray) { vibe in
                                ContainerRow(vibe).tag(vibe)
                            }
                        }
                        Section(header: Text("Playlists")) {
                            OutlineGroup(rootContainers.filter({$0.inVibeTree == false}), children: \.childArray) { vibe in
                                ContainerRow(vibe).tag(vibe)
                            }
                        }
                    }
                    .listStyle(SidebarListStyle())
                    .navigationTitle(selectedContainer != nil ? Text(selectedContainer!.name ?? "") : Text("VibeChecker"))
                    
                    switch selectedContainer {
                    case let vibe as Vibe:
                        List(selection: $selectedTrack) {
                            ForEach(vibe.tracks?.allObjects as! [Track]) { track in
                                TrackRow(track).tag(track)
                            }
                        }
                    case let playlist as Playlist:
                        List(selection: $selectedTrack) {
                            ForEach(playlist.playlistTracks?.allObjects.map({($0 as! PlaylistTrack).track}) as! [Track]) { track in
                                TrackRow(track).tag(track)
                            }
                        }
                    default:
                        Text("No Vibe Selected")
                            .font(.title)
                            .fontWeight(.light)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    
                    Text("stuff goes here")
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            } else {
                EmptyView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbar {
            ToolbarItem {
                Button(action: { presentingImportView = true }, label: {
                    Label("Import Tracks", systemImage: "square.and.arrow.down")
                }).sheet(isPresented: $presentingImportView) {
                    ImportView(importer: ITunesImporter(for: taskContext))
                    .environment(\.managedObjectContext, self.moc)
                    .environment(\.taskContext, self.taskContext)
                }
            }
        }
    }
}



struct ContainerRow: View {
    let container: Container
    init(_ container: Container) {
        self.container = container
    }
    
    var body: some View {
        Label(container.name ?? "", systemImage: imageName(for: type(of: container)))
    }
}


struct TrackRow: View {
    let track: Track
    init(_ track: Track) {
        self.track = track
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(track.title ?? "")
                .font(.headline)
                .lineLimit(1)
            
            Text(track.artistName ?? "")
                .font(.subheadline)
                .lineLimit(1)
                .foregroundColor(.secondary)
        }
        .padding(EdgeInsets(top: 3, leading: 0, bottom: 0, trailing: 0))
    }
}


func imageName(for container: Container.Type) -> String {
    switch container {
    case is Folder.Type:
        return "folder"
    case is Playlist.Type:
        return "music.note.list"
    case is Vibe.Type:
        return "waveform.path.ecg"
    default:
        return ""
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


