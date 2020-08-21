//
//  Sidebar.swift
//  VibeChecker
//
//  Created by Toph Allen on 7/1/20.
//

import SwiftUI


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


struct Sidebar: View {
    var rootContainers: FetchedResults<Container>
//    @Binding var selectedContainer: Container?
    
    var body: some View {

            List {
                NavigationLink(destination: LibraryView()) {
                    Label("Library", systemImage: "books.vertical.fill")
                }
                Label("Songs", systemImage: "music.note")
                Label("Artists", systemImage: "person.fill")
                Label("Albums", systemImage: "square.stack")
                
                Section(header: Text("Vibes")) {
                    OutlineGroup(rootContainers.filter({$0.inVibeTree == true}).first?.childArray ?? [], children: \.childArray) { item in
                        switch item {
                        case let vibe as Vibe:
                            NavigationLink(destination: VibeDetail(vibe: vibe)) {
                                ContainerRow(vibe)
                            }
                        default:
                            ContainerRow(item)
                        }
//                        ContainerRow(item)
//                            .tag(item)
                    }
                }
                
                Section(header: Text("Playlists")) {
                    OutlineGroup(rootContainers.filter({$0.inVibeTree == false}), children: \.childArray) { item in
                        switch item {
                        case let playlist as Playlist:
                            NavigationLink(destination: PlaylistDetail(playlist: playlist)) {
                                ContainerRow(playlist)
                            }
                        default:
                            ContainerRow(item)
                        }

//                        ContainerRow(item)
//                            .tag(item)
                    }
                }
            }
            .listStyle(SidebarListStyle())
//            .navigationTitle(selectedContainer != nil ? Text(selectedContainer!.name ?? "") : Text("VibeChecker"))
    }
}


//struct ContainerList_Previews: PreviewProvider {
//    static var previews: some View {
//        Sidebar()
//    }
//}
